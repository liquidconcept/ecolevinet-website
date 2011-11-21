# encoding: utf-8
set :application, 'website'
set :domain,      'www.ecolevinet.ch'
set :server_name, '195.141.44.140'
set :real_domain,  domain

set :scm,         :git
set :repository,  'git@git.liquid-concept.ch:clients/ecole-vinet/website.git'
set :branch,      ENV['deploy_branch'] || 'production'

ssh_options[:forward_agent] = true

default_run_options[:pty] = true
default_environment['LC_CTYPE'] = 'en_US.UTF-8'

set :user,        'f207235'
set :deploy_via,  :remote_cache
set :deploy_to,   '/hosting/customers/www.ecolevinet.ch'
set :use_sudo,    false

set :bundle_without,  [:development, :test, :guard]

set :rvm_type, :user

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
  run "mkdir -p #{File.join(shared_path,'private_folders', 'vinetprofs')} && rm -f #{File.join(release_path,'public','vinetprofs')} && ln -s #{File.join(shared_path,'private_folders','vinetprofs')} #{File.join(release_path,'public','vinetprofs')}"
end

after 'deploy:update', 'deploy:cleanup'
after 'deploy:migrations', 'deploy:cleanup'

#
# finish
#

require './config/boot'
require 'airbrake/capistrano'
