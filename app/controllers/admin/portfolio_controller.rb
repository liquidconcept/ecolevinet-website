class Admin::PortfolioController < Admin::BaseController

  before_filter :find_categories, :except => :index

  crudify :portfolio_entry,
          :order => 'lft ASC',
          :conditions => {:parent_id => nil},
          :sortable => true

  def find_categories
    @portfolio_sections = Section.all
  end
end
