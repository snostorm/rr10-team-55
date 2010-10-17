class User < ActiveRecord::Base
  has_many :authorizations
  has_many :postings
  has_many :messages
  
  cattr_reader :per_page
  @@per_page = 32
  
  def self.create_from_hash!(hash)
    create(:name => hash['user_info']['name'])
  end
  
  def read_message_count
    eval 'Message.count(:conditions => ["recipient_id = ? AND read_at IS NOT NULL", self])'
  end
  
  def unread_message_count
    eval 'Message.count(:conditions => ["recipient_id = ? AND read_at IS NULL", self])'
  end

  
end