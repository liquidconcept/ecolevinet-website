# encoding: UTF-8
::I18n.locale = :fr
if defined?(User)
  User.all.each do |user|
    if user.plugins.where(:name => 'sections').blank?
      user.plugins.create(:name => 'sections',
                          :position => (user.plugins.maximum(:position) || -1) +1)
    end
  end
end

if defined?(Section)
  s = Section.create(:nom => "Découvrir VINET", :titre => "Préparez-vous à l'examen d'admission en 1er année de gymnase!",
                 :chapeau => "Découvrez nos programmes, les conditions d'admission et l'organisation de notre école qui vous permettrons d'atteindre vos rêves.",
                 position: Page.maximum("position") + 1, :lien => "")

  if defined?(Page) && defined?(Actualite)
    page = s.page.children.create(
      :title => 'Actualites',
      :deletable => false,
      :show_in_menu => false,
      :position => s.page.position + 1)
    Page.default_parts.each do |default_page_part|
      page.parts.create(:title => default_page_part, :body => nil)
    end
  end
  if defined?(Page) && defined?(Portfolio)
    page = s.page.children.create(
      :title => 'Galerie',
      :deletable => false,
      :show_in_menu => false,
      :position => s.page.position + 1)
    Page.default_parts.each do |default_page_part|
      page.parts.create(:title => default_page_part, :body => nil)
    end
  end



  s = Section.create(:nom => "Elèves", :titre => "Découvrez les dernières photos du camp de ski!",
                 :chapeau => "Les photos du camp de ski de la classe de VSB sont à disposition dans notre section galerie photo depuis le 18 janvier 2012." ,
                 position: Page.maximum("position") + 1, :lien => "")

  if defined?(Page) && defined?(Actualite)
    page = s.page.children.create(
      :title => 'Actualites',
      :deletable => false,
      :show_in_menu => false,
      :position => s.page.position + 1)
    Page.default_parts.each do |default_page_part|
      page.parts.create(:title => default_page_part, :body => nil)
    end
  end
  if defined?(Page) && defined?(Portfolio)
    page = s.page.children.create(
      :title => 'Galerie',
      :deletable => false,
      :show_in_menu => false,
      :position => s.page.position + 1)
    Page.default_parts.each do |default_page_part|
      page.parts.create(:title => default_page_part, :body => nil)
    end
  end


  s = Section.create(:nom => "Enseignants", :titre => "Les programmes des classes ont été mis à jour.",
                 :chapeau => "Découvrez les programmes des classes et vos horaires définitifs pour l'année 2011-2012 en vous connectant à votre espace privé." ,
                 position: Page.maximum("position") + 1, :lien => "")

  if defined?(Page) && defined?(Actualite)
    page = s.page.children.create(
      :title => 'Actualites',
      :deletable => false,
      :show_in_menu => false,
      :position => s.page.position + 1)
    Page.default_parts.each do |default_page_part|
      page.parts.create(:title => default_page_part, :body => nil)
    end
  end
  if defined?(Page) && defined?(Portfolio)
    page = s.page.children.create(
      :title => 'Galerie',
      :deletable => false,
      :show_in_menu => false,
      :position => s.page.position + 1)
    Page.default_parts.each do |default_page_part|
      page.parts.create(:title => default_page_part, :body => nil)
    end
  end


  s = Section.create(:nom => "Parents", :titre => "Mettez toutes les chances de votre côté pour le succès de votre enfant!",
                 :chapeau => "Découvrez notre philosophie de pédagogie, l'organisation de l'école, les programmes, le corps enseignants et les conditions d'admission.",
                 position: Page.maximum("position") + 1, :lien => "")

  if defined?(Page) && defined?(Actualite)
    page = s.page.children.create(
      :title => 'Actualites',
      :deletable => false,
      :show_in_menu => false,
      :position => s.page.position + 1)
    Page.default_parts.each do |default_page_part|
      page.parts.create(:title => default_page_part, :body => nil)
    end
  end
  if defined?(Page) && defined?(Portfolio)
    page = s.page.children.create(
      :title => 'Galerie',
      :deletable => false,
      :show_in_menu => false,
      :position => s.page.position + 1)
    Page.default_parts.each do |default_page_part|
      page.parts.create(:title => default_page_part, :body => nil)
    end
  end



end
