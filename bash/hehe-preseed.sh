#!/bin/bash

DEIS_RELEASE=v1.12.2
BACKEND_HOST=127.0.0.1:5000;
DOCKER_PULL="dao pull"

COMPONENTS=(store-monitor store-metadata store-gateway store-daemon router registry publisher logspout logger database controller builder cache store-admin mesos-master mesos-slave mesos-marathon zookeeper)
for c in "${COMPONENTS[@]}"; do
    image=deis/${c}:$DEIS_RELEASE
    docker history $image >/dev/null 2>&1 || ${DOCKER_PULL} $image
    docker tag -f ${image} ${BACKEND_HOST}/${image} && docker push ${BACKEND_HOST}/${image}
done


COMPONENTS_QUAY_IO=(coreos/etcd:v2.1.1 coreos/flannel:0.5.1 coreos/discovery.etcd.io)
for c in "${COMPONENTS_QUAY_IO[@]}"; do
    image=quay.io/${c}
    docker history $image >/dev/null 2>&1 || ${DOCKER_PULL} $image
    docker tag -f ${image} ${BACKEND_HOST}/${c} && docker push ${BACKEND_HOST}/${c}
done

COMPONENTS_HEROKU=(cedar:14)
for c in "${COMPONENTS_HEROKU[@]}"; do
    image=heroku/${c}
    docker history $image >/dev/null 2>&1 || ${DOCKER_PULL} $image
    # docker tag -f ${image} ${BACKEND_HOST}/${image} && docker push ${BACKEND_HOST}/${image}
    docker tag -f ${image} daocloud.io/cloudmario/${c} && docker push daocloud.io/cloudmario/${c}
done
