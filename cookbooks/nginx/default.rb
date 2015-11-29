include_recipe './attributes/default.rb'

# Generate user 'nginx'
include_recipe '../user/default.rb'

package 'nginx'

service 'nginx' do
  action :enable
end

directory '/etc/nginx/conf.d' do
  source './files/waterlily'
  notifies :restart, 'service[nginx]'
end

template '/etc/nginx/nginx.conf' do
  source './templates/nginx.conf'
  notifies :restart, 'service[nginx]'
end
