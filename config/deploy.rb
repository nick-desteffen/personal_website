lock '3.4.0'

set :application, 'personal_website'
set :repo_url, 'git@github.com:nick-desteffen/personal_website.git'
set :branch, 'master'
set :deploy_to, '/var/www/apps/personal_website'
set :scm, :git
set :format, :pretty
set :log_level, :debug
set :pty, true
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')
set :keep_releases, 5
set :passenger_restart_with_sudo, true

namespace :deploy do
  after :finishing, 'deploy:cleanup'
end
