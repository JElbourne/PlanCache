lock '3.1.0'

set :application, 'plancache'
set :repo_url, 'git@github.com:JElbourne/PlanCache.git'

ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

set :use_sudo, false
set :bundle_binstubs, nil
set :linked_files, fetch(:linked_files, []).push('config/database.yml')
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

after 'deploy:publishing', 'deploy:restart'

namespace :deploy do
  task :restart do
    root = "/home/deployer/apps/plancache/current"
    old_pid = get_pid("#{root}/tmp/pids/unicorn.pid")
    run "kill -s SIGUSR2 $(cat #{root}/tmp/pids/unicorn.pid)"
    run "kill -s SIGWINCH #{old_pid}"
    
    invoke 'unicorn:reload'
  end
end
