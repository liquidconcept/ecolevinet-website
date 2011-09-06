class AddCategoriesToActualites < ActiveRecord::Migration
  def self.up
     create_table :actualite_categorizations do |t|
      t.integer :actualite_id
      t.integer :section_id
      
      t.timestamps
    end
    
    add_index :actualite_categorizations, :actualite_id
    add_index :actualite_categorizations  , :section_id

  end

  def self.down
     drop_table :actualite_categorizations
  end
end
