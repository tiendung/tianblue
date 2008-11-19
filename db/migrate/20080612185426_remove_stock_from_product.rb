class RemoveStockFromProduct < ActiveRecord::Migration
  def self.up
    remove_column :products, :stock
  end

  def self.down
    add_column :products, :stock, :integer
  end
end
