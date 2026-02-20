# app/controllers/dashboards_controller.rb
class DashboardsController < ApplicationController
  before_action :require_login

  def show
    base_games = current_user.games
                             .includes(:opponent_team, :stadium)

    # --- フィルタ適用 ---
    @filter_year     = params[:year].presence
    @filter_opponent = params[:opponent].presence
    @filter_stadium  = params[:stadium].presence

    base_games = base_games.where("EXTRACT(YEAR FROM date) = ?", @filter_year.to_i) if @filter_year
    base_games = base_games.where(opponent_team_id: @filter_opponent)                if @filter_opponent
    base_games = base_games.where(stadium_id: @filter_stadium)                       if @filter_stadium

    # フィルタ後の全件（サマリ計算用）
    @games = base_games.order(date: :desc, id: :desc)

    # --- フィルタ選択肢 ---
    user_games = current_user.games.includes(:opponent_team, :stadium)
    @filter_years    = user_games.distinct.pluck(Arel.sql("EXTRACT(YEAR FROM date)::int")).compact.sort.reverse
    @filter_opponents = user_games.map(&:opponent_team).compact.uniq.sort_by(&:name)
    @filter_stadiums  = user_games.map(&:stadium).compact.uniq.sort_by(&:name)

    # --- サマリ集計（中止を除外） ---
    active_games = @games.reject(&:result_canceled?)

    # 勝敗集計（合計 / ホーム / ビジター）
    @summary = {
      total:   build_record(active_games),
      home:    build_record(active_games.select(&:home_away_home?)),
      visitor: build_record(active_games.select(&:home_away_away?))
    }

    # 中止試合数
    @canceled_count = @games.count(&:result_canceled?)

    # 平均得点・失点
    if active_games.any?
      @avg_scored  = (active_games.sum(&:favorite_team_score).to_f / active_games.size).round(1)
      @avg_allowed = (active_games.sum(&:opponent_score).to_f / active_games.size).round(1)
      @active_game_count = active_games.size
    else
      @avg_scored  = nil
      @avg_allowed = nil
      @active_game_count = 0
    end

    # 直近5試合
    recent_5 = active_games.first(5)
    @recent_5_record = build_record(recent_5)
  end

  private

  # { win: N, lose: N, draw: N, total: N } を返す
  def build_record(games)
    {
      win:   games.count(&:result_win?),
      lose:  games.count(&:result_lose?),
      draw:  games.count(&:result_draw?),
      total: games.size
    }
  end
end
