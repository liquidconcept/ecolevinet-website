class AddCategorizationToEvents < ActiveRecord::Migration
  def self.up
    create_table :event_categorizations do |t|
      t.integer :event_id
      t.integer :section_id

      t.timestamps
    end

    add_index :event_categorizations, :event_id
    add_index :event_categorizations, :section_id
  end

  def self.down
     drop_table :event_categorizations
  end
end
