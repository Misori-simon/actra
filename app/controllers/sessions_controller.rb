class SessionsController < ApplicationController
  def new; end

  def create
    params[:name].downcase!
    user = User.find_by(name: params[:name])
    if user
      session[:user_id] = user.id
      redirect_to root_path, notice: 'Logged in!'
    else
      p 'failed'
      flash.now.alert = 'User not found'
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to new_session_path, notice: 'Logged out!'
  end
end
