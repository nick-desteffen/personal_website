namespace :db do

  desc "Retrieves the database from production and updates locally"
  task fetch: [:environment] do
    user = ActiveRecord::Base.connection_config[:username]
    database = ActiveRecord::Base.connection_config[:database]
    hostname = ActiveRecord::Base.connection_config[:hostname]
    sh "heroku pgbackups:capture"
    sh "curl -o latest.dump `heroku pgbackups:url`"
    #sh "pg_restore --verbose --clean --no-acl --no-owner -h #{hostname} -U #{user} -d #{database} latest.dump"
    sh "pg_restore --verbose --clean --no-acl --no-owner -h localhost -U nickd -d personal_website_development latest.dump"
  end

end

desc "Deploys to Heroku"
task :deploy do
  sh 'git push heroku master'
  sh 'heroku run rake db:migrate'
  sh 'heroku restart'
end

desc "Sets application up for deployment in Heroku"
task :deploy_setup do
  sh 'heroku git:remote -a smooth-warrior-334'
end

desc "Restarts production server"
task :restart do
  sh 'heroku restart'
end

desc "Show config settings on Heroku"
task :show_config do
  sh 'heroku config'
end
