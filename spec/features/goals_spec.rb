require 'rails_helper'

RSpec.describe 'Goals features' do
  before do
    @user = User.create(name: 'JohnDoe')
    # user.groups.create(name: 'Penalty')
    # user.competitions.create(name: 'Freindly')
  end
  before :each do
    visit('/session/new')
    within('#session') do
      fill_in 'name', with: 'JohnDoe'
    end
    click_button 'Log In'
  end
  it 'redirects to new goal style if user has no goal styles' do
    visit('goals/new')
    expect(current_path).to eql('/groups/new')
  end

  it 'redirects to new competition if user has goal style but no competiton' do
    @user.groups.create(name: 'Penalty')
    visit('goals/new')
    expect(current_path).to eql('/competitions/new')
  end

  it 'creates new a new goals' do
    @user.groups.create(name: 'Penalty')
    @user.competitions.create(name: 'Friendly')
    visit('/goals/new')
    expect(page).to have_content 'Add Goal'
    fill_in 'goal[name]', with: 'manchester city'
    fill_in 'goal[amount]', with: 2
    select 'Penalty', from: 'group_id'
    select 'Friendly', from: 'competition_id'
    click_button 'commit'
    expect(page).to have_content 'Goal saved'
  end
end
