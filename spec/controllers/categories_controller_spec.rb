require 'spec_helper'

describe CategoriesController do

  describe '#index' do
    let!(:categories) { (1..5).map{ |i| FactoryGirl.create(:category) } }
    it 'shows all the top level categories' do
      get :index
      categories.each do |category|
        expect(assigns(:categories)).to include(category)
      end
    end
  end

  describe '#show' do
    let(:category) { FactoryGirl.create(:category) }
    it 'shows all the subcategories for a category' do
      get :show, id: category.id
      expect(assigns(:category)).to eq(category)
    end
  end
end