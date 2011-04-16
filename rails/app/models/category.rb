class Category < ActiveRecord::Base
  include Utils
  before_validation :normalize_inputs, :only => [:name, :description]
  
  validates :name, :presence => true
  validates :name, :uniqueness => true
  has_many :places

  def self.all_sorted
    Category.all(:order => "lower(name)")
  end


  private

  def normalize_inputs
    self.name = normalize_text(self.name)
    self.description = self.description.strip
  end
end
