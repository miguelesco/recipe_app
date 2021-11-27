class FoodsController < ApplicationController
  def index
    @foods = Food.all
  end

  def new
    @food = Food.new
  end

  def create
    new_food = current_user.foods.create(food_params)
    respond_to do |format|
      format.html do
        if new_food.save
          flash[:notice] = 'Food successfully created'
          redirect_to '/foods'
        else
          flash[:notice] = 'It was not possible to save the Food'
          redirect_to '/foods/new'
        end
      end
    end
  end

  def destroy
    Food.find(params[:id]).destroy
    redirect_to '/foods'
  end

  private 

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price)
  end
end
