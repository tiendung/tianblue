class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.string :name
      t.text :address
      t.string :postcode
      t.integer :order_id
      t.string :transaction_reference
      t.string :status
      
      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
