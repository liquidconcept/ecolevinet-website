class Event < ActiveRecord::Base

  has_many :event_categorizations
  has_many :sections, :through => :event_categorizations, :source => :section

  acts_as_indexed :fields => [:title, :description, :location]

  validates :title, :presence => true, :uniqueness => true

  belongs_to :image

  scope :today, lambda { where("start_date <= ? and end_date >= ?", Date.today, Date.today) }
  scope :given_day, lambda {|day| where("start_date <= ? and end_date >= ?", day, day) }

end
