module Admin
  class SectionsController < Admin::BaseController

    crudify :section, :title_attribute => 'title', :xhr_paging => true

  end
end
