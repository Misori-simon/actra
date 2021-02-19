class GoalsController < ApplicationController
  before_action :set_goal, only: %i[show edit update]
  def index
    @goals = current_user.goals
  end

  def new
    @goal = current_user.goals.build
    @groups = current_user.groups
  end

  def create
    @goal = current_user.goals.build(goal_params)
    if @goal.save
      create_scoring_from_groups(params[:group_ids])
      redirect_to goals_path, notice: 'goal(s) was recorded'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @goal.update(goal_params)
      redirect_to goals_path, notice: 'goal(s) was recorded'
    else
      render :edit
    end
  end

  private

  def set_goal
    @goal = current_user.goals.find(goal_params)
  end

  def goal_params
    params.require(:goal).permit(:id, :name, :amount)
  end

  def create_scoring_from_groups(arr)
    arr.each do |g|
      group = Group.find(g.to_i)
      group.create_scoring
    end
  end

  def scoring_params
    params.require(:group_ids)
  end
end
