class AddHeadingToNewsItem < ActiveRecord::Migration
  def self.up
    add_column :news_items, :heading, :text
  end

  def self.down
    remove_column :news_items, :heading
  end
end
