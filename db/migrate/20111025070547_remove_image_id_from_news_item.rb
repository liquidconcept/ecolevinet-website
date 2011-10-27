class RemoveImageIdFromNewsItem < ActiveRecord::Migration
  def self.up
    remove_column :news_items, :image_id
  end

  def self.down
    add_column :news_items, :image_id, :integer
  end
end
