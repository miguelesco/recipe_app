require 'rails_helper'

RSpec.describe 'Recipe Index Page', type: :features do
  describe 'Recipe model' do
    before :each do
      @user = create(:user)
      @second_user = create(:user)
      @recipe = create(:recipe, user_id: @user.id)
      @second_recipe = create(:recipe, user_id: @second_user.id)
      @food = create(:food, user_id: @user.id)
      @recipe_food = create(:recipe_food, recipe_id: @recipe.id, food_id: @food.id)
      visit '/users/sign_in'
      fill_in 'Name', with: @user.name
      fill_in 'Password', with: @user.password
      click_on 'Log in'
      visit "/recipes/#{@recipe.id}"
    end

    it 'I can see the add ingredient button' do
      expect(page).to have_content('Add ingredient')
    end

    it 'When I click on the add ingredient button, it redirects me to a page to add food to the recipe.' do
      find('a', text: 'Add ingredient').click
      expect(current_path).to eq("/recipes/#{@recipe.id}/recipe_foods/new")
    end

    it 'If the user is not the owner of the recipe, he/she should not be able to see the Add ingredient button.' do
      visit "/recipes/#{@second_recipe.id}"
      expect(page).to_not have_selector('a', text: 'Add ingredient')
    end
  end
end
