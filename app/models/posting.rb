class Posting < ActiveRecord::Base
  scope :recent, order('created_at DESC').limit(5)
  
  belongs_to :category
end
