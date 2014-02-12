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

  private
  def account_params
    params.require(:account).permit(:name)
  end
end