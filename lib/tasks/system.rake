namespace :db do

  desc "Retrieves the database from production and updates locally"
  task :fetch do
    sh 'bundle exec heroku db:pull --confirm smooth-warrior-334'
  end

end

desc "Deploys to Heroku"
task :deploy do
  sh 'git push heroku master'
  sh 'bundle exec heroku run rake db:migrate'
  sh 'bundle exec heroku restart'
end

desc "Sets application up for deployment in Heroku"
task :deploy_setup do
  sh 'bundle exec heroku git:remote -a smooth-warrior-334'
end

desc "Restarts production server"
task :restart do
  sh 'bundle exec heroku restart'
end