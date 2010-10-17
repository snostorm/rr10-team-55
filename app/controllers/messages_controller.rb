class MessagesController < ApplicationController
  def index
    @title = 'Message Centre'
    
    @users = User.where('email not ?', nil)
  end
end