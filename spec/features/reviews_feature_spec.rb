require 'rails_helper'

feature 'reviewing' do
  before do
    User.create( email: 'test@test.test', password: 'testtest', password_confirmation: 'testtest')
    visit '/'
    click_link 'Sign in'
    fill_in 'Email', with: 'test@test.test'
    fill_in 'Password', with: 'testtest'
    click_button 'Log in'
 end

  scenario 'allows users to leave a review using a form' do
    user = User.first
    user.restaurants.create(name: 'KFC', description: 'so so')
    visit '/restaurants'
    click_link 'Sign out'
    sign_up_user2
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'

    expect(current_path).to eq '/restaurants'
    expect(page).to have_content 'so so'
  end
end
