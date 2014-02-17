require 'spec_helper'

describe Transaction do

  it { should validate_presence_of(:category) }
  it { should validate_presence_of(:account) }
  it { should validate_presence_of(:amount) }
  it { should validate_presence_of(:receiver) }
  it { should validate_presence_of(:transaction_date) }
  it { should belong_to(:account) }
  it { should belong_to(:category) }

  it 'validates transaction date as an invalid date' do
    transaction = Transaction.new(transaction_date: 'not a date')
    transaction.save
    expect(transaction.errors.messages[:transaction_date]).to include('is invalid')
  end
  it 'validates transaction date as a valid date' do
    transaction = Transaction.new(transaction_date: '01/01/2001')
    transaction.save
    expect(transaction.errors.messages[:transaction_date]).to be(nil)
  end
end