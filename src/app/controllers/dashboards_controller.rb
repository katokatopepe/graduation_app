class DashboardsController < ApplicationController
  before_action :require_login

  def show
    @games = current_user.games.order(date: :desc, id: :desc)
  end
end
