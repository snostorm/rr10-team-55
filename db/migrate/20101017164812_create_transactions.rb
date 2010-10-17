class CreateTransactions < ActiveRecord::Migration
  def self.up
    create_table :transactions do |t|
      t.integer :requestor_id
      t.integer :poster_id
      t.integer :item_id
      t.datetime :approved_by_poster_at
      t.datetime :completed_at

      t.timestamps
    end
  end

  def self.down
    drop_table :transactions
  end
end
