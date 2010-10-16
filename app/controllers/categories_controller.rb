class CategoriesController < ApplicationController
  def show
    redirect_to category_postings_path(:category_id=>params[:id])
  end
end
