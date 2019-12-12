DOCKERFILES := $(wildcard */Dockerfile)
IMAGES := $(patsubst %/Dockerfile, lerenn/%, $(DOCKERFILES))

lerenn/%:
	sudo docker build -t $@ $(shell basename $@)

build: $(IMAGES)
