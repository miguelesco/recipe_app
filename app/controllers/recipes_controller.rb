class RecipesController < ApplicationController
  load_and_authorize_resource

  def index
    @recipes = if current_user
                 Recipe.where(public: true, user_id: current_user.id)
               else
                 Recipe.where(public: true)
               end
  end

  def show
    @recipe = Recipe.find(params[:id])
    @foods = RecipeFood.where(recipe_id: @recipe.id).includes(:food)
    @ispublic = if current_user
                  @recipe.public? || @recipe.user_id == current_user.id
                else
                  @recipe.public?
                end
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
      flash[:error] = 'Error to update'
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
