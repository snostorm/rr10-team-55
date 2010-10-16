class AddUserFields < ActiveRecord::Migration
  def self.up
    add_column :users, :is_moderator, :boolean, :default => false
  end

  def self.down
    remove_column :users, :is_moderator
  end
end
