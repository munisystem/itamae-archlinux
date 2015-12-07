include_recipe './attributes/default.rb'

user 'www-data'

package 'nginx'

service 'nginx' do
  action :enable
end

directory '/etc/nginx/conf.d' do
  owner 'root'
  group 'root'
  mode '0755'
end

template '/etc/nginx/conf.d/ghost.conf' do
  source './templates/ghost.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[nginx]'
end

template '/etc/nginx/nginx.conf' do
  source './templates/nginx.conf'
  owner 'root'
  group 'root'
  mode '0600'
  notifies :restart, 'service[nginx]'
end
