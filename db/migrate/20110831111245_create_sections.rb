class CreateSections < ActiveRecord::Migration

  def self.up
    create_table :sections do |t|
      t.string :title
      t.string :heading_title
      t.string :heading
      t.integer :image_id
      t.integer :position

      t.timestamps
    end

    add_index :sections, :id

  end

  def self.down
    if defined?(UserPlugin)
      UserPlugin.destroy_all({:name => "sections"})
    end

    if defined?(Page)
      Page.delete_all({:link_url => "/sections"})
    end

    drop_table :sections
  end

end
