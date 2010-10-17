class User < ActiveRecord::Base
  has_many :authorizations
  has_many :postings
  
  is_gravtastic
  cattr_reader :per_page
  @@per_page = 32
  
  def self.create_from_hash!(hash)
    create(:name => hash['user_info']['name'])
  end
end
