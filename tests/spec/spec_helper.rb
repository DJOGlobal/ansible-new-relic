require 'serverspec'
require 'docker'

container_id = ENV['CONTAINER_ID']

set :backend, :docker
set :docker_container, container_id

Docker.url = ENV['DOCKER_HOST'].dup
