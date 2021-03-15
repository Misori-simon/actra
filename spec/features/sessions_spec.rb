require 'rails_helper'

RSpec.describe 'Session features' do
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

  it 'Logs me in' do
    expect(page).to have_content 'Logged in'
  end

  it 'Logs me out' do
    expect(page).to have_content 'Logged in'
    click_link 'Logout'
    expect(page).to have_content 'Logged out'
  end
end
