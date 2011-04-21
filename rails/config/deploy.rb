#Setup the server details
set :domain, "lunchrandomizer.com"
set :application, "lunchrandomizer"

#Setup the user details. Will be prompted for password
set :user, Capistrano::CLI.ui.ask("Username: ")
set :use_sudo, false
set :deploy_to, "~/#{domain}"

#Setup SCM details.
set :scm, :git
set :branch, 'master'
set :repository,  "git://github.com/yuriy1337/Lunch-Randomizer.git"
set :deploy_subdir, "rails"
set :deploy_via, :remote_cache

#Setup Database details
set :production_database, "#{application}_production"

#Set server DNS'
role :web, domain
role :app, domain, :primary => true
role :db, domain
#role :db,  "mysql.lunchrandomizer.com", :primary => true # This is where Rails migrations will run

# During the deploy force Passenger to restart
namespace :deploy do
  desc "Cause Passenger to initiate a restart"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
end

#Having issues with this right now. Works locally on the box though.
#after "deploy:update_code", :bundle_install
desc "install the necessary prerequisites"
task :bundle_install, :roles => :app do
  run "cd #{release_path} && bundle install --without development test"
end

#Use the database.yml file in the shared directory
after "deploy:update_code", "db:symlink"
namespace :db do
  desc "Make symlink for database yaml"
  task :symlink do
    run "ln -nfs #{shared_path}/config/database.yml #{latest_release}/config/database.yml"
  end
end

