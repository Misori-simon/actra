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
      group_ids = params[:group_ids]
      group_ids.map!(&:to_i)
      group_ids.each do |id|
        group = Group.find(id)
        scoring = group.scorings.new({goal: @goal})
        render edit_goal(@goal) unless scoring.save
      end
      redirect_to goals_path
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

  def scoring_params
    params.require(:group_ids)
  end
end
