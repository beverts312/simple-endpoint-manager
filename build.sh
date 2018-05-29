#!/bin/bash

VERSION=$1
IMAGE=beverts312/simple-endpoint-manager
docker build -t $IMAGE .
docker push $IMAGE

if [[ -n "$VERSION" ]] ; then
    docker tag $IMAGE $IMAGE:$VERSION
    docker push $IMAGE:$VERSION
fi