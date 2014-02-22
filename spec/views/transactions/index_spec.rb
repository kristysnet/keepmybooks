require 'spec_helper'

describe 'transactions/index.haml' do

  let(:account) { create(:account) }
  let(:transactions) { (1..5).map{ |i| create(:transaction, account: account) } }

  before do
    transactions.first.update_attributes(deposit: true)
    transactions.last.update_attributes(deposit: false)
    assign(:transactions, transactions)
    render
  end

  it 'shows a table of accounts' do
    expect(rendered).to have_tag('table#transactions')
    transactions.each do |transaction|
      expect(rendered).to have_tag('tr td', text: transaction.receiver)
      expect(rendered).to have_tag('tr td', text: transaction.transaction_date.strftime('%m/%d/%Y'))
      expect(rendered).to have_tag('tr td', text: transaction.category.name)
      expect(rendered).to have_tag("form[action=\"/accounts/#{transaction.account.id}/transactions/#{transaction.id}\"][method=post] input[name=_method][type=hidden][value=delete]")
    end
    expect(rendered).to have_tag('tr td', text: "#{number_with_precision(transactions.first.amount, precision: 2)}")
    expect(rendered).to have_tag('tr td', text: "-#{number_with_precision(transactions.last.amount, precision: 2)}")
  end


end