class Selection < ActiveRecord::Base
  validates :date_created, :uniqueness => true
  belongs_to :place
  has_many :votes
end
