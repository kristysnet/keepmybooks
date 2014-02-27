class TransactionsController < ApplicationController
  before_filter :load_account
  respond_to :html, :json

  def index
    @transactions = Transaction.where(account_id: @account.id).order('transaction_date desc')
  end

  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.account_id = @account.id
    if @transaction.save
      respond_with @transaction, status: :created, location: nil
    else
      respond_with({errors: @transaction.errors}, status: :unprocessable_entity, location: nil)
    end
  end

  private

  def load_account
    @account ||= Account.find(params[:account_id])
  end

  def transaction_params
    params.require(:transaction).permit(:transaction_date, :category_id, :amount, :receiver, :note)
  end


end