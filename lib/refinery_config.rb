class RefineryConfig

  REFINERY_CONFIG={:site_name => "Ecole Vinet", :default_page_parts => ["Contenu"],
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
    :default_image_sizes =>  {:small  => '110x110', :medium => '225x255', :large => '870x328'},
    :hidden_plugins => ["portfolio","actualites"]
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

    self.set_default_page_parts
    self.set_site_name
    self.set_site_to_french
    self.set_default_image_sizes

  end

  #toogle page part creation (default is set to false)
  def self.toggle_page_part_creation
    RefinerySetting.set(:new_page_parts, !RefinerySetting.get(:new_page_parts))
  end

  #get hidden plugins
  def self.hidden_plugins
     REFINERY_CONFIG[:hidden_plugins]
  end


end
