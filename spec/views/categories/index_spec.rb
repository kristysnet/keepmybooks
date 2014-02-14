require 'spec_helper'

describe 'categories/index.haml' do

  let(:categories) { (1..5).map{ |i| FactoryGirl.create(:category) } }

  before do
    assign(:categories, categories)
    render
  end

  it 'shows a table of categories' do
    expect(rendered).to have_tag('table#categories')
    categories.each do |category|
      expect(rendered).to have_tag('tr td', text: category.name)
      expect(rendered).to have_link('show', href: category_path(category))
      expect(rendered).to have_link('edit', href: edit_category_path(category))
    end
  end

end