class AddLocationToPosting < ActiveRecord::Migration
  def self.up
    change_table :postings do |t|
      t.references :location
    end    
  end

  def self.down
    change_table :postings do |t|
      t.remove :location
    end    
  end
end
