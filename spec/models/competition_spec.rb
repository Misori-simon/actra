require 'rails_helper'

RSpec.describe Competition, type: :model do
  let(:user) { User.create(name: 'test_user') }

  it 'Test if competition is valid' do
    competition = Competition.create(user_id: user.id, name: 'Penalty')
    expect(competition.valid?).to be true
  end

  it 'Test if competition without user_id and name is valid' do
    competition = Competition.create
    expect(competition.valid?).to be false
  end

  it 'Test if competition without name is valid' do
    competition = Competition.create(user_id: user.id)
    expect(competition.valid?).to be false
  end

  it 'Test if competition without user_id is valid' do
    competition = Competition.create(name: 'Free kick')
    expect(competition.valid?).to be false
  end

  it 'Test if competition created through  user is valid' do
    competition = user.competitions.create(name: 'Volley')
    expect(competition.valid?).to be true
  end

  it 'Test if competition belongs to user' do
    competition = user.competitions.create(name: 'Panenca')
    expect(competition.user).to eql(user)
  end

  it 'Test if duplicate competition can be created with same name, for same user' do
    competition = user.competitions.create(name: 'Panenca')
    duplicate_competition = Competition.create(user_id: user.id, name: 'Panenca').save
    expect(competition.user).to eql(user)
    expect(duplicate_competition).to be false
  end
end
