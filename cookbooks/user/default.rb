include_recipe './attributes/default.rb'

node['user'].each do |user|

  user "Add general user @#{user}" do
    username user
    gid "wheel"
  end

end
