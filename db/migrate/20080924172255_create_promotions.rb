class CreatePromotions < ActiveRecord::Migration
  def self.up
    create_table :promotions do |t|
      t.string :promotion_code, :limit => 50
      t.string :promotion_name, :limit => 250
      t.decimal :discount_percentage, :precision => 8, :scale => 2, :default => 0
      t.date :valid_from
      t.date :valid_until
      t.boolean :activate_now, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :promotions
  end
end
