class ActualitesController < ApplicationController

  before_filter :find_all_actualites
  before_filter :find_page
  before_filter :find_categories
  
  def index
    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @actualite in the line below:
    @actualites_brulantes
    @actualites_normales
  end

  def show
    @actualite = Actualite.find(params[:id])
    @page

    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @actualite in the line below:
  end

protected

  def find_all_actualites
    @actualites_normales = Actualite.normales.order('position ASC')
    @actualites_brulantes = Actualite.brulantes.order('position ASC')
  end

  def find_page
    @page = Page.find_by_link_url("/actualites")
  end
  
  def find_categories
    @sections = Section.all
  end
end
