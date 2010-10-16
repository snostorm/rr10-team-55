class AddUserFields < ActiveRecord::Migration
  def self.up
    add_column :users, :is_moderator, :boolean, :default => false
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :bio, :text
    add_column :users, :location, :string
  end

  def self.down
    remove_column :users, :is_moderator 
    remove_column :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :bio
    remove_column :users, :location
  end
end
