namespace :maintenance do
  ConfigSite={:site_name => "Ecole Vinet", :default_page_parts => ["Contenu"]}

  desc "set default page part"
  task :set_default_page_parts  => :environment do

    RefinerySetting.set(:default_page_parts, ConfigSite[:default_page_parts])

  end

  desc "set site name"
  task :set_site_name  => :environment do

    RefinerySetting.set('site_name', ConfigSite[:site_name])

  end

  desc  "set site to french (Allez les frouses)"
  task :set_site_to_french  => :environment do

    RefinerySetting.set(:i18n_translation_current_locale,           {:value => :fr   , :scoping => :refinery })
    RefinerySetting.set(:i18n_translation_default_frontend_locale,  {:value => :fr   , :scoping => :refinery })
    RefinerySetting.set(:i18n_translation_default_locale,           {:value => :fr   , :scoping => :refinery })
    RefinerySetting.set(:i18n_translation_frontend_locales,         {:value => [:fr] , :scoping => :refinery })

  end

  desc "toogle page part creation (default is set to false)"
  task :toggle_page_part_creation  => :environment do

    RefinerySetting.set(:new_page_parts, !RefinerySetting.get(:new_page_parts))

  end

  desc "populate english seed data for french locale"
  task :seed_for_french  => :environment do

    ::I18n.locale = :fr
    load Rails.root.join('db', 'seeds', 'pages.rb').to_s

  end
  
  desc "populate data pages (lc)"
  task :seed_for_pages  => :environment do

    ::I18n.locale = :fr
    load Rails.root.join('db', 'seeds', 'lc', 'pages.rb').to_s

  end


end
