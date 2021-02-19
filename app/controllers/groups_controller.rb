class GroupsController < ApplicationController
  before_action :set_group, only: %i[show edit update destroy]
  def index
    @groups = current_user.groups
  end

  def new
    @group = current_user.groups.build
  end

  def create
    @group = current_user.groups.build(group_params)
    if @group.save
      redirect_to @group, notice: 'Group created'
    else
      render :new
    end
  end

  def show
    @goals = @group.goals
  end

  def edit; end

  def update
    if @group.update(group_params)
      redirect_to @group, notice: 'Group created'
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
    params.require(:group).permit(:id, :name)
  end
end
