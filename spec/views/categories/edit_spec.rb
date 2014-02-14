require 'spec_helper'

describe 'categories/edit.haml' do
  let(:category) { FactoryGirl.create(:category) }
  before do
    assign(:category, category)
    render
  end

  it 'shows an edit category form' do
    expect(rendered).to have_tag("form[method=post][action=\"/categories/#{category.id}\"]")
    expect(rendered).to have_tag("input#category_name[type=text][name=\"category[name]\"][value=\"#{category.name}\"]")
    expect(rendered).to have_tag('input[type=submit][value="Update Category"]')
  end

end