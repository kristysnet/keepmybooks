require 'spec_helper'

describe 'categories/show.haml' do

  let(:category) { FactoryGirl.create(:category) }
  let!(:children) { (1..5).map{ |i| FactoryGirl.create(:sub_category, parent: category)} }

  before do
    assign(:category, category)
    render
  end

  it 'shows the name of the category' do
    expect(rendered).to have_tag('h1', text: category.name)
  end

  it 'shows a table of children' do
    expect(rendered).to have_tag('table#children')
    children.each do |child|
      expect(rendered).to have_tag('tr td', text: child.name)
      expect(rendered).to have_link('show', href: category_path(child))
      expect(rendered).to have_link('edit', href: edit_category_path(child))
    end
  end

end