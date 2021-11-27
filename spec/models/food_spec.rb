require 'rails_helper'

RSpec.describe Food, type: :model do
  let!(:user) { create(:user) }
  let!(:second_user) { create(:user) }

  describe 'Food model' do
    before :each do
      @food = build(:food)
      @food.user = user
      @second_food = build(:food)
      @second_food.user = second_user
    end

    it 'should be valid' do
      expect(@food).to be_valid
    end

    it 'should not be valid with empty fields' do
      @food.name = nil
      expect(@food).to_not be_valid
    end

    it 'should not be valid with empty fields' do
      @food.measurement_unit = nil
      expect(@food).to_not be_valid
    end

    it 'should not be valid with empty fields' do
      @food.price = nil
      expect(@food).to_not be_valid
    end

    it 'should not be valid with incorrect string for measure units' do
      @food.measurement_unit = 'not a valid string'
      expect(@food).to_not be_valid
    end

    it 'should not be valid if food with same name already exists in same user' do
      @second_food.name = @food.name
      @second_food.user = @food.user
      @food.save
      expect(@second_food).to_not be_valid
    end

    it 'should be valid if food with same name exists on other user' do
      @second_food.name = @food.name
      @food.save
      expect(@second_food).to be_valid
    end
  end
end