class SectionObserver < ActiveRecord::Observer
 
  def after_save(section)
    #Create a page if new section
    if section.page_id.blank?
      section_page = Page.new(:title => section.nom,
            :show_in_menu => false,
            :deletable => false,
            :position => Page.maximum("position") + 1)
      section_page.save
    #Else update found page title
    else
      page = Page.find(section.id)
      page.title = section.name
      page.save
    end
  
  end
end
