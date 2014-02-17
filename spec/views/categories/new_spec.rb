require 'spec_helper'

describe 'categories/new.haml' do

  before do
    assign(:category, Category.new)
    render
  end

  it 'shows an empty create category form' do
    expect(rendered).to have_tag('form[method=post][action="/categories"]')
    expect(rendered).to have_tag('input#category_name[type=text][name="category[name]"]')
    expect(rendered).to have_tag('input#category_parent_id[type=hidden]')
    expect(rendered).to have_tag('input[type=submit][value="Create Category"]')
  end

end