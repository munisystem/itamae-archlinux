execute 'Install docker-redmine-postgresql' do
  command <<-EOL
  docker run --name=postgresql-redmine -d \
  --env='DB_NAME=redmine_production' \
  --env='DB_USER=redmine' \
  --env='DB_PASS=password' \
  --volume=/srv/docker/redmine/postgresql:/var/lib/postgresql \
  sameersbn/postgresql:9.4-8
  EOL
  user 'root'
  not_if 'test -e /srv/docker/redmine/postgresql'
end

execute 'Install docker-redmine' do
  command <<-EOL
  docker run --name=redmine -d \
  --link=postgresql-redmine:postgresql --publish=10083:80 \
  --env='REDMINE_PORT=10083' \
  --volume=/srv/docker/redmine/redmine:/home/redmine/data \
  sameersbn/redmine:3.1.2-1
  EOL
  user 'root'
  not_if 'test -e /srv/docker/redmine/redmine'
end

template '/usr/lib/systemd/system/docker-redmine.service' do
  source './templates/docker-redmine.service'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :run, 'execute[Reload_daemon]', :immediately
  notifies :restart, 'service[docker-redmine]', :immediately
end

execute 'Reload_daemon' do
  command 'systemctl daemon-reload'
  user 'root'
  action :nothing
end

service 'docker-redmine' do
  action :enable
end
