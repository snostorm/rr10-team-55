require 'CSV'

#######################################################################################
# CATEGORY SEEDS
########################################################################################
categories = File.open(File.join(Rails.root, 'public', 'data', 'categories.json'), 'r').read();
@categories = ActiveSupport::JSON.decode(categories)

puts 'Adding Categories:'
@categories.each do |category|
  cat = Category.new(:name=>category['name'])
  if(cat.save)
    puts "created #{cat.name} @ #{cat.id}"
  else
    puts "skipped #{category['name']}"
  end
end
puts '------------------'
puts ''
########################################################################################

#######################################################################################
# LOCATION SEEDS
########################################################################################
puts 'Adding Cities to locations'
CSV::Reader.parse(File.open(File.join(Rails.root, 'public', 'data', 'northamerica-locations.txt'), 'r')) do |row|
    p row
    break if !row[0].is_null && row[0].data == 'stop'
end
#@locations.each do |location|
#  
#end
puts '------------------'
puts ''
########################################################################################



# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)