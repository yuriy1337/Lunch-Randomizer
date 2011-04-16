class Category < ActiveRecord::Base
  validates :name, :description, :presence => true
  validates :name, :uniqueness => true
  has_many :places

  def self.all_sorted
    Category.all(:order => "lower(name)")
  end
end
