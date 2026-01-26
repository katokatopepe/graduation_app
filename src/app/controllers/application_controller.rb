class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  stale_when_importmap_changes

  private

  def after_login_path_for(_user)
    dashboard_path
  end
end
