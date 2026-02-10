class GamesController < ApplicationController
  before_action :require_login
  before_action :load_masters, only: %i[new create]

  def new
    @game = current_user.games.new
  end

  def create
    @game = current_user.games.new(game_params)

    if @game.save
      redirect_to dashboard_path, notice: "試合記録を登録しました"
    else
      flash.now[:alert] = "入力内容を確認してください"
      render :new, status: :unprocessable_entity
    end
  end

  private

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
