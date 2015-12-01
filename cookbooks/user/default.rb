include_recipe './attributes/default.rb'

package 'sudo'

template '/etc/sudoers' do
  source './templates/sudoers'
  owner 'root'
  group 'root'
  mode '0440'
end

node['user'].each do |user|

  user "Add general user @#{user}" do
    username user
    not_if "test -e /home/#{user}"
  end

  user "Add wheel @#{user}" do
    username user
    gid "wheel"
    not_if "test -e /home/#{user}"
  end

end
