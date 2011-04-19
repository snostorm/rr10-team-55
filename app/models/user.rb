class User < ActiveRecord::Base
  #validates_presence_of :email
  
  
  has_many :authorizations
  has_many :postings
  belongs_to :location

  include Gravtastic
  gravtastic
  
  has_many :sent_messages, :class_name=>'Message', :foreign_key => "sender_id"
  has_many :received_messages, :class_name=>'Message', :foreign_key => "recipient_id"

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