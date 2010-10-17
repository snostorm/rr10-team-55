class AddProvOrStateNameAndCountryNameToLocation < ActiveRecord::Migration
  def self.up
    add_column :locations, :prov_or_state_name, :string
    add_column :locations, :country_name, :string
  end

  def self.down
    remove_column :locations, :country_name
    remove_column :locations, :prov_or_state_name
  end
end
