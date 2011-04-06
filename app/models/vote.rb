class Vote < ActiveRecord::Base
  validates :user_id, :uniqueness => {:scope => :selection_id}
  validates :user_id, :selection_id, :presence => true
  belongs_to :user
  belongs_to :selection
end
