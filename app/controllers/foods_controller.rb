class FoodsController < ApplicationController
  def index 
    @foods = Food.all
  end

  def create 
  end

  def show
  end
end
