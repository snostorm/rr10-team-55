namespace :db do
  namespace :development do
    desc "Create records in the development database."
    task :fake_data => :environment do
      require 'random_data'
      newcount = ENV['SIZE'] ? ENV['SIZE'].to_i : 100
      
      # Fake location
      # Faketown,AB,ca,53.55,-113.5
      loc=Location.new(:city => "Faketown", :prov_or_state => "AB", :prov_or_state_name => "Alberta",
          :country => "ca", :country_name => "Canada", :latitude => 53.55, :longitude => 113.5)
      if(loc.save)
        puts "created #{loc.city} @ #{loc.id}"
      else
        puts "skipped #{loc.city} @ #{loc.id}"
      end

      @categories = Category.all
      
      Posting.delete_all if(ENV['FLUSH']=='true')
      newcount.times do
        c = @categories.rand.postings.create(
          :title => Random.grammatical_construct({
              :story => [:thing, :mixer, :note],
              :thing => {:a=>'couch',:b=>'spoon',:c=>'DVD',:d=>'ring',
                :e=>'iPhone',:x=>'LCD Monitor',:f=>'knife set',:g=>'stereo',:h=>'chair'},
              :mixer => {:a=>' - ', :b=>': ', :c=>', ', :d=>'... '},
              :note  => {:a=>'like new',:b=>'set of 4',:c=>'GREAT FIND',:d=>'set of 2',:e=>'pair',:f=>'scratched, but works', :g=>'never used'}
            },
            :story),
          :description => Random.paragraphs,
          :location => Random.zipcode,
          :created_at => Time.now - (rand(12000)).days,
          :location => Location.first,
          :is_fake_data => true
          )
          
          
          # :middle_initial => ("A".."Z").to_a.rand, 
          # :ss_number => 99999999 + rand(999999999 - 99999999), 
          # :date_of_birth => Time.now - (rand(12000)).days) 
      end
      
    end
  end
end