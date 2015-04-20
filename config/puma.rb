application_path = File.expand_path("../..", __FILE__)
pidfile "#{application_path}/tmp/pids/puma.pid"
bind "unix://#{application_path}/tmp/sockets/puma.socket"
state_path "#{application_path}/tmp/pids/puma.state"
stdout_redirect "#{application_path}/log/puma.stdout.log", "#{application_path}/log/puma.stderr.log"

preload_app!

rackup      DefaultRackup
port        ENV['RACK_PORT']
environment ENV['RACK_ENV']



on_worker_boot do
  # Worker specific setup for Rails 4.1+
  # See: https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#on-worker-boot
  ActiveRecord::Base.establish_connection
end
