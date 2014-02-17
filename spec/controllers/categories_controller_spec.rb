require 'spec_helper'

describe CategoriesController do

  describe '#index' do
    let!(:categories) { (1..5).map{ |i| FactoryGirl.create(:category) } }
    it 'shows all the top level categories' do
      get :index
      categories.each do |category|
        expect(assigns(:categories)).to include(category)
      end
    end
  end

  describe '#show' do
    let(:category) { FactoryGirl.create(:category) }
    it 'shows all the subcategories for a category' do
      get :show, id: category.id
      expect(assigns(:category)).to eq(category)
    end
  end

  describe '#new' do
    context 'add a top level category' do
      before do
        get :new
      end
      it { should respond_with :success }
      it 'responds with a new account' do
        expect(assigns(:category)).to be_an_instance_of(Category)
      end
    end
    context 'add a child category' do
      let(:category) { FactoryGirl.create(:category) }
      it 'responds with a new account with a parent id' do
        get :new, parent_id: category.id
        expect(assigns(:category).parent_id).to eq(category.id)
      end
    end
  end

  describe '#create' do
    context 'successfully creates category' do
      it 'redirects to the show page for new category' do
        post :create, category: FactoryGirl.attributes_for(:category)
        expect(response).to redirect_to category_path(Category.last)
      end
      it 'creates a new category' do
        expect {
          post :create, category: FactoryGirl.attributes_for(:category)
        }.to change(Category, :count).by(1)
      end
      it 'gives a success message' do
        post :create, category: FactoryGirl.attributes_for(:category)
        expect(flash[:success]).to eq('Category was successfully created.')
      end
    end
    context 'cannot create category' do
      it 'does not save the new category' do
        expect {
          post :create, category: FactoryGirl.attributes_for(:invalid_category)
        }.to_not change(Category,:count)
      end
      it 'renders the new template' do
        post :create, category: FactoryGirl.attributes_for(:invalid_category)
        expect(response).to render_template :new
      end
      it 'displays the errors with creating the category' do
        post :create, category: FactoryGirl.attributes_for(:invalid_category)
        expect(flash[:error]).to eq('Unable to create category.')
        expect(flash[:errors]).to eq({:name=>["can't be blank"]})
      end
    end
  end

  describe '#edit' do
    let(:category) { FactoryGirl.create(:category) }
    before do
      get :edit, id: category.id
    end
    it { should respond_with :success }
    it 'responds with an existing category' do
      expect(assigns(:category)).to eq(category)
    end
  end

  describe '#update' do
    let(:category) { FactoryGirl.create(:category) }
    context 'successfully updates category' do
      it 'grabs the correct category' do
        put :update, id: category.id, category: FactoryGirl.attributes_for(:category)
        expect(assigns(:category)).to eq(category)
      end
      it 'redirects to the show page for new category' do
        put :update, id: category.id, category: FactoryGirl.attributes_for(:category)
        expect(response).to redirect_to category_path(category)
      end
      it 'updates the correct fields for an category' do
        changed_attributes = FactoryGirl.attributes_for(:category)
        put :update, id: category.id, category: changed_attributes
        expect(category.reload.name).to eq(changed_attributes[:name])
      end
      it 'gives a success message' do
        put :update, id: category.id, category: FactoryGirl.attributes_for(:category)
        expect(flash[:success]).to eq('Category was successfully updated.')
      end
    end
    context 'cannot update category' do
      before do
        put :update, id: category.id, category: FactoryGirl.attributes_for(:invalid_category)
      end
      it 'does not save the new category' do
        expect(assigns(:category)).to eq(category)
      end
      it 'renders the edit template' do
        expect(response).to render_template :edit
      end
      it 'displays the errors with creating the account' do
        expect(flash[:error]).to eq('Unable to update category.')
        expect(flash[:errors]).to eq({:name=>["can't be blank"]})
      end
    end
  end

  describe '#destroy' do
    before :each do
      @category = FactoryGirl.create(:category)
    end
    it 'deletes the category' do
      expect {
        delete :destroy, id: @category.id
      }.to change(Category, :count).by(-1)
    end
    it 'redirects to the index page' do
      delete :destroy, id: @category.id
      expect(response).to redirect_to categories_path()
    end
  end

end