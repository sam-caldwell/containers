containers
==========

## Description

Create a set of minimal base containers to reduce supply-chain attack potential.

## Container Images

| Image                                     | Language      | OpSys           |
|-------------------------------------------|---------------|-----------------|
| local/alpine:3.20.1                       | N/A           | Alpine 3.20.1   |
| local/alpine:latest                       | N/A           | Alpine (latest) |
| local/ubuntu:24.04                        | N/A           | Ubuntu 24.04    |
| local/ubuntu:22.04                        | N/A           | Ubuntu 22.04    |
| local/ubuntu:latest                       | N/A           | Ubuntu (latest) |
| local/python-alpine:builder:3.12.3        | python 3.12.3 | Alpine (latest) |
| local/python-ubuntu-24.04:builder:3.9     | python 3.9    | Ubuntu 24.04    |
| local/python-ubuntu-24.04:builder:3.12.3  | python 3.12.3 | Ubuntu 24.04    |
| local/python-ubuntu:builder:3.12.3        | python 3.12.3 | Ubuntu (latest) |

> Note that all base images in this project create a non-root service user (user: service, group: service)
> and all base images assume the service user $HOME is /opt/ with WORKDIR being /opt

## Usage

To build all images and run all tests:

```shell
make all 
```

To build all images:

```shell
make build
```

To run tests:

```shell
make test
```