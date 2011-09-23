if defined?(Page) && !RefineryConfig.hidden_plugins.include?("actualites")
  page = Page.create(
    :title => 'Actualites',
    :link_url => '/actualites',
    :deletable => false,
    :show_in_menu => true,
    :position => ((Page.maximum(:position, :conditions => {:parent_id => nil}) || -1)+1),
    :menu_match => '^/actualites(\/|\/.+?|)$'
  )
  Page.default_parts.each do |default_page_part|
    page.parts.create(:title => default_page_part, :body => nil)
  end
end
