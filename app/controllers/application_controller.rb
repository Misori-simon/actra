class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?, :no_competiton_message, :no_group_message,
                :no_goal_message, :group_absent?, :competition_absent?,
                :read_date, :read_time, :display_form_errors, :display_login_navigation,
                :display_notice, :display_errors

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

  def display_form_errors(obj)
    return unless obj.errors.any?

    errors = "<div id='error_explanation'>"
    errors += '<h2>'
    errors += pluralize(obj.errors.count, 'error')
    errors += 'prohibited this user from signing up:</h2>'
    errors += '<ul>'

    obj.errors.full_messages.each do |message|
      errors += '<li>'
      errors += message
      errors += '</li>'
    end
    errors += '</ul>'
    errors += '</div>'
  end

  def display_login_navigation
    if logged_in?
      nav = view_context.link_to current_user.name.capitalize.to_s, current_user
      nav += view_context.link_to 'Logout', session_path, method: :delete, class: 'btn-ter'
    else
      nav = view_context.link_to('Sign Up', new_user_path, class: 'btn-ter')
      nav += view_context.link_to('Log In', new_session_path, class: 'btn-ter')
    end
    nav
  end

  def display_notice
    return unless notice.present?

    output = "<div class='notice'>"
    output += ' <p>'
    output += notice
    output += '</p>'
    output += '</div>'
    output
  end

  def display_errors
    return unless alert.present?

    output = "<div class='alert'>"
    output += ' <p>'
    output += alert
    output += '</p>'
    output += '</div>'
    output
  end
end
