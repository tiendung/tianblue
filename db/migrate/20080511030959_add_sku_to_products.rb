class AddSkuToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :sku, :string
    
    Product.all.each do |p|
      p.update_attribute(:status, p.id)
    end
  end

  def self.down
    remove_column :products, :sku
  end
end
