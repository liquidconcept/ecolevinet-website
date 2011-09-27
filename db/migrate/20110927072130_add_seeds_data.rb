class AddSeedsData < ActiveRecord::Migration
  def self.up
    load(Rails.root.join('db', 'seeds.rb'))
  end

  def self.down
  end
end
