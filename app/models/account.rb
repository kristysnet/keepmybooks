class Account < ActiveRecord::Base

  validates :name, presence: true, uniqueness: true
  has_many :transactions, dependent: :destroy

end