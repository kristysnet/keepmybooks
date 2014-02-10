class Transaction < ActiveRecord::Base
  self.table_name = :transactions

  belongs_to :account
  belongs_to :category


end