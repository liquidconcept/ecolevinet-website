class AddCategoriesToNews < ActiveRecord::Migration
  def self.up
     create_table :news_categorizations do |t|
      t.integer :news_id
      t.integer :section_id
      
      t.timestamps
    end
    
    add_index :news_categorizations, :news_id
    add_index :news_categorizations  , :section_id

  end

  def self.down
     drop_table :news_categorizations
  end
end
