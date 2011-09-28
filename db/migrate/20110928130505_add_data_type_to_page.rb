class AddDataTypeToPage < ActiveRecord::Migration
  def self.up
    add_column :pages, :data_type, :string
  end

  def self.down
    remove_column :pages, :data_type
  end
end
