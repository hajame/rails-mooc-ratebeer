class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    return nil if session[:user_id].nil?

    User.find(session[:user_id])
  end

  def ensure_that_signed_in
    redirect_to signin_path, notice: 'You should be signed in.' if current_user.nil?
  end

  def ensure_that_is_admin
    is_admin = current_user.admin?
    redirect_to signin_path, alert: 'Unauthorized request.' unless is_admin
  end
end
