class AddIsAdminToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :admin, :boolean

    if @andy = User.find_by_name("Andy Croll")
      @andy.admin = true
      @andy.save
    end
    if @tom = User.find_by_name("Tom Hutton")
      @tom.admin = true
      @tom.save
    end
  end

  def self.down
    remove_column :users, :admin
  end
end
