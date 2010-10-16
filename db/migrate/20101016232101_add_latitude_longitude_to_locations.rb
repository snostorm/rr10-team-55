class AddLatitudeLongitudeToLocations < ActiveRecord::Migration
  def self.up
    add_column :locations, :latitude, :float
    add_column :locations, :longitude, :float
    remove_column :locations, :coords
  end

  def self.down
    remove_column :locations, :longitude
    remove_column :locations, :latitude
    add_column :locations, t.string, :coords
   end
end
