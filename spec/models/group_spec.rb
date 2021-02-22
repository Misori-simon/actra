require 'rails_helper'

RSpec.describe Group, type: :model do
  let(:user) { User.create(name: 'test_user') }

  it 'Test if group is valid' do
    group = Group.create(user_id: user.id, name: 'Penalty')
    expect(group.valid?).to be true
  end

  it 'Test if group without user_id and name is valid' do
    group = Group.create
    expect(group.valid?).to be false
  end

  it 'Test if group without name is valid' do
    group = Group.create(user_id: user.id)
    expect(group.valid?).to be false
  end

  it 'Test if group without user_id is valid' do
    group = Group.create(name: 'Free kick')
    expect(group.valid?).to be false
  end

  it 'Test if group created through  user is valid' do
    group = user.groups.create(name: 'Volley')
    expect(group.valid?).to be true
  end

  it 'Test if group belongs to user' do
    group = user.groups.create(name: 'Panenca')
    expect(group.user).to eql(user)
  end

  it 'Test if duplicate group can be created with same name, for same user' do
    group = user.groups.create(name: 'Panenca')
    duplicate_group = Group.create(user_id: user.id, name: 'Panenca').save
    expect(group.user).to eql(user)
    expect(duplicate_group).to be false
  end
end
