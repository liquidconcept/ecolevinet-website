class EventsController < ApplicationController

  before_filter :find_all_events
  before_filter :find_page
  before_filter :find_categories

  def index
    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @event in the line below:
    present(@page)
  end

  def show
    @event = Event.find(params[:id])

    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @event in the line below:
    present(@page)
  end

protected

  def find_all_events
    @events = Event.order('position ASC')
  end

  def find_page
    @page = Page.where(:link_url => "/events").first
  end

  def find_categories
    @sections = Section.all
  end
end
