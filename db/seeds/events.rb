if defined?(Page) && !RefineryConfig.hidden_plugins.include?("events")
  page = Page.create(
    :title => 'Agenda',
    :link_url => '/events',
    :deletable => false,
    :show_in_menu => true,
    :position => ((Page.maximum(:position, :conditions => {:parent_id => nil}) || -1)+1),
    :menu_match => '^/events(\/|\/.+?|)$'
  )
  Page.default_parts.each do |default_page_part|
    page.parts.create(:title => default_page_part, :body => nil)
  end
end
