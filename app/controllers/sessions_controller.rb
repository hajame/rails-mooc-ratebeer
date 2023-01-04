class SessionsController < ApplicationController
  def new
    # renders signup page
  end

  def create
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password]) && !user.closed
      reset_session
      session[:user_id] = user.id
      session[:hello] = user.id
      redirect_to user_path(user), notice: "Welcome back!"
    elsif user&.closed
      redirect_to signin_path, alert: "Your account is locked. Contact Administration."
    else
      redirect_to signin_path, alert: "Username and/or password mismatch"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end
end
