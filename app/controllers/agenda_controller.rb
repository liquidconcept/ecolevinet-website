class AgendaController < ApplicationController
  def index
    @events = Event.where('start_date >= ?',Date.today).order("start_date DESC")
    @page   = Page.find_by_link_url('/agenda/index')
  end
end
