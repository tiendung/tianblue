class AddSkuToStockUnit < ActiveRecord::Migration
  def self.up
    add_column :stock_units, :sku, :string
    
    StockUnit.all.each do |su|
      su.update_attribute(:sku, "#{su.product.sku}-#{su.size.code}")
    end
  end

  def self.down
    remove_column :stock_units, :sku
  end
end
