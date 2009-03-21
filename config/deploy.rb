set :application, "albumPhoto"
set :repository,  "set your repository location here"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion

role :app, "http://rails.morphexchange.com/"
role :web, "http://rails.morphexchange.com/"
role :db,  "10.255.131.229", :primary => true