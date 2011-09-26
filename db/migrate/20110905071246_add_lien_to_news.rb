class AddLienToNews < ActiveRecord::Migration
  def self.up
    add_column :news, :lien, :string
  end

  def self.down
    remove_column :news, :lien
  end
end
