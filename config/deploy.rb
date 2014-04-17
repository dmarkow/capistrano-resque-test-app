set :application, 'capistrano-resque-test-app'
set :repo_url, 'git@github.com:dmarkow/capistrano-resque-test-app'
set :rbenv_type, :system
set :rbenv_custom_path, "/opt/rbenv"
set :rbenv_ruby, "github-2.1"
set :deploy_to, '/data/www/capistrano-resque-test-app'
set :format, :pretty
set :log_level, :debug
set :workers, { "foo" => 1, "bar" => 1}
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# set :deploy_to, '/var/www/my_app'
# set :scm, :git

set :format, :pretty
set :log_level, :debug
# set :pty, true

# set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
# set :keep_releases, 5

namespace :deploy do
  desc 'Start application'
  task :start do
    on roles(:app) do
      within "/data/www/capistrano-resque-test-app/current" do
        execute "ruby", "bin/puma -C ./config/puma.rb"
      end
    end
  end

  desc 'Stop application'
  task :stop do
    on roles(:all) do
      within "/data/www/capistrano-resque-test-app/current" do
        execute "ruby", "bin/pumactl -S /data/www/capistrano-resque-test-app/shared/tmp/pids/puma.state stop"
      end
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      within "/data/www/capistrano-resque-test-app/current" do
        execute "ruby", "bin/pumactl -S /data/www/capistrano-resque-test-app/shared/tmp/pids/puma.state phased-restart"
      end
    end
  end

  desc 'Status'
  task :status do
    on roles(:app) do
      execute "ruby", "bin/pumactl -S /data/www/capistrano-resque-test-app/shared/tmp/pids/puma.state stats"
      exec pumactl -S #{fetch(:puma_state)} stats
    end
  end

  after :finishing, 'deploy:cleanup'
end
