package 'docker' do
  notifies :start, 'service[docker]', :immediately
end

service 'docker' do
  action :enable
end
