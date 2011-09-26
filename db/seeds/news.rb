if defined?(Page) && !RefineryConfig.hidden_plugins.include?("news")
  page = Page.create(
    :title => 'Actualite',
    :link_url => '/news',
    :deletable => false,
    :show_in_menu => true,
    :position => ((Page.maximum(:position, :conditions => {:parent_id => nil}) || -1)+1),
    :menu_match => '^/news(\/|\/.+?|)$'
  )
  Page.default_parts.each do |default_page_part|
    page.parts.create(:title => default_page_part, :body => nil)
  end
end
