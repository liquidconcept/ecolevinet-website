# encoding: UTF-8
::I18n.locale = :fr

if defined?(User)

  available_plugins  = ::Refinery::Plugins.registered.in_menu.collect{|a|{:name => a.name, :title => a.title}}.sort_by {|a| a[:title]}
  admin_plugins = available_plugins.reject{|pl| RefineryConfig.hidden_plugins.include? pl[:name] }.map{|p|p[:name]} -
["refinery_settings", "refinery_dashboard", "sections"]

  restricted_plugins = admin_plugins - ["refinery_users"]

  available_plugins  = available_plugins.map{|p|p[:name]}
  #Admin profile if needed
  if User.find_by_username('admin').blank?
    admin = User.new(:username => 'admin',
    :email => 'admin@example.com',
    :password => 'admin',
    :password_confirmation => 'admin')
    admin.add_role('Refinery')
    admin.save!
    admin.plugins= admin_plugins
    admin.save!
  end

  #Lconcept profile if needed
  if User.find_by_username('lconcept').blank?
    admin = User.new(:username => 'lconcept',
    :email => 'lconcept@example.com',
    :password => 'lconcept',
    :password_confirmation => 'lconcept')
    admin.add_role('Refinery')
    admin.add_role('Superuser')
    admin.save!
    admin.plugins= available_plugins
    admin.save!
  end

  #clerck profile if needed
  if User.find_by_username('secretariat').blank?
    demo = User.new(:username => 'secretariat',
    :email => 'secretariat@example.com',
    :password => 'secretariat',
    :password_confirmation => 'secretariat')
    demo.add_role('Refinery')
    demo.save!
    demo.plugins= restricted_plugins
    demo.save!
  end
end
