class AddPromotionIdToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :promotion_id, :integer
  end

  def self.down
    remove_column :orders, :promotion_id
  end
end
