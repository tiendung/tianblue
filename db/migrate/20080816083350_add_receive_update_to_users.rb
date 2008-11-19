class AddReceiveUpdateToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :receive_update, :boolean, :default => true
  end

  def self.down
    remove_column :users, :receive_update
  end

end
