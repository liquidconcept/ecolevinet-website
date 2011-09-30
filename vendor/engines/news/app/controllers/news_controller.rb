class NewsController < ApplicationController

  before_filter :find_all_news
  before_filter :find_page
  before_filter :find_categories

  def index
    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @news in the line below:
    @hot_news
    @current_news
  end

  def show
    @news = news.find(params[:id])

    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @news in the line below:
  end

protected

  def find_all_news
    @hot_news = News.hot.order('position ASC')
    @current_news = News.current.order('position ASC')
  end

  def find_page
    @page = Page.find_by_link_url("/news")
  end

  def find_categories
    @sections = Section.all
  end
end
