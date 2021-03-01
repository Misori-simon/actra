class CompetitionsController < ApplicationController
  before_action :require_login
  before_action :set_competition, only: %i[show edit update]
  def index
    @competitions = current_user.competitions.competitions_goals_count.includes(image_attachment: :blob)
  end

  def new
    @competition = current_user.competitions.build
  end

  def create
    @competition = current_user.competitions.build(competition_params)
    if @competition.save
      redirect_to @competition, notice: 'New Competition added'
    else
      render :new
    end
  end

  def show
    @goals = @competition.goals
    @total_goals = @competition.goals.sum_goals
  end

  def edit; end

  def update
    if @competition.update(competition_params)
      redirect_to @competition, notice: 'Competition Updated'
    else
      render :edit
    end
  end

  def destroy
    @competition.destroy
    redirect_to competitions_path
  end

  private

  def set_competition
    @competition = current_user.competitions.find(params[:id])
  end

  def competition_params
    params.require(:competition).permit(:id, :name, :image)
  end

  def require_login
    redirect_to new_session_path unless session[:user_id]
  end
end
