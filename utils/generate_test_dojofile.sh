#!/bin/bash

cd ..
echo DOJO_DOCKER_IMAGE=\"catosplace/docker-docker-image-dojo:latest\" >> Dojofile.to_be_tested
echo DOJO_WORK_OUTER=\""$PWD\"" >> Dojofile.to_be_tested
cd ./utils || exit