module Admin
  class SectionsController < Admin::BaseController

    crudify :section,
            :title_attribute => 'nom', :xhr_paging => true

  end
end
