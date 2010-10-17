class Category < ActiveRecord::Base
  has_many :postings
  
  validates_presence_of :name, :slug
  validates_uniqueness_of :name, :scope=>:parent_id
  #validates_uniqueness_of :slug, :scope=>:parent_id
  
  before_validation :create_slug_from_name
  
  def create_slug_from_name
    self.slug ||= name.gsub(/[^a-z0-9]+/i, "-").downcase
  end
  
  def to_param
     "#{id}-#{name.underscore}"
   end
end
