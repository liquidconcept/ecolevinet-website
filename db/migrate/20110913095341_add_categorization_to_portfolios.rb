class AddCategorizationToPortfolios < ActiveRecord::Migration
  def self.up
    create_table :portfolio_entry_categorizations do |t|
      t.integer :portfolio_entry_id
      t.integer :section_id

      t.timestamps
    end

    add_index :portfolio_entry_categorizations, :portfolio_entry_id
    add_index :portfolio_entry_categorizations, :section_id
  end

  def self.down
     drop_table :portfolio_entry_categorizations
  end
end
