class AddPromotionIdToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :promotion_id, :integer
  end

  def self.down
    remove_column :users, :promotion_id
  end
end
