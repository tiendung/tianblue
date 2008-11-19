class AddDiscountMultiplierToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :discount_multiplier, :decimal, :precision => 8, :scale => 2, :default => 1
  end

  def self.down
    remove_column :orders, :discount_multiplier
  end
end
