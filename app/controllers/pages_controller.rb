class PagesController < ApplicationController
  def index
    @bodylayout = 'home'
    @title = 'Home'
  end
end