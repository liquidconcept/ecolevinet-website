class SectionsController < ApplicationController

  before_filter :find_all_sections
  before_filter :find_page

  def index
    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @section in the line below:
    present(@page)
  end

  def show
    @section = Section.find(params[:id])

    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @section in the line below:
    present(@section)
  end

protected

  def find_all_sections
    @sections = Section.order('position ASC')
  end

  def find_page
    @page = Section.find(params[:id]).page
  end

end
