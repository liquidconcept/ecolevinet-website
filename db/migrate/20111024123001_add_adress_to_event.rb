class AddAdressToEvent < ActiveRecord::Migration
  def self.up
    add_column :events, :adress, :string
  end

  def self.down
    remove_column :events, :adress
  end
end
