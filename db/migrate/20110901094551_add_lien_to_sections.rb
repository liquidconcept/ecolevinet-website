class AddLienToSections < ActiveRecord::Migration
  def self.up
    add_column :sections, :lien, :string

  end

  def self.down
    remove_column :sections, :lien
  end
end
