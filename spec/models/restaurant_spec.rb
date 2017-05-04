require 'rails_helper'



RSpec.describe Restaurant, type: :model do

describe Restaurant, type: :model do
  it 'is not valid with a name of less than three characters' do
    restaurant = Restaurant.new(name: "kf")
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end

  it 'is not valid unless it has a uniqe name' do
    user = User.create(email: 'test@test.test', password: 'testtest', password_confirmation: 'testtest')
    user.restaurants.create(name: "Moe's Tavern")
    restaurant = user.restaurants.create(name: "Moe's Tavern")
    expect(restaurant).to have(1).error_on(:name)
  end


end


end
