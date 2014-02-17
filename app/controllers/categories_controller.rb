class CategoriesController < ApplicationController

  def index
    @categories = Category.top
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
    @category.update(parent_id: params[:parent_id]) if params[:parent_id].present?
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = 'Category was successfully created.'
      redirect_to category_path(@category)
    else
      flash.now[:error] = 'Unable to create category.'
      flash.now[:errors] = @category.errors.messages
      render action: 'new'
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(category_params)
      flash[:success] = 'Category was successfully updated.'
      redirect_to category_path(@category)
    else
      flash.now[:error] = 'Unable to update category.'
      flash.now[:errors] = @category.errors.messages
      render action: :edit
    end
  end

  def destroy
    Category.find(params[:id]).destroy
    flash[:success] = 'Category was successfully deleted.'
    redirect_to categories_path()
  end

  private

  def category_params
    params.require(:category).permit(:name, :parent_id)
  end

end