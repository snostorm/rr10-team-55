class Posting < ActiveRecord::Base
  scope :recent, order('created_at DESC').limit(5)
  
  belongs_to :category
  belongs_to :user
  belongs_to :location
  
  validates_presence_of :location
end
