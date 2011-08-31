class Section < ActiveRecord::Base

  acts_as_indexed :fields => [:nom, :titre, :chapeau]

  validates :nom,   :presence => true, :uniqueness => true
  validates :titre,   :presence => true
  validates :chapeau, :presence => true
  
  belongs_to :image
end
