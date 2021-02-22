require 'rails_helper'

RSpec.describe Scoring, type: :model do
  let(:user) { User.create(name: 'test_user') }
  let(:goal) { user.goals.create(name: 'Arsenal', amount: 1) }
  let(:group) { user.groups.create(name: 'La Liga') }

  it 'Test if scoring is valid' do
    scoring = Scoring.create(goal_id: goal.id, group_id: group.id)
    expect(scoring.valid?).to be true
  end

  it 'Test if scoring without goal and group' do
    scoring = Scoring.create
    expect(scoring.valid?).to be false
  end

  it 'Test if scoring without goal is valid' do
    scoring = Scoring.create(group_id: group.id)
    expect(scoring.valid?).to be false
  end

  it 'Test if scoring without group is valid' do
    scoring = Scoring.create(goal_id: goal.id)
    expect(scoring.valid?).to be false
  end

  it 'Test if scoring created through  goal is valid' do
    scoring = goal.scorings.create(group_id: group.id)
    expect(scoring.valid?).to be true
  end

  it 'Test if scoring belongs to goal' do
    scoring = goal.scorings.create(group_id: group.id)
    expect(scoring.goal).to eql(goal)
  end

  it 'Test if scoring created through  group is valid' do
    scoring = group.scorings.create(goal_id: goal.id)
    expect(scoring.valid?).to be true
  end

  it 'Test if scoring belongs to goal' do
    scoring = group.scorings.create(goal_id: goal.id)
    expect(scoring.goal).to eql(goal)
  end
end
