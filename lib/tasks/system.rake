namespace :db do

  desc "Retrieves the database from production and updates locally"
  task :fetch do
    sh 'bundle exec heroku db:pull --confirm smooth-warrior-334'
  end

end

desc "Deploys to Heroku"
task :deploy do
  sh 'git push heroku master'
end