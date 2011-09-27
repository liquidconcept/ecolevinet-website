# encoding: UTF-8

::I18n.locale = :fr
# create an image object out of a the image name string
def image_creation(image_name)
  image_path = Rails.root.join('public', 'images', image_name).to_s
  uploader = Dragonfly[:images]
  uploaded_image = uploader.fetch_file(image_path)
  image = Image.create image: uploaded_image
  rescue Error => e
     print "Error creating image: " + e
end


if defined?(Section) && defined?(Page) && Section.count == 0

  position = (Page.maximum("position") || 0 ) + 1
  s = Section.create(:title=> "Accueil", :heading_title => '« L\'ÉDUCATION DE L\'ESPRIT ET DU COEUR DOIT ÊTRE<br/> LE PREMIER OBJET DE TOUT SYSTÈME D\'ÉTUDE. »<span id="citation">Alexandre Vinet</span>',
                 :heading => "",
                 :image => image_creation('nav_picture.jpg'),
                 :position => position, :link => "")
  p = s.page
  p.link_url = '/'
  p.show_in_menu = true
  p.save
  position += 1
  s = Section.create(:title => "Découvrir VINET", :heading_title => "Préparez-vous à l'examen d'admission en 1er année de gymnase!",
                 :image => image_creation('nav_picture.jpg'),
                 :heading => "Découvrez nos programmes, les conditions d'admission et l'organisation de notre école qui vous permettrons d'atteindre vos rêves.",
                 :position => position, :link => "")
  p= s.page
  p.link_url="/sections/2"
  p.show_in_menu = true
  p.save

  position += 1
  s = Section.create(:title => "Elèves", :heading_title => "Découvrez les dernières photos du camp de ski!",
                 :image => image_creation('nav_picture.jpg'),
                 :heading => "Les photos du camp de ski de la classe de VSB sont à disposition dans notre section galerie photo depuis le 18 janvier 2012." ,
                 :position => position, :link => "")
  p= s.page
  p.link_url="/sections/3"
  p.show_in_menu = true
  p.save

  position += 1
  s = Section.create(:title => "Enseignants", :heading_title => "Les programmes des classes ont été mis à jour.",
                 :image => image_creation('nav_picture.jpg'),
                 :heading => "Découvrez les programmes des classes et vos horaires définitifs pour l'année 2011-2012 en vous connectant à votre espace privé." ,
                 :position => position, :link => "")

  p= s.page
  p.link_url="/sections/4"
  p.show_in_menu = true
  p.save

  position += 1
  s = Section.create(:title => "Parents", :heading_title => "Mettez toutes les chances de votre côté pour le succès de votre enfant!",
                 :image => image_creation('nav_picture.jpg'),
                 :heading => "Découvrez notre philosophie de pédagogie, l'organisation de l'école, les programmes, le corps enseignants et les conditions d'admission.",
                 :position => position, :link => "")

  p= s.page
  p.link_url="/sections/5"
  p.show_in_menu = true
  p.save

 end
