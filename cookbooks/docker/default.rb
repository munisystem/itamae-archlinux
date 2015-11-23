package 'docker' do
  notifies :enable, 'service[docker]', :immediately
end

service 'docker' do
  action :nothing
end

template '/etc/systemd/network/ipforward.network' do
  source './templates/ipforward.network'
  notifies :restart, 'service[systemd-networkd]', :immediately
  notifies :restart, 'service[docker]', :immediately
end

service 'systemd-networkd' do
  action :nothing
end
