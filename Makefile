APP         = target-app
SCOPE       = user99
TAG         = $(shell echo "$$(date +%F)-$$(git rev-parse --short HEAD)")
ENVIRONMENT = staging
help:
	@echo $(TAG) $(USER)
	@echo "Targets are lint, test, build, and run"
	@echo "    lint        - flake8 and pylint"
	@echo "    test        - unittests"
	@echo "    build       - build docker container"
	@echo "    run         - run containter as a daemon on host port 5000"
	@echo "    interactive - run container interactively on host port 5000"
	@echo "    clean       - stop the running container and remove python caches"

lint:
	flake8 --ignore=E501,E231
	pylint --errors-only --disable=C0301 --disable=C0326 *.py tests/*.py

unittest: lint
	python -m unittest --verbose --failfast

build: unittest
	docker build -t $(SCOPE)/$(APP):$(TAG) .

run: build
	docker run --rm -d -p 5000:5000 --name $(APP) $(SCOPE)/$(APP):$(TAG)

interactive: build
	docker run --rm -it -p 5000:5000 --name $(APP) $(SCOPE)/$(APP):$(TAG)

upload: unittest
	./upload-new-version.sh

test:
	curl

deploy: upload
	./deploy-new-version.sh $(ENVIRONMENT)

clean:
	docker container stop $(APP) || true
	rm -rvf ./__pycache__ ./tests/__pycache__
	rm -vf .*~ *.pyc

.PHONY: lint test build run clean register
