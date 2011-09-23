class AddLienToSections < ActiveRecord::Migration
  def self.up
    add_column :sections, :lien, :string

    load(Rails.root.join('db', 'seeds', 'sections.rb'))
    load(Rails.root.join('db', 'seeds', '_pages.rb'))
  end

  def self.down
    remove_column :sections, :lien
  end
end
