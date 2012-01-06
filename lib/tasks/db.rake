namespace :db do

  desc "Retrieves the database from production and updates locally"
  task :retrieve => :environment do
    sh 'bundle exec heroku db:pull --confirm smooth-warrior-334'
  end

end
