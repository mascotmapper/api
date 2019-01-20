APP = mascotmapper

help:
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

test: lint
	python -m unittest --verbose --failfast

build: test
	docker build -t $(APP) .

run: build
	docker run --rm -d -p 5000:5000 --name $(APP) $(APP)

interactive: build
	docker run --rm -it -p 5000:5000 --name $(APP) $(APP)

clean:
	docker container stop $(APP) || true
	rm -rvf ./__pycache__ ./tests/__pycache__
	rm -vf .*~ *.pyc


.PHONY: lint test build run clean
