module Admin
  class NewsItemsController < Admin::BaseController

    before_filter :find_categories
    before_filter :populate, :only => :update

    crudify :news_item, :xhr_paging => true

    def index
       search_all_news_items if searching?

       @news_items = NewsItem.order('created_at ASC')
       @news_items = @news_items.joins(:sections).where(:sections => {'id' => params['section_id'].to_i}) if params['section_id']
       @news_items = @news_items.paginate(:page => params[:page], :per_page => 10)

       render :partial => 'news_items' if request.xhr?
     end

     def find_categories
       @news_sections = Section.all
     end

     def populate
       params[:news_item][:section_ids] ||= []
     end


  end
end
