lock '3.5.0'

set :application, 'personal_website'
set :repo_url, 'git@github.com:nick-desteffen/personal_website.git'
set :branch, 'master'
set :deploy_to, '/var/www/apps/personal_website'
set :scm, :git
set :format, :pretty
set :log_level, :info
set :pty, true
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')
set :keep_releases, 5
set :passenger_restart_with_sudo, true
set :passenger_restart_options, -> { "#{deploy_to} --ignore-app-not-running" }
