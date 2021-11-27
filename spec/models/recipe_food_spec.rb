require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let!(:user) { create(:user) }

  describe 'Recipe model' do
    before :each do
      @recipe = build(:recipe)
      @recipe.user = user
      @food = build(:food)
      @food.user = user
      @recipe_food = build(:recipe_food)
      @recipe_food.recipe = @recipe
      @recipe_food.food = @food
    end

    it 'should be valid' do
      expect(@recipe_food).to be_valid
    end
  end
end
