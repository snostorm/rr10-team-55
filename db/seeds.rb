require 'csv'

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
# Note: there is a second version of the input file which includes proper names
# for country and prov/state called northamerica-locations-withnames.txt
########################################################################################
ActiveRecord::Base.transaction do
  puts 'Adding Cities to locations'
#  cities_filename = File.join(Rails.root, 'public', 'data', 'northamerica-locations.txt')
  cities_filename = File.join(Rails.root, 'public', 'data', 'fake-locations.txt')
#  cities_filename = File.join(Rails.root, 'public', 'data', 'northamerica-locations-withnames.txt')
  puts 'cities_file=' + cities_filename
  
  CSV.foreach cities_filename do |row|
    if (!row[0].nil?)
      loc=Location.new(:city => row[0], :prov_or_state => row[1], :country => row[2], :latitude => row[3], :longitude => row[4])
      if(loc.save)
        puts "created #{loc.city} @ #{loc.id}"
      else
        puts "skipped #{row[0]}"
      end
    end
  end
end

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