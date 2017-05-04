require 'rails_helper'

feature 'restaurants' do
  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
    end
  end

  context 'restaurants have been added' do
    before do
      Restaurant.create(name: 'KFC')
    end

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content('KFC')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'creating restaurants' do
    scenario 'prompts user to fill out a form, then dsipalys the new restaurant' do
      sign_up
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'KFC'
      click_button 'Create Restaurant'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq '/restaurants'
    end

    context 'an invalid restaurant' do
      scenario 'does not let you submit a name that is too short' do
        sign_up
        visit '/restaurants'
        click_link 'Add a restaurant'
        fill_in 'Name', with: 'kf'
        click_button 'Create Restaurant'
        expect(page).not_to have_css 'h2', text: 'kf'
        expect(page).to have_content 'error'
      end
    end
   end

  context 'viewing restaurants' do

    let!(:kfc) {Restaurant.create(name: 'KFC') }

    scenario 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link 'KFC'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq "/restaurants/#{kfc.id}"
    end
  end

  context 'editing restaurants' do

    before { Restaurant.create name: 'KFC', description: 'Deep fried goodness', id: 1 }
    scenario 'let a user edit a restaurant' do
      sign_up
      visit '/restaurants'
      click_link 'Edit KFC'
      fill_in 'Name', with: 'Kentucky Fried Chicken'
      fill_in 'Description', with: 'Deep fried goodness'
      click_button 'Update Restaurant'
      click_link 'Kentucky Fried Chicken'
      expect(page).to have_content 'Kentucky Fried Chicken'
      expect(page).to have_content 'Deep fried goodness'
      expect(current_path).to eq '/restaurants/1'
    end
  end

  context 'deleting restaurants' do

    before { Restaurant.create name: "KFC", description: "Deep fried goodnes" }

    scenario 'removes a restaurant when a user clicks a delete link' do
      sign_up
      visit '/restaurants'
      click_link 'Delete KFC'
      expect(page).not_to have_content 'KFC'
      expect(page).to have_content 'Restaurant deleted successfully'
    end

    scenario 'can only be deleted by the user who created it' do
      sign_up
      click_link('Add a restaurant')
      fill_in('Name', with: "Subway")
      fill_in('Description', with: "Sandwiches")
      click_button('Create Restaurant')
      click_link('Sign out')
      sign_up_user2
      click_link('Delete Subway')
      expect(page).to have_content("You can only delete your own restaurant")
      expect(page).to have_content("Sandwiches")
    end
  end

end
