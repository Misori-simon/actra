require 'rails_helper'

RSpec.describe 'groups features' do
  before do
    User.create(name: 'JohnDoe')
  end
  before :each do
    visit('/session/new')
    within('#session') do
      fill_in 'name', with: 'JohnDoe'
    end
    click_button 'Log In'
  end

  it 'visits groups/new and create group' do
    visit('groups/new')
    expect(page).to have_content 'NEW GOAL STYLE'
    fill_in 'group[name]', with: 'Header'
    click_button 'commit'
    expect(page).to have_content 'Goal Style Added'
  end

  it 'Edits group' do
    visit('groups/new')
    expect(page).to have_content 'NEW GOAL STYLE'
    fill_in 'group[name]', with: 'Header'
    click_button 'commit'
    expect(page).to have_content 'Goal Style Added'
    click_link 'Edit'
    fill_in 'group[name]', with: 'Friendlies'
    click_button 'commit'
    expect(page).to have_content 'Goal Style Updated'
  end
end
