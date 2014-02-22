class TransactionsController < ApplicationController
  before_filter :load_account

  def index
    @transactions = Transaction.where(account_id: @account.id).order('transaction_date desc')
  end

  private

  def load_account
    @account ||= Account.find(params[:account_id])
  end

end