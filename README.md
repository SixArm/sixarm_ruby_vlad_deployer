# Ruby » Vlad Deployer config and notes

* Doc: <http://sixarm.com/sixarm_ruby_/doc>
* Gem: <http://rubygems.org/gems/sixarm_ruby_>
* Repo: <http://github.com/sixarm/sixarm_ruby_>
<!--HEADER-SHUT-->


## Introduction

Vlad is an excellent deployment tool for Ruby On Rails projects.

Read about deployment with Vlad:

    http://dennisreimann.de/blog/deployment-with-vlad/

    http://rubyhitsquad.com/Vlad_the_Deployer.html

What we like about Vlad:

  * Pragmatic application deployment automation.
  * Like Capistrano yet with 1/10th the complexity.
  * Uses the right tool for the job: ssh, rsync, rake.
  * Exec remote commands on one or more servers.
  * Syncs files to one or more servers.
  * Can combine local and remote tasks.
  * Test driven design. Runs incredibly fast.

This repository has our annotated Vlad deploy file. It is open source and you can customize it however you like.

For docs go to <http://sixarm.com/sixarm_ruby_/doc>

Want to help? We're happy to get pull requests.


## Vlad gems

We use these gems:

   gem install vlad
   gem install vlad-git
   gem install vlad-extras

## Vlad tasks

Vlad most important tasks:

    rake vlad:setup               # Setup your servers. Required first time. Safe to re-run.
    rake vlad:update              # Updates your application server to the latest revision.
    rake vlad:start               # Start (or restart) the web and app servers


Vlad additional tasks:

    rake vlad:debug              # Show the vlad setup.
    rake vlad:invoke             # Invoke a single command on every remote server.
    rake vlad:migrate            # Run the migrate rake task for the the app.
    rake vlad:rollback           # Rolls back to a previous version and restarts.
    rake vlad:setup_app          # Prepares application servers for deployment.
    rake vlad:start_app          # Restart Passenger

Vlad tasks defined by the vlad-extras gem:

    rake vlad:assets:clean       # Clean assets
    rake vlad:assets:precompile  # Precompile assets
    rake vlad:bundle:install     # Install the current Bundler environment.
    rake vlad:cleanup            # Clean up old releases.
    rake vlad:copy:files         # Copy files to remote
    rake vlad:copy:shared        # Copy files into remote shared directory
    rake vlad:db:clone           # Clone the remote database into the local database
    rake vlad:db:create          # Create monit
    rake vlad:db:drop            # Drop the database
    rake vlad:db:rollback        # Rollback the database
    rake vlad:db:seed            # Seed the database
    rake vlad:db:setup           # Setup the database
    rake vlad:debug              # Show the vlad setup.
    rake vlad:deploy             # Full deployment cycle: update, symlink, bundle:install, migrate, start_app, cleanup
    rake vlad:invoke             # Invoke a single command on every remote server.
    rake vlad:migrate            # Run the migrate rake task for the the app.
    rake vlad:rollback           # Rolls back to a previous version and restarts.
    rake vlad:setup              # Setup your servers. Required first time. Safe to re-run.
    rake vlad:start_web          # Start (or restart) the web servers
    rake vlad:stop               # Stop the web and app servers
    rake vlad:stop_web           # Stop the web servers
    rake vlad:symlink            # Symlink files (typically from /shared to /current)
