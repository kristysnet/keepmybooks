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

  describe '#is_deposit' do
    let(:transaction) { create(:transaction) }
    it 'returns true if is a deposit' do
      transaction.update_attributes(deposit: true)
      expect(transaction.is_deposit?).to be(true)
    end
    it 'returns false if it is not a deposit' do
      transaction.update_attributes(deposit: false)
      expect(transaction.is_deposit?).to be(false)
    end
  end

  describe '#amount_value' do
    let(:transaction) { create(:transaction) }
    it 'returns a positive number if deposit' do
      transaction.update_attributes(deposit: true)
      expect(transaction.amount_value).to eq(transaction.amount)
    end
    it 'returns a negative number if not deposit' do
      transaction.update_attributes(deposit: false)
      expect(transaction.amount_value).to eq(0-transaction.amount)
    end

  end
end