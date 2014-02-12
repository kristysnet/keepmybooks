require 'spec_helper'

describe 'accounts/edit.haml' do
  let(:account) { FactoryGirl.create(:account) }
  before do
    assign(:account, account)
    render
  end

  it 'shows an edit account form' do
    expect(rendered).to have_tag("form[method=post][action=\"/accounts/#{account.id}\"]")
    expect(rendered).to have_tag("input#account_name[type=text][name=\"account[name]\"][value=\"#{account.name}\"]")
    expect(rendered).to have_tag('input[type=submit][value="Update Account"]')
  end

end