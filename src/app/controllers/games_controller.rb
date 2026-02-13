class GamesController < ApplicationController
  before_action :require_login
  before_action :load_masters, only: %i[new create edit update]
  before_action :set_game, only: %i[show edit update destroy]

  def new
    @game = current_user.games.build
  end

  def create
    @game = current_user.games.build(game_params)

    if @game.save
      redirect_to dashboard_path, notice: "試合記録を登録しました"
    else
      flash.now[:alert] = "入力内容を確認してください"
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @game.update(game_params)
      redirect_to dashboard_path, notice: "試合記録を更新しました"
    else
      flash.now[:alert] = "入力内容を確認してください"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @game.destroy!
    redirect_to dashboard_path, notice: "試合記録を削除しました"
  end

  private

  def set_game
    @game = current_user.games.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to dashboard_path, alert: "その投稿は表示できません"
  end

  def load_masters
    @teams = Team.order(:id)
    @stadiums = Stadium.order(:id)
  end

  def game_params
    params.require(:game).permit(
      :date,
      :home_away,
      :opponent_team_id,
      :stadium_id,
      :custom_stadium_name,
      :favorite_team_score,
      :opponent_score,
      :starting_pitcher,
      :video_url,
      photos: []
    )
  end
end
