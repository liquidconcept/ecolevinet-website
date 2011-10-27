class Admin::PortfolioController < Admin::BaseController

  before_filter :find_categories, :except => :index
  before_filter :populate, :only => :update

  crudify :portfolio_entry,
          :order => 'lft ASC',
          :conditions => {:parent_id => nil},
          :sortable => true

  def find_categories
    @portfolio_sections = Section.all
  end

  def populate
    params[:portfolio_entry][:section_ids] ||= []
  end

  def find_all_portfolio_entries
    @portfolio_entries = PortfolioEntry.where({:parent_id => nil}).order('lft ASC')
    @portfolio_entries = @portfolio_entries.joins(:sections).where(:sections => {'id' => params['section_id'].to_i}) if params['section_id']
  end

end
