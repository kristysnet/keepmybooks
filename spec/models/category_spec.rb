require 'spec_helper'

describe Category do

  it { should validate_presence_of(:name) }
  it { should belong_to(:parent) }
  it { should have_many(:children) }

  describe '#top' do
    let(:categories) { (1..5).map{ |i| FactoryGirl.create(:category) } }
    let(:sub_categories) { (1..5).map{ |i| FactoryGirl.create(:sub_category) } }
    it 'displays only top level categories' do
      categories.each do |category|
        expect(Category.top).to include(category)
      end
      sub_categories.each do |subcategory|
        expect(Category.top).to_not include(subcategory)
      end
    end
  end
end