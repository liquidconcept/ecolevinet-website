class PortfolioEntryCategorization < ActiveRecord::Base
  belongs_to :portfolio_entry
  belongs_to :section
end
