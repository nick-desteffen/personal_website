set :stage, :production
set :rails_env, :production

server 'risk2210.net', user: 'nickd', roles: %w{web app db}
