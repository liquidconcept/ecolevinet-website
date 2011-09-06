class Actualite < ActiveRecord::Base

  has_many :actualite_categorizations
  has_many :sections, :through => :actualite_categorizations, :source => :section

  acts_as_indexed :fields => [:titre, :contenu]

  validates :titre, :presence => true, :uniqueness => true

  belongs_to :image

  scope :brulantes, where(['date_limite >  ?', Date.today])
  scope :normales,  where(['date_limite <= ?', Date.today])

  def title
    titre
  end

end
