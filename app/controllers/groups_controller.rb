class GroupsController < ApplicationController
  before_action :require_login
  before_action :set_group, only: %i[show edit update]
  def index
    @groups = current_user.groups.groups_goals_count.includes(image_attachment: :blob)
  end

  def new
    @group = current_user.groups.build
  end

  def create
    @group = current_user.groups.build(group_params)
    if @group.save
      redirect_to @group, notice: 'Goal Style Added'
    else
      render :new
    end
  end

  def show
    @goals = @group.goals.latest
    @total_goals = @group.goals.sum_goals
  end

  def edit; end

  def update
    if @group.update(group_params)
      redirect_to @group, notice: 'Goal Style Updated'
    else
      render :edit
    end
  end

  def destroy
    @group.destroy
    redirect_to groups_path
  end

  private

  def set_group
    @group = current_user.groups.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:id, :name, :image)
  end

  def require_login
    redirect_to new_session_path unless session[:user_id]
  end
end
