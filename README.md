# Sysmoon
[![Build Status](https://travis-ci.org/mrexox/sysmoon.svg?branch=master)](https://travis-ci.org/mrexox/sysmoon)

A simple ruby-written service for automation files and packages changes between similar hosts.

### Testing

#### Starting containers with sysmoon service

```
docker-compose build
docker-compose up --detach
```

This will build the docker image for CentOS 7.4 distribution and start 2 of the containers.

When attached, you'll see tmux session. `bin/start` will start sysmoon service.

#### Stopping containers

```
docker-compose rm --force
```
