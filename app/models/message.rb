class Message < ActiveRecord::Base
  belongs_to :sender, :class_name=>'User', :foreign_key => "sender_id"
  belongs_to :receipient, :class_name=>'User', :foreign_key => "receipient_id"
end