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
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'Thank you for signing up!'
    else
      render :new
    end
  end

  def show
    @user = current_user
    @goals = current_user.goals.latest
    @total_goals = current_user.goals.sum_goals
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

  def my_competitions
    @user = current_user
    @competitions = current_user.competitions.competitions_goals_count.includes(image_attachment: :blob)
    @total_goals = current_user.goals.sum_goals
  end

  def my_groups
    @user = current_user
    @groups = current_user.groups.groups_goals_count.includes(image_attachment: :blob)
    @total_goals = current_user.goals.sum_goals
  end

  private

  def user_params
    params.require(:user).permit(:id, :name, :image)
  end

  def require_login
    redirect_to new_session_path unless session[:user_id]
  end
end
