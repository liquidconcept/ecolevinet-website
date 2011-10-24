class NewsItem < ActiveRecord::Base

  acts_as_indexed :fields => [:title, :content, :heading]

  validates :title, :presence => true, :uniqueness => true
  validates :sections, :presence => true

  has_many :news_item_categorizations
  has_many :sections, :through => :news_item_categorizations, :source => :section

  belongs_to :image

  default_scope :order => 'created_at DESC'

  scope :hot, where(['hotness_end_at >  ? and hot = ?', Date.today, true]).order('hotness_date desc').order('hotness_end_at desc')
  scope :current,  where(['hotness_end_at <= ? or hot = ?', Date.today, false])

  def before_save
    self.hotness_date = Date.today if !self.changes[:hot].blank? && self.changes[:hot].last
  end
end
