class UsersController < ApplicationController
  layout false

  def new
    @user = User.new
    set_teams
  end

  def create
    @user = User.new(user_params)
    set_teams

    if @user.save
      auto_login(@user)
      redirect_to dashboard_path, notice: "ユーザー登録が完了しました"
    else
      flash.now[:alert] = "入力内容をご確認ください"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_teams
    order = Team::ORDER_BY_LAST_SEASON
    @teams = Team.where(name: order).to_a.sort_by { |t| order.index(t.name) }

  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :favorite_team_id)
  end
end
