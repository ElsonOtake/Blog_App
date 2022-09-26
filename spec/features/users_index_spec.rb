require 'rails_helper'
require_relative '../config/environment'

RSpec.describe 'user index view', type: :feature do
  describe 'GET index' do
    before(:each) do
      @user_one = User.create(name: 'Addisu', photo: 'img_1.png', bio: 'Physics teacher', posts_counter: 2)
      @user_one.save!
      @user_two = User.create(name: 'Yonas', photo: 'img_2.png', bio: 'Front-end developer', posts_counter: 3)
      @user_two.save!
    end

    it 'Show username of each user' do
      visit root_path
      expect(page).to have_content('Addisu')
      expect(page).to have_content('Yonas')
    end

    it 'Shows the uses profile picture' do
      visit root_path
      expect(page).to have_css('img[src*="img_1.png"]')
      expect(page).to have_css('img[src*="img_2.png"]')
    end

    it 'Shows the number of posts of each user' do
      visit root_path
      expect(page).to have_content('2')
      expect(page).to have_content('3')
    end
  end
end
