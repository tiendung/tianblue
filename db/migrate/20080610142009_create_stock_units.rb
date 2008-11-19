class CreateStockUnits < ActiveRecord::Migration
  def self.up
    create_table :stock_units do |t|
      t.integer :product_id
      t.integer :size_id
      t.integer :stock, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :stock_units
  end
end
