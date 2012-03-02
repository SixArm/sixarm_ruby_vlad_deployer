# How to load Vlad in our Rakefile
#
# We load our setup using the Vlad.load command like this:
#
#   * application server: passenger
#   * configuration file: config/deploy.rb
#   * core
#   * source control management: git
#   * type of application: rails
#   * web server: apache
#
# You can customize any of these settings as you like.
# Feel free to skip Vlad.load entirely if it doesn't fit for you. 
# All it does is a fancy-pants require. Require whatever files you
# want straight from your Rakefile. YAY for simple and clean!

if Rails.env.development?
  begin
    require 'vlad'
    require 'vlad-extras'
    Vlad.load \
      :app    => :passenger,
      :config => 'config/deploy.rb',
      :core   => :core,
      :scm    => :git,
      :type   => :rails,
      :web    => :apache
  rescue LoadError => e
  $stderr << "Error loading vlad: #{e}"
end
