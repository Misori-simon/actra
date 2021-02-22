require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create(name: 'test_user') }
  let(:duplicate_user) { User.new(name: 'Test_user') }
  let(:short_name_user) { User.create(name: 'test') }
  let(:no_name_user) { User.create }

  it 'Test if user is valid' do
    expect(user.valid?).to be true
  end

  it 'Test if user without name is valid' do
    expect(no_name_user.valid?).to be false
  end

  it 'Test if user with short name is valid' do
    expect(short_name_user.valid?).to be false
  end

  it 'Test if duplicate user can be created with the same name' do
    user_one = User.create(name: 'Dos Santos').save
    duplicate_user = User.create(name: 'Dos Santos').save
    expect(user_one).to be true
    expect(duplicate_user).to be false
  end
end
