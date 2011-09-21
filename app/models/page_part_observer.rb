class PagePartObserver < ActiveRecord::Observer
  def before_save(page_part)
    #if this page_part is linked to a section, update data
    if page_part.changed? && !(Section.find_by_page_id(page_part.page_id).blank?)
      Section.where(:page_id => page_part.page_id).update_all Hash[page_part.title,page_part.body]
    end
  end
end
