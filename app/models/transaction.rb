class Transaction < ActiveRecord::Base
  self.table_name = :transactions

  belongs_to :account
  belongs_to :category

  validates :category, presence: true
  validates :account, presence: true
  validates :receiver, presence: true
  validates :amount, presence: true, numericality: true
  validates :transaction_date, presence: true
  validate :valid_date?

  def valid_date?
    unless Chronic.parse(self.transaction_date)
      errors.add(:transaction_date, 'is invalid')
    end
  end

end