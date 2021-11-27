class GeneralShoppingListController < ApplicationController
  def index
    if current_user
      @recipes = current_user.recipes
      db_foods = Food.includes(:recipe_foods).where.not('recipe_foods.id' => nil)
      @total_price_all = 0.0

      @foods = db_foods.map do |food|
        total_quantity = food.recipe_foods.reduce(0) do |food_quantity, recipe_food|
          food_quantity + recipe_food.quantity
        end

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
    else
      redirect_to root_path
    end
  end
end
