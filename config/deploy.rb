# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'PlanCache'
set :deploy_user, 'jbourne'

# setup repo details
set :scm, :git
set :repo_url, 'git@github.com:JElbourne/PlanCache.git'

# # setup rvm.
# set :rbenv_type, :system
set :rbenv_ruby, '2.2.0'



# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'PlanCache'
set :repo_url, 'git@github.com:JElbourne/PlanCache.git'

set :linked_files, %w{config/database.yml .env}
set :linked_dirs, %w{tmp/pids}

set :unicorn_config_path, "config/unicorn.rb"

set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_ruby, '2.2.0'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'unicorn:restart'
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
