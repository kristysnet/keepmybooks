class Category < ActiveRecord::Base

  validates :name, presence: true, uniqueness: true
  belongs_to :parent,   class_name: '::Category'
  has_many   :children, class_name: '::Category', foreign_key: 'parent_id', primary_key: 'category_id'

  scope :top, -> { where(parent_id: nil) }

end