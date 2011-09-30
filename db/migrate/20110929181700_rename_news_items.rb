class RenameNewsItems < ActiveRecord::Migration

  def self.up
    rename_table :news, :news_items
    rename_table :news_categorizations, :news_item_categorizations
    rename_column :news_item_categorizations, :news_id, :news_item_id

    if defined?(UserPlugin)
      UserPlugin.where(:name => 'news').update_all(:name => "news_items")
    end

    if defined?(Page)
      Page.where(:link_url => '/news').update_all(:link_url => "/news_items")
    end
  end

  def self.down
    rename_table :news_items, :news
    rename_table :news_item_categorizations, :news_categorizations
    rename_column :news_categorizations, :news_item_id, :news_id

    if defined?(UserPlugin)
      UserPlugin.where(:name => 'news_items').update_all(:name => "news")
    end

    if defined?(Page)
      Page.where(:link_url => '/news_items').update_all(:link_url => "/news")
    end
  end

end
