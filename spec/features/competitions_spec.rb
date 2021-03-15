require 'rails_helper'

RSpec.describe 'Competitions features' do
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

  it 'visits competitions/new and create competition' do
    visit('competitions/new')
    expect(page).to have_content 'NEW COMPETITION'
    fill_in 'competition[name]', with: 'Friendly'
    click_button 'commit'
    expect(page).to have_content 'New Competition added'
  end

  it 'Edits competition' do
    visit('competitions/new')
    expect(page).to have_content 'NEW COMPETITION'
    fill_in 'competition[name]', with: 'Friendly'
    click_button 'commit'
    expect(page).to have_content 'New Competition added'
    click_link 'Edit'
    fill_in 'competition[name]', with: 'Friendlies'
    click_button 'commit'
    expect(page).to have_content 'Competition Updated'
  end
end
