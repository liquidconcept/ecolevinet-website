class NewsItem < ActiveRecord::Base

  acts_as_indexed :fields => [:title, :content, :link]

  validates :title, :presence => true, :uniqueness => true

  has_many :news_item_categorizations
  has_many :sections, :through => :news_item_categorizations, :source => :section

  belongs_to :image

  scope :hot, where(['end_date >  ? and hot = ?', Date.today, true]).order('hotness_date DESC')
  scope :current,  where(['end_date <= ? ', Date.today])

  def before_save
    self.hotness_date = Date.today if !self.changes[:hot].blank? && self.changes[:hot].last
  end
end
