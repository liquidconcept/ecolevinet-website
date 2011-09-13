namespace :maintenance do

  ConfigSite={:site_name => "Ecole Vinet", :default_page_parts => ["Contenu"],
  :plugins_order => {
#user related plugins
  "refinery_pages"      => 1,
  "sections"            => 2,
  "actualites"          => 3,
  "portfolio"           => 4,
  "refinery_images"     => 5,
  "refinery_files"      => 6,
  "refinery_users"      => 7,
#superuser related plugins
  "refinery_settings"   => 8,
  "refinery_dashboard"  => 9,
#base plugins
  "refinerycms_base"    => 10,
  "refinery_core"       => 11,
  "refinery_dialogs"    => 12,
  "refinery_i18n"       => 13,
  "refinery_generators" => 14,
  "page_images"         => 15},
  :default_image_sizes =>  {:small  => '110x110', :medium => '225x255', :large => '870x328'}
  }

  desc "set default page part"
  task :set_default_page_parts  => :environment do

    RefinerySetting.set(:default_page_parts, ConfigSite[:default_page_parts])

  end
  
  desc "set default image sizes"
  task :set_default_image_sizes  => :environment do

    RefinerySetting.set(:default_image_sizes, ConfigSite[:default_image_sizes])

  end


  desc "set default plugins order"
  task :set_default_plugins_order => :environment do
    ConfigSite[:plugins_order].each {| k, v | up = UserPlugin.find_by_name(k);up.position=v; up.save; }
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


  desc "general maintenance task"
  task :setup => [ :environment, :set_default_page_parts, :set_site_name, :set_site_to_french, :set_default_plugins_order, :set_default_image_sizes ] do

    Rake::Task['maintenance:set_default_page_parts'].invoke
    Rake::Task['maintenance:set_site_name'].invoke
    Rake::Task['maintenance:set_site_to_french'].invoke
    Rake::Task['maintenance:set_default_plugins_order'].invoke
    Rake::Task['maintenance:set_default_image_sizes'].invoke

  end

  desc "toogle page part creation (default is set to false)"
  task :toggle_page_part_creation  => :environment do

    RefinerySetting.set(:new_page_parts, !RefinerySetting.get(:new_page_parts))

  end

end
