# encoding: UTF-8
class Event < ActiveRecord::Base

  has_many :event_categorizations
  has_many :sections, :through => :event_categorizations, :source => :section

  belongs_to :image

  acts_as_indexed :fields => [:title, :description, :location]

  validates :title, :presence => true, :uniqueness => true
  validates :sections, :length => { :minimum => 1, :message => "Il faut définir au moins une section"}

  scope :today, lambda { where("start_date <= ? and end_date >= ?", Date.today, Date.today) }
  scope :given_day, lambda {|day| where("start_date <= ? and end_date >= ?", day, day) }

end
