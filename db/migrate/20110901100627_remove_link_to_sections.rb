class RemoveLinkToSections < ActiveRecord::Migration
  def self.up
    remove_column :sections, :link
  end

  def self.down
    add_column :sections, :link, :string
  end
end
