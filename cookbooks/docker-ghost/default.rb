execute 'Install docker-ghost' do
  command <<-EOL
  docker run --name=ghost -d \
  --publish=2368:2368 \
  --volume=/srv/docker/ghost:/var/lib/ghost \
  ghost
  EOL
  user 'root'
  not_if 'docker ps -a | grep ghost'
end

template '/usr/lib/systemd/system/docker-ghost.service' do
  source './templates/docker-ghost.service'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :run, 'execute[Reload_daemon]', :immediately
  notifies :restart, 'service[docker-ghost]', :immediately
end

execute 'Reload_daemon' do
  command 'systemctl daemon-reload'
  user 'root'
  action :nothing
end

service 'docker-ghost' do
  action :enable
end
