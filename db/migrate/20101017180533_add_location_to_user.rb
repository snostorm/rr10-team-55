class AddLocationToUser < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.references :location
    end    
  end

  def self.down
    change_table :users do |t|
      t.remove :location
    end    
  end
end
