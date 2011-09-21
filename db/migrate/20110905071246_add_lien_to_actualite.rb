class AddLienToActualite < ActiveRecord::Migration
  def self.up
    add_column :actualites, :lien, :string
  end

  def self.down
    remove_column :actualites, :lien
  end
end
