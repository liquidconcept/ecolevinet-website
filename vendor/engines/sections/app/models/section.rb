class Section < ActiveRecord::Base

  acts_as_indexed :fields => [:nom, :titre, :chapeau]

  validates :nom,   :presence => true, :uniqueness => true
  validates :titre,   :presence => true
  validates :chapeau, :presence => true
  validates :lien, :format => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix, :allow_blank => true

  belongs_to :image

  belongs_to :page

  has_many :actualite_categorizations
  has_many :actualites, :through => :actualite_categorizations

  has_many :portfolio_entry_categorizations
  has_many :portfolio_entries, :through => :portfolio_entry_categorizations

  #Create a page if section not linked to a page
  def after_save
    section = self
    if section.page_id.blank?
      section_page = Page.create(:title => section.nom,
                                 :show_in_menu => false,
                                 :deletable => false,
                                 :position => Page.maximum("position") + 1)

      section_page.parts.create({
        :title => "nom",
        :body =>  section.nom,
        :position => 0})
      section_page.parts.create({
        :title => "titre",
        :body =>  section.titre,
        :position => 1})
      section_page.parts.create({
        :title => "chapeau",
        :body =>   section.chapeau,
        :position => 2})
      section_page.parts.create({
        :title => "lien",
        :body => section.lien,
        :position => 3})
      #update Section page_id
        section.page_id = section_page.id
        section.save
    end
  end
  def before_save
    section = self
    # correponding page updated if section updated
    if section.changed? && !(section.page_id.blank?)
      page = Page.find(section.page_id)
      page.title = section.nom
      page.parts.each do |p|
        p.body = section.send(p.title)
      end
      page.save
    end
  end
end
