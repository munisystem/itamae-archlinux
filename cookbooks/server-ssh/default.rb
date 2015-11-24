include_recipe './attributes/default.rb'

service 'sshd' do
  action :nothing
end

template '/etc/ssh/sshd_config' do
  source './templates/sshd_config'
  notifies :restart, 'service[sshd]', :immediately
end

node['user'].each do |user|

  directory "/home/#{user}/.ssh" do
    owner user
    group user
    mode "700"
  end

  template "/home/#{user}/.ssh/authorized_keys" do
    source "./templates/authkeys/#{user}.pub"
    owner user
    group user
    mode "600"
  end

end
