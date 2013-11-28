namespace :db do

  desc "Retrieves the database from production and updates locally"
  task fetch: [:environment] do
    Bundler.with_clean_env do
      user     = ActiveRecord::Base.connection_config[:username]
      database = ActiveRecord::Base.connection_config[:database]
      host     = ActiveRecord::Base.connection_config[:host]
      Rake::Task["db:drop"].invoke
      Rake::Task["db:create"].invoke
      sh "heroku pgbackups:capture"
      sh "curl -o latest.dump `heroku pgbackups:url`"
      sh "pg_restore --verbose --clean --no-acl --no-owner -h #{host} -U #{user} -d #{database} latest.dump"
    end
  end

end

desc "Deploys to Heroku"
task :deploy do
  Bundler.with_clean_env do
    sh 'git push heroku master'
    sh 'heroku run rake db:migrate'
    sh 'heroku restart'
  end
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
