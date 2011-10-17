# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
# Refinery seeds
#Dir[Rails.root.join('db', 'seeds', '*.rb').to_s].each do |file|
#  puts "Loading db/seeds/#{file.split(File::SEPARATOR).last}"
#  load(file)
#end
Page.reset_column_information
::I18n.locale = :fr

# Refinery related setup :   default_page_parts, site_name, set_site_to_french ,set_default_image_sizes
RefineryConfig.setup
RefinerySetting.find_or_set(:use_marketable_urls, true)

load(Rails.root.join('db', 'seeds', 'sections.rb'))
load(Rails.root.join('db', 'seeds', 'pages.rb'))
load(Rails.root.join('db', 'seeds', 'portfolios.rb'))
load(Rails.root.join('db', 'seeds', 'news_items.rb'))
load(Rails.root.join('db', 'seeds', 'users.rb'))

RefineryConfig.set_default_plugins_order
RefineryConfig.friendly
RefineryConfig.one_level_portfolio

