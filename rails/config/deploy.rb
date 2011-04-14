set :domain, "lunchrandomizer.com"
set :application, "lunchrandomizer"

set :user, Capistrano::CLI.ui.ask("Username: ")
set :use_sudo, false
set :deploy_to, "~/#{domain}"


set :scm, :git
set :branch, 'master'
set :repository,  "git://github.com/yuriy1337/Lunch-Randomizer.git"
# this might cause some issues
set :deploy_via, :remote_cache

role :web, domain                          # Your HTTP server, Apache/etc
role :app, domain                          # This may be the same as your `Web` server
role :db,  Capistrano::CLI.ui.ask("DB URL: "), :primary => true # This is where Rails migrations will run

namespace :deploy do
  desc "cause Passenger to initiate a restart"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
end

after "deploy:update_code", :bundle_install
desc "install the necessary prerequisites"
task :bundle_install, :roles => :app do
  run "cd #{release_path} && bundle install --without development test"
end