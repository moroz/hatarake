# frozen_string_literal: true

set :stage, :staging
server '217.182.75.140', user: 'deployer', roles: %w[app db web]
set :deploy_to, '/home/deployer/injobs/staging'
