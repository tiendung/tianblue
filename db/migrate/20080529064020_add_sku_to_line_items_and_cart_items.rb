class AddSkuToLineItemsAndCartItems < ActiveRecord::Migration
  def self.up
    add_column :line_items, :sku, :string
    add_column :cart_items, :sku, :string
  end

  def self.down
    remove_column :line_items, :sku
    remove_column :cart_items, :sku
  end
end
