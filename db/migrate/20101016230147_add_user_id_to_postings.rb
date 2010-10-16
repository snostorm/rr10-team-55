class AddUserIdToPostings < ActiveRecord::Migration
  def self.up
    add_column :postings, :user_id, :integer
  end

  def self.down
    remove_column :postings, :user_id
  end
end
