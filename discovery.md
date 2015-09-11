## discovery

### Set custom discovery services

 
* set host ip for etcd

```
export HOST_IP="127.0.0.1"
 
docker run -d -v /usr/share/ca-certificates/:/etc/ssl/certs -p 4001:4001 -p 2380:2380 -p 2379:2379 \
 --name hehe-etcd \
 --restart="always" \
 quay.io/coreos/etcd:v2.1.1 \
 -name etcd0 \
 -advertise-client-urls http://${HOST_IP}:2379,http://${HOST_IP}:4001 \
 -listen-client-urls http://0.0.0.0:2379,http://0.0.0.0:4001 \
 -initial-advertise-peer-urls http://${HOST_IP}:2380 \
 -listen-peer-urls http://0.0.0.0:2380 \
 -initial-cluster-token etcd-cluster-1 \
 -initial-cluster etcd0=http://${HOST_IP}:2380 \
 -initial-cluster-state new
 
```

* run discovery service as host mode

```
docker run --name hehe-discovery -d --net=host \
 --restart="always" \
 -e "DISCOVERY_HOST=http://discovery.hehecloud.com" \
 quay.io/coreos/discovery.etcd.io
 
```

* test 

```
curl -v -X PUT localhost:8087/new

``` 
 

