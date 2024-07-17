TAG_PREFIX:=local
# Default target
.DEFAULT_GOAL := all

.PHONY: all
all: build test
	@echo "ok"

clean:
	@echo "cleaning..."
	@for i in $$(docker ps -a | grep local/ | awk '{print $1}'); do \
        echo "remove container $$i"; \
  		docker kill $$i &> /dev/null || true; \
  		docker rm -f $$i &> /dev/null  || true; \
  	done
	@for i in $$(docker images | grep local/ | awk '{print $$3}'); do \
        echo "remove container image $$i"; \
  		docker rmi -f $$i &> /dev/null  || true; \
	done
	@echo "done"

.PHONY: build
build:
	@echo "build base images" && \
	make build/alpine:latest && \
	make build/alpine:3.20.1 && \
	make build/ubuntu:latest && \
	make build/ubuntu:24.04 && \
	make build/ubuntu:22.04 && \
	echo "build language-specific images" && \
	make build/alpine:latest/python:latest && \
	make build/ubuntu:latest/python:latest && \
	make build/ubuntu:24.04/python:latest && \
	#make build/alpine:latest/go:latest && \
	#make build/alpine:3.20.1/go:3.12.3 && \
	make build/ubuntu:24.04/go:latest && \
	make build/ubuntu:24.04/go:1.22.4 && \
	echo "ok"


# build/<opsys>:<opsys_ver>
# build/<opsys>:<opsys_ver>:<go|python|cpp>:<ver>
build/%:
	@echo "Building image for $*"; \
	RAW=$*; \
	OPSYS=$$(echo $$RAW | awk -F ':' '{print $$1}'); \
	OPSYS_VER=$$(echo $$RAW | awk -F '/' '{print $$1}' | awk -F ':' '{print $$2}'); \
	LANG=$$(echo $$RAW | awk -F '/' '{print $$2}' | awk -F ':' '{print $$1}'); \
	LANG_VER=$$(echo $$RAW | awk -F '/' '{print $$2}' | awk -F ':' '{print $$2}'); \
	echo "OPSYS: '$$OPSYS'"; \
	echo "OPSYS_VER: '$$OPSYS_VER'"; \
	echo "LANG: '$$LANG'"; \
	echo "LANG_VER: '$$LANG_VER'"; \
	if [ "$$LANG" = "" ]; then \
	  	echo 'Building base opsys image'; \
		docker build --tag $(TAG_PREFIX)/$$OPSYS:$$OPSYS_VER \
					 --build-arg OPSYS=$$OPSYS \
					 --build-arg OPSYS_VER=$$OPSYS_VER \
					 --compress \
					 -f docker/base-$$OPSYS.docker .; \
	else \
	  	echo 'Building language-specific image'; \
		docker build --tag $(TAG_PREFIX)/$$LANG-$$OPSYS-$$OPSYS_VER:builder-$$LANG_VER \
					 --build-arg OPSYS=$$OPSYS \
					 --build-arg OPSYS_VER=$$OPSYS_VER \
					 --build-arg LANG=$$LANG \
					 --build-arg LANG_VER=$$LANG_VER \
					 --target builder \
					 --compress \
					 -f docker/$$LANG-$$OPSYS.docker .; \
		docker build --tag $(TAG_PREFIX)/$$OPSYS-$$OPSYS_VER:$$LANG-$$LANG_VER \
					 --build-arg OPSYS=$$OPSYS \
					 --build-arg OPSYS_VER=$$OPSYS_VER \
					 --build-arg LANG=$$LANG \
					 --build-arg LANG_VER=$$LANG_VER \
					 --target runtime \
					 --compress \
					 -f docker/$$LANG-$$OPSYS.docker .; \
	fi

.PHONY: test
test:
	@echo "not implemented"
	@exit 1
