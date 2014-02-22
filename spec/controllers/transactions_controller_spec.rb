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

end