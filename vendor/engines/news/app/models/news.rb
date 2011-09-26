class News < ActiveRecord::Base

  has_many :news_categorizations
  has_many :sections, :through => :news_categorizations, :source => :section

  acts_as_indexed :fields => [:titre, :contenu]

  validates :titre, :presence => true, :uniqueness => true

  belongs_to :image

  scope :hot, where(['date_limite >  ? and hot = ?', Date.today, true])
  scope :current,  where(['date_limite <= ? ', Date.today])

  def title
    titre
  end

end
