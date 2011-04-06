class Place < ActiveRecord::Base
  validates :name, :category_id, :presence => true
  validates :name, :uniqueness => true
  belongs_to :category
  has_many :selections
end
