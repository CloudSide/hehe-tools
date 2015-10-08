deis-builder加速

```
DEIS_RELEASE=v1.11.0
docker build -t hehe/builder:${DEIS_RELEASE} . && \
docker tag -f hehe/builder:${DEIS_RELEASE} localhost:5000/deis/builder:${DEIS_RELEASE} && \
docker push localhost:5000/deis/builder:${DEIS_RELEASE}
```
