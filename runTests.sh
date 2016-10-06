#!/bin/bash
docker run -ti -e CI_CAPTURE=off -v /var/run/docker.sock:/var/run/docker.sock -v `pwd`:/usr/src/app/spec enieuw/serverspec

