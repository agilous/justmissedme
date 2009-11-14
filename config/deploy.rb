set :domain,            "bam.dreamhost.com"
set :user,              "barnetwc"
set :application,       "justmissedme"
set :application_dir,   "/home/#{user}/domains/#{application}.com"

set :repository,        "git@github.com:agilous/justmissedme.git"
set :scm,               :git

set :deploy_to,         :application_dir
set :deploy_via,        :remote_cache

ssh_options[:keys] =    %w(~/.ssh/id_rsa)
set :chmod755,          "app config db lib public vendor script script/* public/disp*"
set :use_sudo,          false

role :app,              "bam.dreamhost.com"
role :web,              "bam.dreamhost.com"
role :db,               "db.justmissedme.com", :primary => true

namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
end