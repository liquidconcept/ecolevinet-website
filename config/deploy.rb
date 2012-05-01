# encoding: utf-8
set :application, 'website'
set :domain,      'ecolevinet.ch'
set :server_name, '95.142.162.83'
set :real_domain,  "www.#{domain}"

set :scm,         :git
set :repository,  'git@git.liquid-concept.ch:clients/ecole-vinet/website.git'
set :branch,      ENV['deploy_branch'] || 'production'

ssh_options[:forward_agent] = true

default_run_options[:pty] = true
default_environment['LC_CTYPE'] = 'en_US.UTF-8'

set :user,        'webpublisher'
set :deploy_via,  :remote_cache
set :deploy_to,   "/var/www/#{domain}/#{application}"
set :use_sudo,    false

set :bundle_without,  [:development, :staging, :test, :guard]

role :web, server_name                          # Your HTTP server, Apache/etc
role :app, server_name                          # This may be the same as your `Web` server
role :db,  server_name, :primary => true        # This is where Rails migrations will run

namespace :deploy do
  task :start, :roles => :app do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

after 'deploy:update_code' do
  run "mkdir -p #{File.join(shared_path,'config')} && rm -f #{File.join(release_path,'config','database.yml')} && ln -s #{File.join(shared_path,'config','database.yml')} #{File.join(release_path,'config','database.yml')}"
  run "mkdir -p #{File.join(shared_path,'vinetprofs')} && rm -f #{File.join(release_path,'public','vinetprofs')} && ln -s #{File.join(shared_path,'vinetprofs','vinetprofs')} #{File.join(release_path,'public','vinetprofs')}"
end

after 'deploy:update', 'deploy:cleanup'
after 'deploy:migrations', 'deploy:cleanup'

#
# finish
#

require './config/boot'
require 'airbrake/capistrano'
