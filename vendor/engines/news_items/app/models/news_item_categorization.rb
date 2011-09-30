class NewsItemCategorization < ActiveRecord::Base
  belongs_to :news_item
  belongs_to :section
end
