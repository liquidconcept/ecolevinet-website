class PortfolioController < ApplicationController

  before_filter :load_page, :only => [:index, :show, :empty]

  def index
    @portfolio_entries = PortfolioEntry
    @portfolio_entries = @portfolio_entries.where(:sections => {:id => params[:section_id]}) if params[:section_id]
    @portfolio_entries = @portfolio_entries.joins(:sections).all

   (render :json =>  @portfolio_entries.to_json , :layout => false and return ) if request.xhr?

   respond_to do |format|
      format.any(:js, :json) { render request.format.to_sym => @portfolio_entries.to_json , :layout => false}
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
      format.xml { render :partial => "main_image", :layout => false if request.xhr? }
      format.html
      format.any(:js, :json) { render request.format.to_sym => @portfolio_entry.to_json(:include  => {:images => {:methods => [ :url ]}})}
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
    @portfolio_entry = @master_entry
  end

  def load_page
    @page = Page.find_by_link_url('/portfolio', :include => [:parts])
  end

end
