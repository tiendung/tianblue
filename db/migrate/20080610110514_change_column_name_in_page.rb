class ChangeColumnNameInPage < ActiveRecord::Migration
  def self.up
    add_column :pages, :name, :string

    Page.all.each do |p|
      p.update_attribute(:name, p.title)
    end

    remove_column :pages, :title
  end

  def self.down
    add_column :pages, :title, :string

    Page.all.each do |p|
      p.update_attribute(:title, p.name)
    end

    remove_column :pages, :name
  end
end
