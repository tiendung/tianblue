class RemoveSpuriousOrderIdFieldFromOrders < ActiveRecord::Migration
  def self.up
    remove_column :orders, :order_id
  end

  def self.down
    add_column :orders, :order_id, :integer
  end
end
