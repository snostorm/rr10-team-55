class AddSlugToCategory < ActiveRecord::Migration
  class Category < ActiveRecord::Base
    
  end
  
  def self.up
    
    change_table :categories do |t|
      t.string :slug
    end
    
    Category.where(:slug=>nil).each do |category|
      category.create_slug_from_name
      category.save
    end
  end

  def self.down
    remove_column :categories, :slug
  end
end
