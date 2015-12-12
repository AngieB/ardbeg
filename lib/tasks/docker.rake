# # Docker deploy process: build new image, stop current app container, remove current app container, run new app container based off of new image, the run bundle commands and start resque
# #
# # Roll back example: BRANCH_NAME=unsafe_production_branch cap production deploy:rollback
# namespace :docker do
#   namespace :container do
#     desc "Build docker image and run docker container"
#     task :setup do
#       on roles(:app) do |host|
#         app_name = fetch(:application)
#         server_name = fetch(:server_name)
#         rails_env = fetch(:rails_env)
#         resque_child_report_queues = fetch(:resque_child_report_queues)
#         run_env_vars = "-e RAILS_ENV=#{rails_env} -e RAILS_APP_NAME=#{app_name} -e VIRTUAL_HOST=#{server_name}"
#         volume = "-v /var/www/#{app_name}/shared:/var/www/#{app_name}/shared"
#         puts "================Starting Docker setup===================="
#         within :"#{current_path}" do
#           execute :docker, "build --rm=true -t #{app_name}-image ."
#           execute :docker, "stop #{app_name}; echo 0"
#           execute :docker, "rm -fv #{app_name}; echo 0"
#           execute :docker, "run -ti -d --restart=always --name #{app_name} #{run_env_vars} #{volume} #{app_name}-image"
#         end
#       end
#       after "docker:container:setup", "docker:rails_app:prepare"
#       after "docker:container:setup", "docker:nginx:reload"
#     end
#     desc "Restart docker container and all services therein"
#     task :restart do
#       on roles(:app) do |host|
#         app_name = fetch(:application)
#         puts "================Restarting #{app_name} Container===================="
#         execute :docker, "restart #{app_name}"
#       end
#     end
#   end
#   namespace :rails_app do
#     desc "Prepare the rails app post deployment"
#     task :prepare do
#       on roles(:app) do |host|
#         app_name = fetch(:application)
#         execute :docker, "exec -i -u 9999 #{app_name} bundle install --path shared/bundle --without development:test:cucumber:guard:guard_linux:guard_osx --deployment && bundle"
#         execute :docker, "exec -i -u 9999 #{app_name} bundle exec rake assets:precompile"
#         execute :docker, "exec -i -u 9999 #{app_name} bundle exec rake db:migrate"
#       end
#     end
#   end
#   namespace :nginx do
#     desc "Reload nginx with the rails app's config file"
#     task :reload do
#       on roles(:app) do |host|
#         app_name = fetch(:application)
#         rails_env = fetch(:rails_env)
#         execute "sleep 3"
#         execute :docker, "exec -i #{app_name} cp #{shared_path}/config/nginx/#{app_name}_#{rails_env}.conf /etc/nginx/sites-enabled/#{app_name}.conf"
#         execute :docker, "exec -i #{app_name} nginx -s reload"
#       end
#     end
#   end
#
# SSHKit.configure do |config|
#   config.command_map["docker"] = "/usr/bin/env docker"
#   # config.output_verbosity = Logger::DEBUG
# end
