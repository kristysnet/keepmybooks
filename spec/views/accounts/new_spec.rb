require 'spec_helper'

describe 'accounts/new.haml' do

  before do
    assign(:account, Account.new)
    render
  end

  it 'shows an empty create account form' do
    expect(rendered).to have_tag('form[method=post][action="/accounts"]')
    expect(rendered).to have_tag('input#account_name[type=text][name="account[name]"]')
    expect(rendered).to have_tag('input[type=submit][value="Create Account"]')
  end

end