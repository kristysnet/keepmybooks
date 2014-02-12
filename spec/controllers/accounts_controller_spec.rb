require 'spec_helper'

describe AccountsController do

  describe '#index' do
    let!(:account) { FactoryGirl.create(:account) }
    before do
      get :index
    end
    it { should respond_with :success }
    it 'responds with all the accounts' do
      expect(assigns(:accounts)).to include(account)
    end
  end

  describe '#new' do
    before do
      get :new
    end
    it { should respond_with :success }
  end

end