class AddGreetingToPromotions < ActiveRecord::Migration
  def self.up
    add_column :promotions, :greeting, :string, :limit => 999
  end

  def self.down
    remove_column :promotions, :greeting
  end
end
