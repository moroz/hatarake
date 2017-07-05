set :stage, :staging
RAILS_ENV=staging

server "217.182.75.140", user: "deployer", roles: %w{app db web}
