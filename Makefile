.PHONY: build test

build:
	docker build -t genepi/cloudgene .

test: build
	bash tests/test_runner.sh

default: build
