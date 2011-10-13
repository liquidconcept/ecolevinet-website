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


if defined?(Page) && defined?(Section) && !RefineryConfig.hidden_plugins.include?("news_items")

  Section.all.each do |section|
    if section.page.children.select{|c| c.data_type == 'news_items'}.blank?
      page = section.page.children.create(
        :title => 'Actualités',
        :deletable => false,
        :show_in_menu => true,
        :data_type => 'news_items',
        :position => section.page.position + 1)
        Page.default_parts.each do |default_page_part|
          page.parts.create(:title => default_page_part, :body => nil)
        end
    end
  end

end
