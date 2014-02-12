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
    it 'responds with a new account' do
      expect(assigns(:account)).to be_an_instance_of(Account)
    end
  end

  describe '#create' do
    context 'successfully creates account' do
      it 'redirects to the show page for new account' do
        post :create, account: FactoryGirl.attributes_for(:account)
        expect(response).to redirect_to account_path(Account.last)
      end
      it 'creates a new account' do
        expect {
          post :create, account: FactoryGirl.attributes_for(:account)
        }.to change(Account, :count).by(1)
      end
      it 'gives a success message' do
        post :create, account: FactoryGirl.attributes_for(:account)
        expect(flash[:success]).to eq('Account was successfully created.')
      end
    end
    context 'cannot create account' do
      it 'does not save the new account' do
        expect {
          post :create, account: FactoryGirl.attributes_for(:invalid_account)
        }.to_not change(Account,:count)
      end
      it 'renders the new template' do
        post :create, account: FactoryGirl.attributes_for(:invalid_account)
        expect(response).to render_template :new
      end
      it 'displays the errors with creating the account' do
        post :create, account: FactoryGirl.attributes_for(:invalid_account)
        expect(flash[:error]).to eq('Unable to create account.')
        expect(flash[:errors]).to eq({:name=>["can't be blank"]})
      end
    end
  end

  describe '#edit' do
    let(:account) { FactoryGirl.create(:account) }
    before do
      get :edit, id: account.id
    end
    it { should respond_with :success }
    it 'responds with an existing account' do
      expect(assigns(:account)).to eq(account)
    end
  end

  describe '#update' do
    let(:account) { FactoryGirl.create(:account) }
    context 'successfully updates account' do
      it 'grabs the correct account' do
        put :update, id: account.id, account: FactoryGirl.attributes_for(:account)
        expect(assigns(:account)).to eq(account)
      end
      it 'redirects to the show page for new account' do
        put :update, id: account.id, account: FactoryGirl.attributes_for(:account)
        expect(response).to redirect_to account_path(account)
      end
      it 'updates the correct fields for an account' do
        changed_attributes = FactoryGirl.attributes_for(:account)
        put :update, id: account.id, account: changed_attributes
        expect(account.reload.name).to eq(changed_attributes[:name])
      end
      it 'gives a success message' do
        put :update, id: account.id, account: FactoryGirl.attributes_for(:account)
        expect(flash[:success]).to eq('Account was successfully updated.')
      end
    end
    context 'cannot update account' do
      before do
        put :update, id: account.id, account: FactoryGirl.attributes_for(:invalid_account)
      end
      it 'does not save the new account' do
        expect(assigns(:account)).to eq(account)
      end
      it 'renders the edit template' do
        expect(response).to render_template :edit
      end
      it 'displays the errors with creating the account' do
        expect(flash[:error]).to eq('Unable to update account.')
        expect(flash[:errors]).to eq({:name=>["can't be blank"]})
      end
    end
  end

end