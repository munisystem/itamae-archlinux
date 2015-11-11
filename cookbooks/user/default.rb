user "Add general user" do
  name "#{node['user']}"
  gid "wheel"
end
