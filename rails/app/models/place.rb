class Place < ActiveRecord::Base
  include Utils
  before_validation :normalize_inputs, :only => [:name]

  validates :name, :category_id, :presence => true
  validates :name, :uniqueness => true
  belongs_to :category
  has_many :selections


  private

  def normalize_inputs
    self.name = normalize_text(self.name)
  end
end
