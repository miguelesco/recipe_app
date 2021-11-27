require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let!(:user) { create(:user) }

  describe 'Recipe model' do
    before :each do
      @recipe = build(:recipe)
      @recipe.user = user
    end

    it 'should be valid' do
      expect(@recipe).to be_valid
    end

    it 'should not be valid with empty fields' do
      @recipe.name = nil
      expect(@recipe).to_not be_valid
    end

    it 'should not be valid with empty fields' do
      @recipe.preparation_time = nil
      expect(@recipe).to_not be_valid
    end

    it 'should not be valid with empty fields' do
      @recipe.cooking_time = nil
      expect(@recipe).to_not be_valid
    end

    it 'should not be valid with empty fields' do
      @recipe.description = nil
      expect(@recipe).to_not be_valid
    end

    it 'should not be valid with incorrect numerical values' do
      @recipe.preparation_time = -1
      expect(@recipe).to_not be_valid
    end

    it 'should not be valid with incorrect numerical values' do
      @recipe.cooking_time = -21
      expect(@recipe).to_not be_valid
    end
  end
end
