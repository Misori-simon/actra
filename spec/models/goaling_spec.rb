require 'rails_helper'

RSpec.describe Goaling, type: :model do
  let(:user) { User.create(name: 'test_user') }
  let(:goal) { user.goals.create(name: 'Arsenal', amount: 1) }
  let(:competition) { user.competitions.create(name: 'La Liga') }

  it 'Test if goaling is valid' do
    goaling = Goaling.create(goal_id: goal.id, competition_id: competition.id)
    expect(goaling.valid?).to be true
  end

  it 'Test if goaling without goal and competition' do
    goaling = Goaling.create
    expect(goaling.valid?).to be false
  end

  it 'Test if goaling without goal is valid' do
    goaling = Goaling.create(competition_id: competition.id)
    expect(goaling.valid?).to be false
  end

  it 'Test if goaling without competition is valid' do
    goaling = Goaling.create(goal_id: goal.id)
    expect(goaling.valid?).to be false
  end

  it 'Test if goaling created through  goal is valid' do
    goaling = goal.goalings.create(competition_id: competition.id)
    expect(goaling.valid?).to be true
  end

  it 'Test if goaling belongs to goal' do
    goaling = goal.goalings.create(competition_id: competition.id)
    expect(goaling.goal).to eql(goal)
  end

  it 'Test if goaling created through  competition is valid' do
    goaling = competition.goalings.create(goal_id: goal.id)
    expect(goaling.valid?).to be true
  end

  it 'Test if goaling belongs to goal' do
    goaling = competition.goalings.create(goal_id: goal.id)
    expect(goaling.goal).to eql(goal)
  end
end
