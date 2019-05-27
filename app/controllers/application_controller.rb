class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  impersonates :user
  helper_method :current_user

  # Confirms an admin user.
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

end