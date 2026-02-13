# app/controllers/dashboards_controller.rb
class DashboardsController < ApplicationController
  before_action :require_login

  def show
    @games = current_user.games
                         .includes(:opponent_team, :stadium)
                         .order(date: :desc, id: :desc)
  end
end
