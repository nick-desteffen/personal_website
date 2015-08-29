set :stage, :production
set :rails_env, :production

server 'nickdesteffen.com', user: 'nickd', roles: %w{web app db}
