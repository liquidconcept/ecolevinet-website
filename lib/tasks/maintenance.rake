namespace :maintenance do

  desc "set default page part"
  task :set_default_page_parts  => :environment do

    RefineryConfig.set_default_page_parts

  end

  desc "set default image sizes"
  task :set_default_image_sizes  => :environment do

    RefineryConfig.set_default_image_sizes

  end


  desc "set default plugins order"
  task :set_default_plugins_order => :environment do

    RefineryConfig.set_default_plugins_order

  end

  desc "set site name"
  task :set_site_name  => :environment do

    RefineryConfig.set_site_name

  end

  desc  "set site to french (Allez les frouses)"
  task :set_site_to_french  => :environment do

    RefineryConfig.set_site_to_french

  end


  desc "general maintenance task"
  task :setup => [ :environment, :set_default_page_parts, :set_site_name, :set_site_to_french, :set_default_image_sizes ] do

    RefineryConfig.setup

  end

  desc "toogle page part creation (default is set to false)"
  task :toggle_page_part_creation  => :environment do

    RefineryConfig.toggle_page_part_creation

  end

  desc "friendly_id for a model"
  task :friendly => :environment do

    RefineryConfig.friendly

  end
end
