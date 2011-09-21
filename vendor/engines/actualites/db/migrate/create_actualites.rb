class CreateActualites < ActiveRecord::Migration

  def self.up
    create_table :actualites do |t|
      t.string :title
      t.text :contenu
      t.integer :image_id
      t.date :date_limite
      t.integer :position

      t.timestamps
    end

    add_index :actualites, :id

    load(Rails.root.join('db', 'seeds', 'actualites.rb'))
  end

  def self.down
    if defined?(UserPlugin)
      UserPlugin.destroy_all({:name => "actualites"})
    end

    if defined?(Page)
      Page.delete_all({:link_url => "/actualites"})
    end

    drop_table :actualites
  end

end
