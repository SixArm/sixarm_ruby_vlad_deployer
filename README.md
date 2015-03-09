# Ruby » Vlad Deployer config and notes

* Doc: <http://sixarm.com/sixarm_ruby_/doc>
* Gem: <http://rubygems.org/gems/sixarm_ruby_>
* Repo: <http://github.com/sixarm/sixarm_ruby_>
* Email: Joel Parker Henderson, <joel@sixarm.com>


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


## Changes

* 2012-03-14 1.0.0 Update docs, tests
* 2012-02-29 1.0.0 Add full annotations and publish to github
* 2011-11-03 0.8.0 Fund Vlad team to create ssh gem
* 2009-12-20 0.6.0 Fund Vlad team to create rake-remote_task
* 2009-06-12 0.4.0 Add host targets for www, qa, ua, ci
* 2009-03-10 0.2.0 Fund Vlad team to create high security trust policy
* 2009-03-06 0.1.0 Create first deploy

## License

You may choose any of these open source licenses:

  * Apache License
  * BSD License
  * CreativeCommons License, Non-commercial Share Alike
  * GNU General Public License Version 2 (GPL 2)
  * GNU Lesser General Public License (LGPL)
  * MIT License
  * Perl Artistic License
  * Ruby License

The software is provided "as is", without warranty of any kind, 
express or implied, including but not limited to the warranties of 
merchantability, fitness for a particular purpose and noninfringement. 

In no event shall the authors or copyright holders be liable for any 
claim, damages or other liability, whether in an action of contract, 
tort or otherwise, arising from, out of or in connection with the 
software or the use or other dealings in the software.

This license is for the included software that is created by SixArm;
some of the included software may have its own licenses, copyrights, 
authors, etc. and these do take precedence over the SixArm license.

Copyright (c) 2005-2015 Joel Parker Henderson
