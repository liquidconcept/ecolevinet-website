class EventCategorization < ActiveRecord::Base
  belongs_to :event
  belongs_to :section
end
