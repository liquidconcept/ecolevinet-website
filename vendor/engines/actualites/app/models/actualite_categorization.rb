class ActualiteCategorization < ActiveRecord::Base
  belongs_to :actualite
  belongs_to :section
end
