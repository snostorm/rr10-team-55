class AddCategoryIdToPosting < ActiveRecord::Migration
  def self.up
    add_column :postings, :category_id, :string
    
    category = Category.find_or_create_by_name('Other')
    category.postings << Posting.where(:category_id=>nil)
  end

  def self.down
    remove_column :postings, :category_id
  end
end
