class AddFakeDataFlagToPosting < ActiveRecord::Migration
  def self.up
    add_column :postings, :is_fake_data, :boolean, :default => false
  end

  def self.down
    remove_column :postings, :is_fake_data
  end
end
