require 'serverspec'
require 'docker'

container_id = ENV['CONTAINER_ID']

set :backend, if ENV['CIRCLECI']
  :docker_lxc
else
  :docker
end

set :docker_container, container_id
