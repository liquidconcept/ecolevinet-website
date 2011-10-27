# encoding: UTF-8
if defined?(Page) && !Page.find_by_link_url('/events').present? && !RefineryConfig.hidden_plugins.include?("events")
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

if defined?(Page) && defined?(Section) && !RefineryConfig.hidden_plugins.include?("events")

  Section.all.each do |section|
    if section.page.children.select{|c| c.data_type == 'events'}.blank?
      page = section.page.children.create(
        :title => 'Agenda',
        :deletable => false,
        :show_in_menu => true,
        :data_type => 'events',
        :position => section.page.position + 1)
        Page.default_parts.each do |default_page_part|
          page.parts.create(:title => default_page_part, :body => nil)
        end
    end
  end

end
