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
end