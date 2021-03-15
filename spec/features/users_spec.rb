require 'rails_helper'

RSpec.describe 'user features' do
  before do
    User.create(name: 'JohnDoe')
  end

  def login
    visit('/session/new')
    within('#session') do
      fill_in 'name', with: 'JohnDoe'
    end
    click_button 'Log In'
  end

  it 'Takes user to profile page after login' do
    login
    expect(page).to have_content 'Logged in'
    expect(page).to have_content 'JohnDoe'.capitalize
    expect(page).to have_content 'Goals Scored:'
    expect(page).to have_content 'Profile Settings'
    expect(page).to have_content 'Goals'
    expect(page).to have_content 'Goal Styles'
    expect(page).to have_content 'Competitions'
  end

  it 'Takes user to Edit profile after clicking profile settings' do
    login
    expect(page).to have_content 'Logged in'
    click_link 'Profile Settings'
    expect(page).to have_content 'Edit Profile'
    edit_profile_link = current_path
    fill_in 'user[name]', with: 'Cristiano'
    click_button 'commit'
    expect(page).to have_content 'Profile Updated'
    expect(current_path).not_to eq(edit_profile_link)
  end

  it 'Creates a new user' do
    visit('/users/new')
    expect(page).to have_content 'Create Account'
    sign_up_link = current_path
    fill_in 'user[name]', with: 'Cristiano'
    click_button 'commit'
    expect(page).to have_content 'Thank you for signing up'
    expect(current_path).not_to eq(sign_up_link)
  end
end
