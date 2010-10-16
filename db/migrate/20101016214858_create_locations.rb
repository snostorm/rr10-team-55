class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.string :city
      t.string :prov_or_state
      t.string :country
      t.string :coords

      t.timestamps
    end
  end

  def self.down
    drop_table :locations
  end
end
