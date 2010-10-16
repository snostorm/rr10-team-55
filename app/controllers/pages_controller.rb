class PagesController < ApplicationController
  def index
    @bodylayout = 'home'
    @title = 'Home'
    
    @postings = Posting.recent
  end
end