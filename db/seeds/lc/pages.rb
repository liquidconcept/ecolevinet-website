# encoding: UTF-8
Page.all.each {|p| p.destroy!}

::Page.reset_column_information
# Check whether all columns are applied yet by seo_meta.
unless !defined?(::SeoMeta) || ::SeoMeta.attributes.keys.all? { |k|
  ::Page.translation_class.instance_methods.include?(k)
}
  # Make pages model seo_meta because not all columns are accessible.
  ::Page.translation_class.send :is_seo_meta
end

page_position = -1

home_page = Page.create(:title => "Accueil",
            :deletable => false,
            :link_url => "/",
            :position => (page_position += 1))
home_page.parts.create({
              :title => "Contenu",
              :body => "<p>Merci de remplir du contenu</p>",
              :position => 0
            })

home_page_position = -1

admission_page = home_page.children.create(:title => "Admission",
            :show_in_menu => true,
            :deletable => true,
            :position => (home_page_position += 1))

admission_page.parts.create({
              :title => "Contenu",
              :body => "<p>contenu de la page des admissions",
              :position => 0
            })

cours_page = home_page.children.create(:title => "Cours",
            :show_in_menu => true,
            :deletable => true,
            :position => (home_page_position += 1))

cours_page.parts.create({
              :title => "Contenu",
              :body => "<p>contenu de la page des cours",
              :position => 0
            })

contact_page = home_page.children.create(:title => "Contact",
            :show_in_menu => true,
            :deletable => true,
            :position => (home_page_position += 1))

contact_page.parts.create({
              :title => "Contenu",
              :body => "<p>contenu de la page des contacts",
              :position => 0
            })
about_page = home_page.children.create(:title => "About",
            :show_in_menu => true,
            :deletable => true,
            :position => (home_page_position += 1))

about_page.parts.create({
              :title => "Contenu",
              :body => "<p>contenu de la page about",
              :position => 0
            })


page_not_found_page = home_page.children.create(:title => "Page inexistante",
            :menu_match => "^/404$",
            :show_in_menu => false,
            :deletable => false,
            :position => (home_page_position += 1))

page_not_found_page.parts.create({
              :title    => "Contenu",
              :body     => "<h2>Désolé, il y a eu un problème </h2><p>La page demandée n'existe pas.</p><p><a href='/'>Retour à l'accueil</a></p>",
              :position => 0
            })

