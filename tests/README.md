# Role Tests

This role includes integration tests that run in Docker containers.

## Requirements

You will need a working Docker client installed and configured to execute tests. See [Docker Basics](DockerBasics.md) for details on getting setup.

Integration tests are Serverspec based which has Ruby gem requirements.

```
> cd tests
> bundle install --without=ci
```

## Executing tests

Use the included `Makefile` to execute tests.

```
> cd tests
> make
build                          Build Docker image from repo Dockerfile
clean                          Remove Docker image and container id file
help                           Halp!
run                            Run fresh Docker container
shell                          Drop into container shell
test-execute                   Execute Ansible playbook on running container
test-idempotent                Execute Ansible playbook with check for changes
test-serverspec                Excute serverspec specs on running container
test-syntax                    Ansible syntax check on running container
test                           Execute all tests
```

## CI

The repo contains a [CircleCI configuration](../circle.yml) for automated testing.
