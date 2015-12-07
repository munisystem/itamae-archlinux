# Include attribute
include_recipe './attributes/default.rb'

include_recipe '../../cookbooks/nginx-ghost/default.rb'
include_recipe '../../cookbooks/docker-ghost/default.rb'
