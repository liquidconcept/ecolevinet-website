# encoding: UTF-8
::I18n.locale = :fr

if defined?(User)

  available_plugins  = ::Refinery::Plugins.registered.in_menu.collect{|a|{:name => a.name, :title => a.title}}.sort_by {|a| a[:title]}
  restricted_plugins = available_plugins.reject{|pl| RefineryConfig.hidden_plugins.include? pl[:name] }.map{|p|p[:name]} -
["sections",
 "refinery_settings",
 "refinery_dashboard",
 "refinery_users"]

  available_plugins  = available_plugins.map{|p|p[:name]}
  #Admin profile
  admin = User.new(:username => 'admin',
  :email => 'admin@example.com',
  :password => 'admin',
  :password_confirmation => 'admin')
  admin.add_role('Refinery')
  admin.add_role('Superuser')
  admin.save!
  admin.plugins= restricted_plugins
  admin.save!

  #Lconcept profile
  admin = User.new(:username => 'lconcept',
  :email => 'lconcept@example.com',
  :password => 'lconcept',
  :password_confirmation => 'lconcept')
  admin.add_role('Refinery')
  admin.add_role('Superuser')
  admin.save!
  admin.plugins= available_plugins
  admin.save!

  #clerck profile
  demo = User.new(:username => 'secretariat',
  :email => 'secretariat@example.com',
  :password => 'secretariat',
  :password_confirmation => 'secretariat')
  demo.add_role('Refinery')
  demo.save!
  demo.plugins= restricted_plugins
  demo.save!
end
