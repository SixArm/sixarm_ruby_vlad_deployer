# Vlad the Deployer: configuration and rake tasks for fast, easy, 
# flexible deployments using Ruby and our system's standard SSH.
#
# We define many of the typical Vlad settings in this file,
# and to read about the settings see the Vlad docs and source.


# Bundler provides a Vlad task "vlad:bundle:install"
# that we run as part of our regular deploy task.
# 
# To install bundler:
#
#    gem install bundler
#
# For details see http://gembundler.com/deploying.html

require "bundler/vlad"


# Vlad plugin with extra tasks for shared symlinks, 
# the asset pipeline, monit, node, and much more.
#
# The author builds tasks in a good modular way that is 
# easy to read and learn if you want to write your own.
#
# To install:
#
#    gem install vlad-extras

require "vlad-extras"


# The :application variable is a  vlad built-in that
# identifies for our application; it can be any string.
#
# We set it here as our default, and our remote servers
# can override it in ./lib/tasks/vlad-targets.rake

set :application, "example"


# The :repostory variable is a vlad built-in that tells vlad
# what source control management URL to pull from during deploy.
#
# We prefer to use git source control and keep it on GitHub,
# so we set the repository to our GitHub repository clone URL. 

set :repository, "git@github.com:SixArm/example.git"


# The :revision variable is a vlad built-in that tells vlad
# which repository version to deploy, e.g. which git branch.
#
# We use the default git branch which is "origin/master" and you
# can override it in ./lib/tasks/vlad-targets.rake

set :revision, "origin/master"


# The :domain variable is a vlad built-in that sets our default
# deployment domain; in practice we always override it with a
# host-specific task via ./lib/tasks/vlad-targets.rake

set :domain, "example.sixarm.com"


# The :user variable is a vlad built-in that sets the
# deployment username for this apps and its vlad tasks.
#
# We set it here as our default, and our remote servers
# can freely override this in ./lib/tasks/remote.rake
#
# We call our user "deployer" to distiguish it from a person;
# we create this user account on each of our target servers,
# and we use GitHub so we also create a GitHub deploy key.

set :user, "deployer"


# The :ssh_flags variable is a vlad built-in that enables
# ssh modifications such as a custom user, custom port, etc.
#
# To set a custom username, use "-1" and the username.
# To set a custom port, use "-p" and the number as a string.
#
# For example to deploy as the user "joe" on port 1234:
#
#     set :ssh_flags, ["-l", "joe", "-p", "1234"]

set :ssh_flags, ["-l", "deployer"]


# The :sudo_cmd and :sudo_flags are vlad built-ins;
# we use these to create a sudo command for our tasks.
#
# When we want to use a sudo command in our vlad tasks, 
# we use the variable within a string like this:
#
#    run "#{sudo} foo"

set :sudo_cmd, "sudo"
set :sudo_flags, ""
set :sudo, [sudo_cmd, sudo_flags].flatten.compact.join(" ")


# The :web_command variable is a vlad built-in that is a path to 
# our system script that can start, stop, and restart our webserver.
#
# The vlad default setting is "apache2ctl" for Apache control.
# Other common scripts on systems are "httpd" and "apache2",
# or "stop apache2" on systems that have that service manager.
#
# This setting is used by the vlad built-in webserver remote tasks.

#set :web_command, "apache2ctl"
#set :web_command, "/etc/init.d/apache2"
#set :web_command, "/etc/init.d/httpd"
#set :web_command, "stop apache2"

set :web_command, "/etc/init.d/httpd"


# The :rails_env is our own setting we can use in our scripts;
# this enables us to use production, deployment, and test envs.

set :rails_env, "production"

# The :rails_env is our own setting we can use in our scripts;
# this enables us to use rake within our vendored bundle.

set :rake_cmd, "bundle exec rake"


# The vlad-extras gem defines a task vlad:symlink that looks for
# a setting :symlinks, which tells the task which symlinks to create
# between a deployment's shared directory and the current directory.
#
# The :symlinks setting can be an array of paths or a hash of paths.
#
# The :symlinks as an array will link each path from shared to current,
# using the same path within both directories like this example:
#
#    set :symlinks, ["foo", "goo"]
#    =>
#    ln -s shared/foo current/foo
#    ln -s shared/goo current/goo
#
# The :symlinks as a hash will link each pair's key path to value path,
# so we can use a different path for shared and current like this example:
#
#    set :symlinks, {"foo" => "bar", "goo" => "car"}
#    =>
#    ln -s shared/foo current/bar
#    ln -s shared/goo current/car

set :symlinks, ["config/database.yml"]


# Vlad lets us define our own tasks too; typically these go in the vlad namespace.
# We can put these tasks here if we want things quick-and-dirty, or we can do it
# more professionally by setting up individual tasks like the vlad-extras authors.

namespace :vlad do

  # We have a simple example to ssh to the remote server, 
  # change to the current deployment directory, then list files.
  #
  # To run it, provide a vlad target (we use "www") then this task:
  #
  #    rake www vlad:ls
 
  desc 'List the files in the current deployment directory'
  remote_task :ls => :app do
    run "cd #{current_release} && ls -la"
  end

end


# Vlad deliberately does not provide a deploy task because the Vlad authors
# learned that there isn't a one-size-fits all task that works for everyone.
#
# Instead, Vlad has us define our own deploy task that calls other tasks.
# The vlad-extras gem does provide a vlad:deploy task, if you prefer it.
#
# We define our deploy task at the top level (rather than within vlad's namespace)
# because it's shorter to type and it's consistent with our apps that use cap.
#
# To use this task, you'll want a deployment target.
# We define our in lib/tasks/vlad-targets.rake
#
# For example we have a task called "www" that sets up our website target,
# and we deploy like this:
#
#    rake www deploy

desc "Deploy"
task :deploy => [
  "vlad:update",             # fetches fresh files from the repository revision.
  "vlad:bundle:install",     # remote rake bundle install; see bundler/vlad
  "vlad:symlink",            # symlink shared files to current files; see vlad-extras.
  "vlad:assets:precompile",  # remote rake assets:precompile for pipeline; see vlad-extras.
  "vlad:start",              # start (or restart) the webserver; vlad built-in.
  "vlad:cleanup"             # do any cleanup, like deleting old releases; vlad built-in.
]
