class RemoveUsersTable < ActiveRecord::Migration
  def self.up
    drop_table :users
  end

  def self.down
    create_table :users do |t|
      t.string :email
      t.string :name
      t.text :address
      t.string :postcode
      t.string :hashed_password
      t.string :salt
      t.boolean :admin

      t.timestamps
    end
  end
end
