class Section < ActiveRecord::Base

  acts_as_indexed :fields => [:title, :heading_title, :heading]

  validates :title,   :presence => true, :uniqueness => true
  validates :heading_title,   :presence => true
  validates :link, :format => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix, :allow_blank => true

  belongs_to :image

  belongs_to :page

  has_many :news_item_categorizations
  has_many :news_items, :through => :news_item_categorizations

  has_many :portfolio_entry_categorizations
  has_many :portfolio_entries, :through => :portfolio_entry_categorizations

  has_many :event_categorizations
  has_many :events, :through => :event_categorizations

  default_scope :order => 'position'

  #Create a page if section_id nil
  def after_save
    section = self
    if section.page_id.blank?
      section_page = Page.create(:title => section.title,
                                 :show_in_menu => false,
                                 :deletable => false,
                                 :position => ((Page.maximum(:position, :conditions => {:parent_id => nil}) || -1)+1)
                                )

      section_page.parts.create({
        :title => "title",
        :body =>  section.title,
        :position => 0})
      section_page.parts.create({
        :title => "heading_title",
        :body =>  section.heading_title,
        :position => 1})
      section_page.parts.create({
        :title => "heading",
        :body =>   section.heading,
        :position => 2})
      section_page.parts.create({
        :title => "link",
        :body => section.link,
        :position => 3})
      #update Section page_id
      section.page_id = section_page.id
      section.save
      #Add an news Page
      unless RefineryConfig.hidden_plugins.include?("news_items")
        page = section_page.children.create(:title => 'Actualités',
          :deletable => false,
          :data_type => 'news_items',
          :show_in_menu => true,
          :position => section_page.position + 1)
        Page.default_parts.each do |default_page_part|
          page.parts.create(:title => default_page_part, :body => nil)
        end
      end
      #Add a Portfolio Page
      unless RefineryConfig.hidden_plugins.include?("portfolio")
        page = section_page.children.create(
          :title => 'Galerie',
          :deletable => false,
          :show_in_menu => true,
          :position => section_page.position + 1)
        Page.default_parts.each do |default_page_part|
          page.parts.create(:title => default_page_part, :body => nil)
        end
      end
    end
  end

  def before_save
    section = self
    # correponding page updated if section updated
    if section.changed? && !(section.page_id.blank?)
      page = Page.find(section.page_id)
      page.title = section.title
      page.parts.each do |p|
        p.body = section.send(p.title)
      end
      page.save
    end
  end
end
