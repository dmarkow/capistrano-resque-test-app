set :application, "capistrano-resque-test-app"
set :repository,  'git@github.com:dmarkow/capistrano-resque-test-app'

set :rbenv_type, :system
set :rbenv_path, "/opt/rbenv"
set :rbenv_ruby_version, "2.1.2"
set :deploy_to, '/data/www/capistrano-resque-test-app'
set :format, :pretty
set :log_level, :debug
set :workers, { "foo" => 1, "bar" => 1}
set :resque_pid_path, -> { File.join(shared_path, "x", "y") }
set :resque_log_file, "log.log"

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :app, "dylan@54.200.88.50"
role :web, "dylan@54.200.88.50"
role :db, "dylan@54.200.88.50"
role :resque_worker, "dylan@54.200.88.50"


# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end