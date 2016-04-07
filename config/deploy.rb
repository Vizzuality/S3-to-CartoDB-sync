lock '3.4.0'

set :application, 's3_to_cartodb_sync'
set :deploy_user, 'ubuntu'
set :scm, :git
set :repo_url, 'git@github.com:Vizzuality/S3-to-CartoDB-sync.git'
set :passenger_restart_with_touch, true

set :rvm_type, :auto
set :rvm_ruby_version, '2.3.0-p0#s3_to_cartodb_sync'
set :rvm_roles, [:app, :web]

set :branch, 'master'
set :deploy_to, '~/ubuntu/s3_to_cartodb_sync'

set :keep_releases, 5

set :linked_files, %w{.env}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

namespace :deploy do
  after 'deploy:symlink:shared', 'deploy:compile_assets_locally'
  after :finishing, 'deploy:cleanup'
  after 'deploy:publishing', 'deploy:restart'
end
