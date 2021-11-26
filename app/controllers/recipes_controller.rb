class RecipesController < ApplicationController
  load_and_authorize_resource

  before_action :set_user_recipes, only: %i[show update destroy]
  before_action :set_user_recipe, only: %i[show update]

  def index
    @recipes = current_user.recipes
  end

  def public_recipes
    @recipes = Recipe.public_recipes
  end

  def general_shopping_list
    @foods = current_user.foods.includes(:recipe_foods)
  end

  def show
    @recipe = Recipe.find(params[:id])
    @foods = RecipeFood.where(recipe_id: @recipe.id).includes(:food)
    @ispublic = @recipe.public? || @recipe.user_id == current_user.id
  end

  def new
    @recipe = Recipe.new
  end

  def create
    if current_user.recipes.create(recipe_params)
      flash[:notice] = 'Recipe added successfully'
      redirect_to recipes_url
    else
      flash[:error] = 'Recipe couldn\'t be added'
      render :new
    end
  end

  def destroy
    @recipe = current_user.recipes.find(params[:id])
    @recipe.destroy
    if @recipe.destroy
      flash[:notice] = 'Recipe deleted successfully'
    else
      flash[:error] = 'Recipe couldn\'t be deleted'
    end
    redirect_to recipes_url
  end

  def update
    recipe = Recipe.find(params[:id])
    if recipe.update(recipe_public_params)
      flash[:notice] = 'Public modified.'
      redirect_to recipe_path(id: recipe.id)
    else
      flash[:error] = "Error to update"
      render :index
    end
  end

  private

  def set_user_recipe
    @recipe = Recipe.find(params[:id])
    if @recipe.user_id == current_user.id || @recipe.public == true
      @recipe
    else
      flash[:error] = 'You have no access to this page'
      redirect_back(fallback_location: public_recipes_path)
    end
  end

  private

  def recipe_public_params
    params.require(:recipe).permit(:public)
  end

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end

  def set_user_recipes
    @recipes = current_user.recipes
  end
end
