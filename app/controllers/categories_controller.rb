class CategoriesController < ApplicationController

  def index
    @categories = Category.top
  end
end