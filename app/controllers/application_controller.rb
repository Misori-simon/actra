class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user
  end

  def no_competiton_message
    'No Competitions yet, add a competition' if @competitions.empty?
  end

  def no_group_message
    'No groups yet, add a group' if @groups.empty?
  end

  def no_goal_message
    'No goals yet, add a goal' if @goals.empty?
  end
end
