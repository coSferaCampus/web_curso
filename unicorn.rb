# Sample verbose configuration file for Unicorn (not Rack)
#
# This configuration file documents many features of Unicorn
# that may not be needed for some applications. See
# http://unicorn.bogomips.org/examples/unicorn.conf.minimal.rb
# for a much simpler configuration file.
#
# See http://unicorn.bogomips.org/Unicorn/Configurator.html for complete
# documentation.

# Uncomment and customize the last line to run in a non-root path
# WARNING: We recommend creating a FQDN to host GitLab in a root path instead of this.
# Note that four settings need to be changed for this to work.
# 1) In your application.rb file: config.relative_url_root = "/gitlab"
# 2) In your gitlab.yml file: relative_url_root: /gitlab
# 3) In your unicorn.rb: ENV['RAILS_RELATIVE_URL_ROOT'] = "/gitlab"
# 4) In ../gitlab-shell/config.yml: gitlab_url: "http://127.0.0.1/gitlab"
# To update the path, run: sudo -u git -H bundle exec rake assets:precompile RAILS_ENV=production
#
# ENV['RAILS_RELATIVE_URL_ROOT'] = "/gitlab"

# Environment
environment = 'production'
ENV["SECRET_KEY_BASE"] = '5e7ad0006a77f5ab944e2f46b3e07a850aac0d1a0db82a0c9ee0ff2136945242dc1c9faa08e4d7192230d244b7692c807e0c2c37441c142acdf7ccf92ddd7ac0'

# Use at least one worker per core if you're on a dedicated server,
# more will usually help for _short_ waits on databases/caches.
worker_processes 1

# Since Unicorn is never exposed to outside clients, it does not need to
# run on the standard HTTP port (80), there is no reason to start Unicorn
# as root unless it's from system init scripts.
# If running the master process as root and the workers as an unprivileged
# user, do this to switch euid/egid in the workers (also chowns logs):
# user "unprivileged_user", "unprivileged_group"

# Help ensure your application will always spawn in the symlinked
# "current" directory that Capistrano sets up.
working_directory "/home/juan/code/curso" # available in 0.94.0+

# listen on both a Unix domain socket and a TCP port,
# we use a shorter backlog for quicker failover when busy
listen '127.0.0.1:9005', :tcp_nopush => true

# feel free to point this anywhere accessible on the filesystem
pid "/home/juan/code/curso/tmp/pids/unicorn.pid"

# By default, the Unicorn logger will write to stderr.
# Additionally, some applications/frameworks log to stderr or stdout,
# so prevent them from going to /dev/null when daemonized here:
stderr_path "/home/juan/code/curso/log/unicorn.stderr.log"
stdout_path "/home/juan/code/curso/log/unicorn.stdout.log"

# nuke workers after 30 seconds instead of 60 seconds (the default)
timeout 30

# combine Ruby 2.0.0dev or REE with "preload_app true" for memory savings
# http://rubyenterpriseedition.com/faq.html#adapt_apps_for_cow

