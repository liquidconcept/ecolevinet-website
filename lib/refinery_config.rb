# encoding: UTF-8
require 'rake'

class RefineryConfig

  REFINERY_CONFIG={:site_name => "Ecole Vinet",
    :default_page_parts => ["Contenu"],
    :plugins_order => {
    #user related plugins
    "refinery_pages"      => 1,
    "sections"            => 2,
    "news"                => 3,
    "portfolio"           => 4,
    "events"              => 5,
    "refinery_images"     => 6,
    "refinery_files"      => 7,
    "refinery_users"      => 8,
    #superuser related plugins
    "refinery_settings"   => 10,
    "refinery_dashboard"  => 11,
    #base plugins
    "refinerycms_base"    => 12,
    "refinery_core"       => 13,
    "refinery_dialogs"    => 14,
    "refinery_i18n"       => 15,
    "refinery_generators" => 16,
    "page_images"         => 17},
    :default_image_sizes =>  {:small  => '110x110', :medium => '225x255', :large => '870x328'},
    :hidden_plugins => ["portfolio","news"]
  }

  #set default page parts
  def self.set_default_page_parts

    RefinerySetting.set(:default_page_parts, REFINERY_CONFIG[:default_page_parts])

  end

  #set default image sizes
  def self.set_default_image_sizes

    RefinerySetting.set(:default_image_sizes, REFINERY_CONFIG[:default_image_sizes])

  end


  #set default plugins order
  def self.set_default_plugins_order

    REFINERY_CONFIG[:plugins_order].each do | k, v |
      ups = UserPlugin.where(:name => k)
      ups.each do |up|
        up.position=v;
        up.save;
      end
    end

  end

  #set site name
  def self.set_site_name

    RefinerySetting.set('site_name', REFINERY_CONFIG[:site_name])

  end

  #set site to french
  def self.set_site_to_french

    RefinerySetting.set(:i18n_translation_current_locale,           {:value => :fr   , :scoping => :refinery })
    RefinerySetting.set(:i18n_translation_default_frontend_locale,  {:value => :fr   , :scoping => :refinery })
    RefinerySetting.set(:i18n_translation_default_locale,           {:value => :fr   , :scoping => :refinery })
    RefinerySetting.set(:i18n_translation_frontend_locales,         {:value => [:fr] , :scoping => :refinery })

  end


  #general maintenance
  def self.setup

    RefineryConfig.set_default_page_parts
    RefineryConfig.set_site_name
    RefineryConfig.set_site_to_french
    RefineryConfig.set_default_image_sizes

  end

  #toogle page part creation (default is set to false)
  def self.toggle_page_part_creation
    RefinerySetting.set(:new_page_parts, !RefinerySetting.get(:new_page_parts))
  end

  #get hidden plugins
  def self.hidden_plugins
     REFINERY_CONFIG[:hidden_plugins]
  end

  #generate friendly ids
  def self.friendly
    system ("rake friendly_id:make_slugs   MODEL='Page' --trace ")
  end

end
