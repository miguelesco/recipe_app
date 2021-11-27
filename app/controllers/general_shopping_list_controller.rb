class GeneralShoppingListController < ApplicationController
  def index 
    @recipes = current_user.recipes
    dbFoods = Food.includes(:recipe_foods).where.not('recipe_foods.id' => nil)
    @total_price_all = 0.0;

    @foods = dbFoods.map do |food|
      total_quantity = food.recipe_foods.reduce(0) { |food_quantity, recipe_food| food_quantity + recipe_food.quantity }
      
      total_price = total_quantity * food.price
      @total_price_all += total_price
      {
        'id' => food.id,
        'name' => food.name,
        'quantity' => total_quantity,
        'measurement_unit' => food.measurement_unit,
        'price' => food.price,
        'total_price' => total_price
      }
    end
  end

end
