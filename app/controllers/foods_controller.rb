class FoodsController < ApplicationController
  def index 
    @foods = Food.all
  end

  def new
    @food = Food.new
  end

  def create
    new_food = Food.create(name: food_params[:name], measurement_unit: food_params[:measurement_unit], price: food_params[:price], user_id: current_user.id)
    respond_to do |format|
      format.html do
        if new_food.save
          flash[:notice] = 'Food successfully created'
          redirect_to "/foods"
        else
          flash[:notice] = 'It was not possible to save the Food'
          redirect_to '/foods/new'
        end
      end
    end
  end

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price)
  end

  def destroy
    Food.find(params[:id]).destroy
    redirect_to "/foods"
  end
end
