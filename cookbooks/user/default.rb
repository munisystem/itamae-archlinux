include_recipe './attributes/default.rb'

package 'sudo'

template '/etc/sudoers' do
  source './templates/sudoers'
  user 'root'
  mode '0440'
end

node['user'].each do |user|

  user "Add general user @#{user}" do
    username user
    gid "wheel"
  end

end
