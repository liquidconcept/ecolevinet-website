class AddHotToNews < ActiveRecord::Migration
  def self.up
    add_column :news, :hot, :boolean
  end

  def self.down
    remove_column :news, :hot
  end
end
