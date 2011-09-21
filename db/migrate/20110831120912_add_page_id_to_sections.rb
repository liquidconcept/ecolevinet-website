class AddPageIdToSections < ActiveRecord::Migration
  def self.up
    add_column :sections, :page_id, :integer
  end

  def self.down
    remove_column :sections, :page_id
  end
end
