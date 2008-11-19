class AddOrderingColumnToSize < ActiveRecord::Migration
  def self.up
    add_column :sizes, :relative_order, :integer
  end

  def self.down
    remove_column :sizes, :relative_order
  end
end
