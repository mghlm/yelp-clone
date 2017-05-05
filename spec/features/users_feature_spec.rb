require 'rails_helper'

feature "User can sign in and on the homepage" do
  context "user not signed in and on the homepage" do
    it "should see a 'sign in' and a 'sign up' link" do
      visit('/')
      expect(page).to have_link('Sign in')
      expect(page).to have_link('Sign up')
    end
    it "should not see 'sign out' link" do
      visit('/')
      expect(page).not_to have_link('Sign out')
    end

    it "should not see the 'Add a restaurant' link" do
    visit('/')
    expect(page).not_to have_link('Add a restaurant')
    end
  end

  context "user signed in on the homepage" do
    before do
      visit('/')
      click_link('Sign up')
      fill_in('Email', with: 'test@example.com')
      fill_in('Password', with: 'testtest')
      fill_in('Password confirmation', with: 'testtest')
      click_button('Sign up')
    end

    it "should see 'sign out' link" do
      visit('/')
      expect(page).to have_link('Sign out')
    end

    it "should not see a 'sign in' link and a 'sign up' link" do
      visit('/')
      expect(page).not_to have_link('Sign in')
      expect(page).not_to have_link('Sign up')
    end

    # it 'should have association "reviewed_restaurant"' do
    #   click_link('Add a restaurant')
    #   fill_in('Name', with: 'Subway')
    #   fill_in('Description', with: 'Sandwiches')
    #   click_button('Create Restaurant')
    #   click_link('Sign out')
    #   sign_up_user2
    #   click_link('Review Subway')
    #   fill_in "Thoughts", with: "so so"
    #   select '3', from: 'Rating'
    #   click_button 'Leave Review'
    #   require 'pry'; binding.pry
    #   expect(User.second.reviewed_restaurants.name).to eq('Subway')
    # end

  end

end
