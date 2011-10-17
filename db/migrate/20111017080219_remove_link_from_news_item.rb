class RemoveLinkFromNewsItem < ActiveRecord::Migration

  def self.up
    remove_column :news_items, :link
  end

  def self.down
   add_column :news_items, :link , :string
  end

end
