namespace :db do
  namespace :development do
    desc "Create records in the development database."
    task :fake_data => :environment do
      require 'random_data'
      newcount = ENV['SIZE'] ? ENV['SIZE'].to_i : 100
      User.delete_all if(ENV['FLUSH']=='true')
      newcount.times do
        c = User.create(
          :name => (Random.first_name + ' ' + Random.last_name))
          # :middle_initial => ("A".."Z").to_a.rand, 
          # :ss_number => 99999999 + rand(999999999 - 99999999), 
          # :date_of_birth => Time.now - (rand(12000)).days) 
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
          :created_at => Time.now - (rand(12000)).days) 
          # :middle_initial => ("A".."Z").to_a.rand, 
          # :ss_number => 99999999 + rand(999999999 - 99999999), 
          # :date_of_birth => Time.now - (rand(12000)).days) 
      end
    end
  end
end