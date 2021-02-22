class GoalsController < ApplicationController
  before_action :require_login, only: %i[index new create]
  def index
    @goals = current_user.goals
  end

  def new
    if group_absent?
      redirect_to new_group_path, notice: 'Add a Goal Style'
    elsif competition_absent?
      redirect_to new_competition_path, notice: 'Add a Competition '
    else
      @goal = current_user.goals.build
      @groups = current_user.groups
      @competitions = current_user.competitions
    end
  end

  def create
    @goal = current_user.goals.build(goal_params)
    if @goal.save
      if create_scoring && create_goaling
        redirect_to goals_path, notice: 'Goal saved'
      else
        redirect_to goals_path, notice: 'Failed to associate goal with style/competition'
      end
    else
      render :new
    end
  end

  private

  def set_goal
    @goal = current_user.goals.find(goal_params)
  end

  def goal_params
    params.require(:goal).permit(:id, :name, :amount)
  end

  def create_scoring
    group = Group.find(params[:group_id])
    scoring = group.scorings.new({ goal: @goal })
    scoring.save
  end

  def create_goaling
    competition = Competition.find(params[:competition_id])
    goaling = competition.goalings.new({ goal: @goal })
    goaling.save
  end

  def require_login
    redirect_to new_session_path unless session[:user_id]
  end

  def group_absent?
    Group.all.empty?
  end

  def competition_absent?
    Competition.all.empty?
  end
end
