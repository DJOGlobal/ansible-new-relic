require 'serverspec'
require 'docker'

container_id = ENV['CONTAINER_ID']

set :backend, :docker
set :docker_container, container_id
