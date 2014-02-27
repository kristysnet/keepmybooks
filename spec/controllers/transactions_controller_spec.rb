require 'spec_helper'

describe TransactionsController do

  describe '#index' do
    let(:account) { create(:account) }
    let!(:transaction) { create(:transaction, account: account) }
    before do
      get :index, account_id: account.id
    end
    it { should respond_with :success }
    it 'responds with all the transactions in a given account' do
      expect(assigns(:transactions)).to include(transaction)
    end
  end

  describe '#create' do
    let(:json) { JSON.parse(response.body) }
    context 'successfully creates a transaction' do
      let(:transaction) { build(:transaction) }
      it 'responds with a new transaction' do
        post :create, account_id: transaction.account_id, transaction: transaction.attributes.symbolize_keys, format: :json
        expect(json['account_id']).to eq(transaction.account_id)
        expect(json['receiver']).to eq(transaction.receiver)
        expect(json['amount']).to eq(transaction.amount)
      end
      it 'creates a new account' do
        expect {
          post :create, account_id: transaction.account_id, transaction: transaction.attributes.symbolize_keys, format: :json
        }.to change(Transaction, :count).by(1)
      end
    end
    context 'cannot create account' do
      let(:account) { create(:account) }
      it 'does not save the new account' do
        expect {
          post :create, account_id: account.id, transaction: attributes_for(:transaction), format: :json
        }.to_not change(Transaction,:count)
      end
      it 'responds with an error message' do
        post :create, account_id: account.id, transaction: attributes_for(:invalid_transaction), format: :json
        expect(json['errors']).to include({ 'receiver' => ['can\'t be blank'] })
      end
    end
  end

end