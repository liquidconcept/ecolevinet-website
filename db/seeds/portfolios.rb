if defined?(Page) && !Page.find_by_link_url('/portfolio').present? && !RefineryConfig.hidden_plugins.include?("portfolio")

  page = Page.create({
    :title => "Portfolio",
    :link_url => "/portfolio",
    :menu_match => "\/portfolio(|\/.+?)",
    :deletable => false,
    :show_in_menu => true,
    :position => ((Page.maximum(:position, :conditions => {:parent_id => nil}) || -1)+1)
  })
  Page.default_parts.each do |default_page_part|
    page.parts.create(:title => default_page_part, :body => nil)
  end
end
