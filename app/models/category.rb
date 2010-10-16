class Category < ActiveRecord::Base
  has_many :postings
end
