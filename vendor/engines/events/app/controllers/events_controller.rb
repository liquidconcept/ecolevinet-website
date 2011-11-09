class EventsController < ApplicationController

  before_filter :find_all_events
  before_filter :find_page
  before_filter :find_categories

  def index
    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @event in the line below:
    present(@page)
    present(@events)
  end

  def show
    @event = Event.find(params[:id])
    map = GoogleStaticMap.new(:zoom => 10, :width => 160, :height => 160)
    map.markers << MapMarker.new(:color => "blue", :location => MapLocation.new(:address => @event.adress ))
    @map_url = map.url

    present(@page)
    present(@event)
  end

  def on_the
    @events = Event.given_day(Date.strptime(params[:day],'%d-%m-%y')).all
    respond_to do |format|
      format.html { render :partial => 'events/on_the', :layout => false,  :locals => { :events => @events }}
    end
  end

  def for_the
    direction = params[:direction] == 'up' ? 1 : -1
    _day = Date.strptime(params[:month],'%m-%y') + direction.month
    respond_to do |format|
      format.html { render :partial => 'events/month', :layout => false,  :locals => { :_day => _day }}
    end
  end

protected

  def find_all_events
    @events = Event.order('position ASC')
  end

  def find_page
    if params[:section_id]
      @page = Section.find(params[:section_id]).page
    else
      @page = Page.where(:link_url => "/").first
    end
  end

  def find_categories
    @sections = Section.all
  end
end
