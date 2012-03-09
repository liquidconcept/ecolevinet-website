module Admin
  class EventsController < Admin::BaseController

    before_filter :find_categories
    before_filter :populate, :only => :update

    crudify :event, :xhr_paging => true

    def index
      search_all_events if searching?

      @events = Event.order("(CASE WHEN start_date > '#{Time.zone.now.to_date}' THEN start_date ELSE end_date END) DESC")
      @events = @events.joins(:sections).where(:sections => {'id' => params['section_id'].to_i}) if params['section_id']
      @events = @events.paginate(:page => params[:page], :per_page => 10)

      render :partial => 'events' if request.xhr?
    end

    def find_categories
      @event_sections = Section.all
    end

    def populate
      params[:event][:section_ids] ||= []
    end

  end
end
