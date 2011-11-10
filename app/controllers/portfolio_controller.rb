class PortfolioController < ApplicationController

  before_filter :load_page, :only => [:index, :show, :empty]

  def index
    @portfolio_entries = PortfolioEntry
    @portfolio_entries = @portfolio_entries.where(:sections => {:id => params[:section_id]}) if params[:section_id]
    @portfolio_entries = @portfolio_entries.joins(:sections).all
    @portfolio_sections = Section.all

   respond_to do |format|
      format.any(:js, :json) { render request.format.to_sym => @portfolio_entries.to_json(:methods => :friendly_id) , :layout => false }
      format.html
    end
  end

  def show
    begin
      @master_entry = if params[:id]
        PortfolioEntry.find(params[:id])
      else
        PortfolioEntry.where(:parent_id => nil).first
      end

      if ::Refinery::Portfolio.multi_level?
        multi_level
      else
        single_level
      end

      begin
        image_index = (params[:image_id].presence || '0').to_i
        @image = @portfolio_entry.images[image_index]
      rescue
        render :action => "empty" and return
      end
    rescue
      error_404 and return
    end

    respond_to do |format|
      format.any(:js, :json) { render request.format.to_sym => @portfolio_entry.to_json(:include  => {:images => {:methods => [ :url ]}})}
      format.html
    end

  end

protected

  def multi_level
    @portfolio_entries = @master_entry.children
    @portfolio_entry = if params[:portfolio_id]
      @portfolio_entries.find(params[:portfolio_id])
    else
      @portfolio_entries.first
    end
  end

  def single_level
    @portfolio_entries = PortfolioEntry.all
    @portfolio_entries = @portfolio_entries.keep_if{|pe| pe.sections.include? Section.find(params[:section_id].to_i) }
    @portfolio_entry = @master_entry
  end

  def load_page
    if params[:section_id]
      @page = Section.find(params[:section_id]).page
    else
      @page = Page.find_by_link_url('/portfolio', :include => [:parts])
    end
  end

end
