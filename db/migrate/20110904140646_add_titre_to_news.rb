class AddTitreToNews < ActiveRecord::Migration
  def self.up
    add_column :news, :titre, :string
    remove_column :news, :title
  end

  def self.down
    remove_column :news, :titre
  end
end
