module Admin
  class ActualitesController < Admin::BaseController

    before_filter :find_categories, :except => :index

    crudify :actualite, :xhr_paging => true

    def index
      search_all_actualites if searching?

      @actualites = Actualite.order('position ASC')

      render :partial => 'actualites' if request.xhr?
    end

    def find_categories
      @actualite_sections = Section.all
    end
  end
end
