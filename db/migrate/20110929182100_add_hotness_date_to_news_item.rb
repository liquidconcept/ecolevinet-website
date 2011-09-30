class AddHotnessDateToNewsItem < ActiveRecord::Migration
  def self.up
    add_column :news_items, :hotness_date, :date
  end

  def self.down
    remove_column :news_items, :hotness_date
  end
end
