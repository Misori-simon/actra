class CompetitionsController < ApplicationController
  before_action :set_competition, only: %i[show edit update destroy]
  def index
    @competitions = current_user.competitions
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
end
