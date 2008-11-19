class CreateLineItems < ActiveRecord::Migration
  def self.up
    create_table :line_items do |t|
      t.string :name
      t.decimal :price, :precision => 8, :scale => 2, :default => 0
      t.integer :quantity
      t.integer :order_id

      t.timestamps
    end
  end

  def self.down
    drop_table :line_items
  end
end
