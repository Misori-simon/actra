class UsersController < ApplicationController
  before_action :require_login, except: %i[index new create]
  def new
    @user = User.new
  end

  def index
    @users = User.all
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, notice: 'Thank you for signing up!'
    else
      render :new
    end
  end

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.save
      redirect_to @user, notice: 'Thank you for signing up!'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:id, :name)
  end

  def require_login
    redirect_to new_session_path unless session[:user_id]
  end
end
