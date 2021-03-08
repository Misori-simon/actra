class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?, :no_competiton_message, :no_group_message,
                :no_goal_message, :group_absent?, :competition_absent?,
                :read_date, :read_time

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
    'No goal styles yet, add a group' if @groups.empty?
  end

  def no_goal_message
    'No goals yet, add a goal' if @goals.empty?
  end

  def group_absent?
    current_user.groups.all.empty?
  end

  def competition_absent?
    current_user.competitions.all.empty?
  end

  def read_date(date)
    date.strftime('%I:%M%p, %m/%d/%Y')
  end
end
