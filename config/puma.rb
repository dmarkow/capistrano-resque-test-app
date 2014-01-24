threads 1,2
workers 1
daemonize
state_path '/data/www/capistrano-resque-test-app/shared/tmp/pids/puma.state'
pidfile "/data/www/capistrano-resque-test-app/shared/tmp/pids/puma.pid"
stdout_redirect "/data/www/capistrano-resque-test-app/shared/log/puma.stdout.log", "/data/www/capistrano-resque-test-app/shared/log/puma.stderr.log", true
bind 'unix:///tmp/puma_capistrano-resque-test-app.sock'
environment 'production'

preload_app!

on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end
end
