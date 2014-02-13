class AccountsController < ApplicationController

  def index
    @accounts = Account.all
  end

  def new
    @account = Account.new
  end

  def create
    @account = Account.new(account_params)
    if @account.save
      flash[:success] = 'Account was successfully created.'
      redirect_to account_path(@account)
    else
      flash.now[:error] = 'Unable to create account.'
      flash.now[:errors] = @account.errors.messages
      render action: 'new'
    end
  end

  def edit
    @account = Account.find(params[:id])
  end

  def update
    @account = Account.find(params[:id])
    if @account.update_attributes(account_params)
      flash[:success] = 'Account was successfully updated.'
      redirect_to account_path(@account)
    else
      flash.now[:error] = 'Unable to update account.'
      flash.now[:errors] = @account.errors.messages
      render action: :edit
    end
  end

  def destroy
    Account.find(params[:id]).destroy
    flash[:success] = 'Account was successfully deleted.'
    redirect_to accounts_path()
  end

  private
  def account_params
    params.require(:account).permit(:name)
  end
end