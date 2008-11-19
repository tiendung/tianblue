class CreateCartItems < ActiveRecord::Migration
  def self.up
    create_table :cart_items do |t|
      t.string :name
      t.decimal :price, :precision => 8, :scale => 2, :default => 0
      t.integer :quantity
      t.integer :cart_id

      t.timestamps
    end
  end

  def self.down
    drop_table :cart_items
  end
end
