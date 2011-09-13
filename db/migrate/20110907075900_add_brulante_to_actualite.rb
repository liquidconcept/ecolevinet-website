class AddBrulanteToActualite < ActiveRecord::Migration
  def self.up
    add_column :actualites, :brulante, :boolean
  end

  def self.down
    remove_column :actualites, :brulante
  end
end
