require 'spec_helper'

describe 'accounts/index.haml' do

  let(:accounts) { (1..5).map{ |i| FactoryGirl.create(:account) } }

  before do
    assign(:accounts, accounts)
    render
  end

  it 'shows a table of accounts' do
    expect(rendered).to have_tag('table#accounts')
    accounts.each do |account|
      expect(rendered).to have_tag('tr td', text: account.name)
      expect(rendered).to have_link('show', href: account_path(account))
      expect(rendered).to have_link('edit', href: edit_account_path(account))
    end
  end

  it 'has a link to create a new account' do
    expect(rendered).to have_link('new', href: new_account_path())
  end

end