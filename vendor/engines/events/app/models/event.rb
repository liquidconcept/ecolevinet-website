class Event < ActiveRecord::Base

  has_many :event_categorizations
  has_many :sections, :through => :event_categorizations, :source => :section

  acts_as_indexed :fields => [:title, :description, :location]

  validates :title, :presence => true, :uniqueness => true

  belongs_to :image

end
