class AddCountryIdToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :country_id, :integer
  end

  def self.down
    remove_column :orders, :country_id
  end
end
