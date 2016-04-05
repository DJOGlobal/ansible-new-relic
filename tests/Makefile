all: one two

BASE_DISTRO = "ubuntu"
BASE_VERSION = "14.04"
BASE_INIT = "/sbin/init"
TEMPDIR := $(shell mktemp)
ROLE_NAME = $(shell basename $${PWD%/*})
CONTAINER_NAME = "$(BASE_DISTRO)-$(BASE_VERSION)-$(ROLE_NAME)"

.PHONY: build remove run test_syntax

name:
	echo "$(ROLE_NAME)"

build:
	docker pull $(BASE_DISTRO):$(BASE_VERSION)
	docker build --rm=true --file=Dockerfile.$(BASE_DISTRO)-$(BASE_VERSION) --tag=$(BASE_DISTRO)-$(BASE_VERSION):ansible .

clean:
	docker rm -f $(CONTAINER_NAME)

run: clean
	docker run --detach --name "$(CONTAINER_NAME)" --volume="$${PWD%/*}":/etc/ansible/roles/role_under_test:ro $(BASE_DISTRO)-$(BASE_VERSION):ansible "$(BASE_INIT)"

test_syntax:
	docker exec --tty $(CONTAINER_NAME) env TERM=xterm ansible-playbook /etc/ansible/roles/role_under_test/tests/test.yml --syntax-check

test_execute:
	docker exec --tty $(CONTAINER_NAME) env TERM=xterm ansible-playbook /etc/ansible/roles/role_under_test/tests/test.yml

test_idempotent: run test_execute
	docker exec $(CONTAINER_NAME) ansible-playbook /etc/ansible/roles/role_under_test/tests/test.yml \
    | grep -q 'changed=0.*failed=0' \
    && (echo 'Idempotence test: pass' && exit 0) \
    || (echo 'Idempotence test: fail' && exit 1)

test: run test_syntax test_idempotent
