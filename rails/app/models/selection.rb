class Selection < ActiveRecord::Base
  validates :date_created, :uniqueness => true
  belongs_to :place
  has_many :votes
  attr_accessor :up_votes, :down_votes

  def get_votes
    self.up_votes = Vote.count(:conditions => {:selection_id => id, :is_up => true})
    self.down_votes = Vote.count(:conditions => {:selection_id => id, :is_up => false})
  end
end
