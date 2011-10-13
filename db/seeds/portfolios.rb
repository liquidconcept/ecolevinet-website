# encoding: UTF-8
if defined?(Page) && !Page.find_by_link_url('/portfolio').present? && !RefineryConfig.hidden_plugins.include?("portfolio")

  page = Page.create({
    :title => "Galerie",
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


if defined?(Section)  && !RefineryConfig.hidden_plugins.include?("portfolio")

  Section.all.each do |section|
    if section.page.children.select {|p| p.data_type == 'portfolio'}.blank?

      page = section.page.children.create(
        :title => 'Galerie',
        :deletable => false,
        :show_in_menu => true,
        :data_type => 'portfolio',
        :position => section.page.position + 1)
        Page.default_parts.each do |default_page_part|
          page.parts.create(:title => default_page_part, :body => nil)
        end

    end
  end

end
