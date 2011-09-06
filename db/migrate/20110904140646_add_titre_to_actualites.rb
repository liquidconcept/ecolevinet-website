class AddTitreToActualites < ActiveRecord::Migration
  def self.up
    add_column :actualites, :titre, :string
    remove_column :actualites, :title
  end

  def self.down
    remove_column :actualites, :titre
  end
end
