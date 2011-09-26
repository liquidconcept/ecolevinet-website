module Admin
  class EventsController < Admin::BaseController

    before_filter :find_categories, :except => :index

    crudify :event, :xhr_paging => true

    def index
      search_all_events if searching?

      @events = Event.order('position ASC')
      @events = @events.paginate(:page => 1, :per_page => 10)

      render :partial => 'events' if request.xhr?
    end

    def find_categories
      @event_sections = Section.all
    end
  end
end
