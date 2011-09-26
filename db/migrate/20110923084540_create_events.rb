class CreateEvents < ActiveRecord::Migration

  def self.up
    create_table :events do |t|
      t.string :title
      t.text :description
      t.string :location
      t.date :start_date
      t.date :end_date
      t.integer :image_id
      t.integer :position

      t.timestamps
    end

    add_index :events, :id

    load(Rails.root.join('db', 'seeds', 'events.rb'))
    if (seed_file = Rails.root.join('db', 'seeds', 'users.rb')).file?
      load seed_file.to_s
      RefineryConfig.setup
    end

  end

  def self.down
    if defined?(UserPlugin)
      UserPlugin.destroy_all({:name => "events"})
    end

    if defined?(Page)
      Page.delete_all({:link_url => "/events"})
    end

    drop_table :events
  end

end
