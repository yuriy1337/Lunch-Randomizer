class Category < ActiveRecord::Base
  include Utils
  before_validation :normalize_inputs, :only => [:name, :description]
  
  validates :name, :presence => true
  validates :name, :uniqueness => true
  has_many :places

  def self.all_sorted
    Category.all(:order => "lower(name)")
  end

  def find_or_create_by_name(name)
    Category.first(:conditions => [ "lower(name) = ?", name.downcase ]) || Category.create(:name => name)
  end

  private

  def normalize_inputs
    self.name = normalize_text(self.name)
    self.description = self.description.strip unless self.description.blank?
  end
end
