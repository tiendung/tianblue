class AddStockToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :stock, :integer, :default => 0
    
    # initialise products to stock level zero
    Product.all.each { |p| p.update_attributes(:stock => 0) }
  end

  def self.down
    remove_column :products, :stock
  end
end
