# encoding: UTF-8
if defined?(Page) && !Page.find_by_link_url('/news_items').present? && !RefineryConfig.hidden_plugins.include?("news_items")

  page = Page.create(:title => 'Actualités',
    :link_url => '/news_items',
    :deletable => false,
    :position => ((Page.maximum(:position, :conditions => {:parent_id => nil}) || -1)+1),
    :menu_match => '^/news_items(\/|\/.+?|)$'
  )
  Page.default_parts.each do |default_page_part|
    page.parts.create(:title => default_page_part, :body => nil)
  end

end
