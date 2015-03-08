
set :stage, :production

set :deploy_to, '~/apps/app-name'

set :branch, 'master'

set :rails_env, 'production'

# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary
# server in each group is considered to be the first
# unless any hosts have the primary property set.
role :app, %w{jbourne@45.56.102.221}
role :web, %w{jbourne@45.56.102.221}
role :db,  %w{jbourne@45.56.102.221}
