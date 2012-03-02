# Vlad rake task to set a deployment target.
#
# We call our task "www" because it's short and easy to type;
# you can your task whatever you want if you like longer names.
#
# The "www" task sets up a couple of vlad variables,
# then the "deploy" task runs (see config/deploy.rb).
#
# We run the deploy like this:
#
#   rake www deploy 

task 'www' do
  set :domain, 'www.example.com'
  set :deploy_to, '/websites/www.example.com'
end


# We can create as many deployment targets as we like.
# For example, a quality assurance target with its own
# website, git branch, and development rails env.
#
# We run the deploy like this:
#
#   rake qa deploy 

task 'qa' do
  set :domain, 'qa.example.com'
  set :deploy_to, '/websites/qa.example.com'
  set :revision, 'origin/develop'
  set :rails_env, 'development'
end
