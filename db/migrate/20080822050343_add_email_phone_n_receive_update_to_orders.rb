class AddEmailPhoneNReceiveUpdateToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :receive_update,  :boolean, :default => true
    add_column :orders, :email,           :string,  :limit => 100
    add_column :orders, :phone,           :string,  :limit => 20
  end

  def self.down
    remove_column :users, :receive_update
    remove_column :users, :email
    remove_column :users, :phone
  end
end
