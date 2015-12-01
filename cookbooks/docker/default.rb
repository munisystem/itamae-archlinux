package 'docker' do
  notifies :enable, 'service[docker]', :immediately
end

service 'docker' do
  action :nothing
end
