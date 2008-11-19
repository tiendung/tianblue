set :application, "tianblue.com"
set :repository,  "git@github.com:andycroll/tianblue.git"

set :user, "tianblue"
set :port, 30000

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/home/tianblue/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
default_run_options[:pty] = true
set :scm, :git
set :scm_username, 'andycroll'
set :scm_passphrase, "tianblue" # This is your custom users password
set :branch, "master"
set :deploy_via, :remote_cache

role :app, application
role :web, application
role :db,  application, :primary => true

namespace :deploy do
  task :start, :roles => :app do
  end

  task :stop, :roles => :app do
  end

  task :restart, :roles => :app do
    run "touch #{release_path}/tmp/restart.txt"
  end

  task :after_update_code, :roles => :app do
    run "rm -rf #{release_path}/public/.htaccess"
  end

  desc "copy the secret launch codes from their only location on the production server"
  task :copy_database_configuration, :roles => :db do 
    production_db_config = "#{shared_path}/system/production.database.yml" 
    run "cp #{production_db_config} #{release_path}/config/database.yml" 
  end 
  after "deploy:update_code", "deploy:copy_database_configuration" 

  desc "Link shared files between deployments e.g. attachment_fu images # FROM Deploying Rails Apps 5.7"
  task :link_stuff do 
    run "ln -nfs #{shared_path}/product_images #{release_path}/public/product_images"
    run "ln -nfs #{shared_path}/category_images #{release_path}/public/category_images"
    run "ln -nfs #{shared_path}/page_images #{release_path}/public/page_images"
    run "ln -nfs #{shared_path}/article_images #{release_path}/public/article_images"
  end
  after 'deploy:update_code', 'deploy:link_stuff' 

end

# Useful tail viewer for production.log from Deploying Rails Apps 5.6
task :tail_log, :roles => :app do
  stream "tail -f #{shared_path}/log/production.log -n50" 
end
