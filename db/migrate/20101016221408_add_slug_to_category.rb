class AddSlugToCategory < ActiveRecord::Migration
  def self.up
    add_column :categories, :slug, :string
    
    Category.where(:slug=>nil).each do |category|
      category.create_slug_from_name
      category.save
    end
  end

  def self.down
    remove_column :categories, :slug
  end
end
