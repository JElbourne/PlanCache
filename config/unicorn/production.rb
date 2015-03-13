worker_processes 4
# user "unprivileged_user", "unprivileged_group"
 
listen "/tmp/unicorn.plancache.sock", :backlog => 64
listen 8080, :tcp_nopush => true
 
timeout 30

root = "/home/deployer/apps/plancache/current"
working_directory root

pid "#{root}/tmp/pids/unicorn.pid"

stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"
 
# # feel free to point this anywhere accessible on the filesystem
# pid "/u/apps/yourappdirectory/shared/pids/unicorn.pid"
#
# stderr_path "/u/apps/yourappdirectory/shared/log/unicorn.stderr.log"
# stdout_path "/u/apps/yourappdirectory/shared/log/unicorn.stdout.log"
 
# combine REE with "preload_app true" for memory savings
# http://rubyenterpriseedition.com/faq.html#adapt_apps_for_cow
preload_app true
GC.respond_to?(:copy_on_write_friendly=) and
  GC.copy_on_write_friendly = true
 
before_fork do |server, worker|
  # the following is highly recomended for Rails + "preload_app true"
  # as there's no need for the master process to hold a connection
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
 
  # old_pid = "#{server.config[:pid]}.oldbin"
  # if old_pid != server.pid
  #   begin
  #     sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
  #     Process.kill(sig, File.read(old_pid).to_i)
  #   rescue Errno::ENOENT, Errno::ESRCH
  #   end
  # end
  # graceful shutdown.
  old_pid_file = "#{root}/tmp/pids/unicorn.pid.oldbin"
  if File.exists?(old_pid_file) && server.pid != old_pid_file
    begin
      old_pid = File.read(old_pid_file).to_i
      server.logger.info("sending QUIT to #{old_pid}")
      # we're killing old unicorn master right there
      Process.kill("QUIT", old_pid)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end
 
after_fork do |server, worker|
  # the following is *required* for Rails + "preload_app true",
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end


# root = "/home/deployer/apps/plancache/current"
# working_directory root
#
# pid "#{root}/tmp/pids/unicorn.pid"
#
# stderr_path "#{root}/log/unicorn.log"
# stdout_path "#{root}/log/unicorn.log"
#
# worker_processes 4
# timeout 30
# preload_app false
#
# #listen "#{root}/tmp/sockets/unicorn.sock"
# listen '/tmp/unicorn.plancache.sock'#, backlog: 64
#
# before_fork do |server, worker|
#   Signal.trap 'TERM' do
#     puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
#     Process.kill 'QUIT', Process.pid
#   end
#
#   defined?(ActiveRecord::Base) and
#     ActiveRecord::Base.connection.disconnect!
# end
#
# after_fork do |server, worker|
#   Signal.trap 'TERM' do
#     puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
#   end
#
#   defined?(ActiveRecord::Base) and
#     ActiveRecord::Base.establish_connection
# end
#
# # Force the bundler gemfile environment variable to
# # reference the capistrano "current" symlink
# before_exec do |_|
#   ENV['BUNDLE_GEMFILE'] = File.join(root, 'Gemfile')
# end