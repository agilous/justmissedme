set :domain,            "bam.dreamhost.com"
set :user,              "barnetwc"
set :application,       "justmissedme"
set :application_dir,   "/home/#{user}/domains/#{application}.com"

set :repository,        "git@github.com:agilous/justmissedme.git"
set :scm,               :git

set :deploy_to,         application_dir
set :deploy_via,        :remote_cache

ssh_options[:keys] =    %w(~/.ssh/id_rsa)
set :chmod755,          "app config db lib public vendor script script/* public/disp*"
set :use_sudo,          false

role :app,              domain
role :web,              domain
role :db,               domain, :primary => true

namespace :deploy do
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  task :symlink_configs do
    run "ln -nfs #{shared_path}/config/database.yml #{current_path}/config/database.yml"
    run "ln -nfs #{shared_path}/log/production.log #{current_path}/log/production.log"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
end