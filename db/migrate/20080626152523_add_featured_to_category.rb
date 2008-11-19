class AddFeaturedToCategory < ActiveRecord::Migration
  def self.up
    add_column :categories, :featured, :boolean
  end

  def self.down
    rename_column :categories, :featured
  end
end
