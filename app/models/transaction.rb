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

  def is_deposit?
    self.deposit
  end

  def amount_value
    if is_deposit?
      self.amount
    else
      0-self.amount
    end
  end

end