class CategoriesController < ApplicationController

  def index
    @categories = Category.top
  end

  def show
    @category = Category.find(params[:id])
  end
end