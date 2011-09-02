class AddLinkToSections < ActiveRecord::Migration
  def self.up
    add_column :sections, :link, :string
  end

  def self.down
    remove_column :sections, :link
  end
end
