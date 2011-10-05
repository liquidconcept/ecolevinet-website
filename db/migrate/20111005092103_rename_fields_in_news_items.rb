class RenameFieldsInNewsItems < ActiveRecord::Migration
  def self.up
        
    rename_column :news_items, :titre, :title
    rename_column :news_items, :contenu, :content
    rename_column :news_items, :date_limite, :hotness_end_at
    rename_column :news_items, :lien, :link
    
  end

  def self.down
    
    rename_column :news_items, :title , :titre
    rename_column :news_items, :content, :contenu
    rename_column :news_items, :hotness_end_at, :date_limite
    rename_column :news_items, :link, :lien
    
  end
end
