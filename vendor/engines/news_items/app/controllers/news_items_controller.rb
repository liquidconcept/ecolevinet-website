class NewsItemsController < ApplicationController

  before_filter :find_all_news_items
  before_filter :find_page
  before_filter :find_categories

  def index
    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @news_item in the line below:
    present(@page)
    present(@hot_news)
    present(@current_news)
  end

  def show
    @news_item = NewsItem.find(params[:id])


    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @news_item in the line below:
    present(@page)
    present(@news_item)

  end

protected

  def find_all_news_items
    @hot_news_items = NewsItem.hot.order('position ASC')
    @current_news_items = NewsItem.current.order('position ASC')
  end

  def find_page
    @page = Page.where(:link_url => "/news_items").first
  end

  def find_categories
    @sections = Section.all
  end

end
