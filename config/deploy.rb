lock '3.1.0'

set :application, 'plancache'
set :repo_url, 'git@github.com:JElbourne/PlanCache.git'

ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

set :use_sudo, false
set :bundle_binstubs, nil
set :linked_files, fetch(:linked_files, []).push('config/database.yml', "config/application.yml")
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

after 'deploy:publishing', 'deploy:restart'
after "deploy:restart", "deploy:cleanup"

set :test_log, "log/capistrano.test.log"

namespace :deploy do
  desc "Runs test before deploying, can't deploy unless they pass"
  task :run_tests do
    test_log = "log/capistrano.test.log"
    tests = fetch(:tests)
    tests.each do |test|
      puts "--> Running tests: '#{test}', please wait ..."
      unless system "bundle exec rspec #{test} > #{test_log} 2>&1"
        puts "--> Tests: '#{test}' failed. Results in: #{test_log} and below:"
        system "cat #{test_log}"
        exit;
      end
      puts "--> '#{test}' passed"
    end
    puts "--> All tests passed"
    system "rm #{test_log}"
  end
  
  task :restart do
    invoke 'unicorn:reload'
  end
end
