class CreateNewsItems < ActiveRecord::Migration

  def self.up
    create_table :news_items do |t|
      t.string :title
      t.text :content
      t.integer :image_id
      t.date :end_date
      t.string :link
      t.boolean :hot
      t.integer :position

      t.timestamps
    end

    add_index :news_items, :id

    load(Rails.root.join('db', 'seeds', 'news_items.rb'))
  end

  def self.down
    if defined?(UserPlugin)
      UserPlugin.destroy_all({:name => "news_items"})
    end

    if defined?(Page)
      Page.delete_all({:link_url => "/news_items"})
    end

    drop_table :news_items
  end

end
