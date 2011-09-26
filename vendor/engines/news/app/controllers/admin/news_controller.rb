module Admin
  class NewsController < Admin::BaseController

    before_filter :find_categories, :except => :index

    crudify :news, :xhr_paging => true

    def index
      search_all_news if searching?

      @news = News.order('position ASC')
      @news = @news.paginate(:page => 1, :per_page => 10)

      render :partial => 'news' if request.xhr?
    end

    def find_categories
      @news_sections = Section.all
    end
  end
end
