require 'rails_helper'

RSpec.describe Goal, type: :model do
  let(:user) { User.create(name: 'test_user') }

  it 'Test if goal is valid' do
    goal = Goal.create(user_id: user.id, name: 'Arsenal', amount: 1)
    expect(goal.valid?).to be true
  end

  it 'Test if goal without user_id, name and amount is valid' do
    goal = Goal.create
    expect(goal.valid?).to be false
  end

  it 'Test if goal without name is valid' do
    goal = Goal.create(user_id: user.id, amount: 1)
    expect(goal.valid?).to be false
  end

  it 'Test if goal without amount is valid' do
    goal = Goal.create(user_id: user.id, name: 'Arsenal')
    expect(goal.valid?).to be false
  end

  it 'Test if goal created through  user is valid' do
    goal = user.goals.create(name: 'Arsenal', amount: 1)
    expect(goal.valid?).to be true
  end

  it 'Test if goal belongs to user' do
    goal = user.goals.create(name: 'Arsenal', amount: 1)
    expect(goal.user).to eql(user)
  end
end
