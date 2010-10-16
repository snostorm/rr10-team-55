class CreatePostings < ActiveRecord::Migration
  def self.up
    create_table :postings do |t|
      t.string :title
      t.text :description
      t.time :date_expires
      t.time :date_closed
      t.string :location
      t.boolean :new

      t.timestamps
    end
  end

  def self.down
    drop_table :postings
  end
end
