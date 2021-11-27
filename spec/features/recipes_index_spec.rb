require 'rails_helper'

RSpec.describe 'Recipe Index Page', type: :features do
  describe 'Recipe model' do
    before :each do
      @user = create(:user)
      @recipe = create(:recipe, user_id: @user.id)
      visit '/users/sign_in'
      fill_in 'Name', with: @user.name
      fill_in 'Password', with: @user.password
      click_on 'Log in'
      visit '/recipes'
    end

    it 'I can see the first recipe description' do
      expect(page).to have_content(@recipe.description)
    end

    it 'I can see the remove button' do
      expect(page).to have_content('Remove')
    end

    it 'When I click on remove button, it deletes the recipe.' do
      find('a', text: 'Remove').click
      expect(page).to_not have_content(@recipe.name)
      expect(page).to_not have_content(@recipe.description)
      expect(current_path).to eq('/recipes')
    end
  end
end