help:
	@echo "Targets are lint, test, build, and run"
	@echo "    lint  - flake8 and pylint"
	@echo "    test  - unittests"
	@echo "    build - build docker container"
	@echo "    run   - run containter on host port 5000"

lint:
	flake8 --ignore=E501,E231
	pylint --errors-only --disable=C0301 --disable=C0326 *.py tests/*.py

test: lint
	python -m unittest --verbose --failfast

build: test
	docker build -t mascotmapper .

run: build
	docker run --rm -it -p 5000:5000 mascotmapper

clean:
	rm -rvf ./__pycache__ ./tests/__pycache__
	rm -vf .*~ *.pyc


.PHONY: lint test build run clean
