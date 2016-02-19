# Deis phpPgAdmin

A PostgreSQL database dashboard (phpPgAdmin) for use in the [Deis@HeheCloud](http://hehecloud.com/) open source PaaS.

This Docker image is based on the official
[alpine:3.2](https://registry.hub.docker.com/_/alpine/) image.

Please add any [issues](https://github.com/HeheCloud/deis-phppgadmin/issues) you find with this software to the Project.

## Usage

Build & push:

```
DEIS_RELEASE=v1.12.2
docker build -t hehecloud/phppgadmin:${DEIS_RELEASE} . && \
docker tag -f hehecloud/phppgadmin:${DEIS_RELEASE} localhost:5000/deis/phppgadmin:${DEIS_RELEASE} && \
docker push localhost:5000/deis/phppgadmin:${DEIS_RELEASE}
```

Install & Run

1. set environment `export DEISCTL_UNITS=/var/lib/deis/units`
2. copy the `deis-phppgadmin.service` file to path: `/var/lib/deis/units/deis-phppgadmin.service`
3. run `deisctl install phppgadmin` to install
4. run `deisctl start phppgadmin` to start
5. open url: `http://<your ip>:10801/` or `http://phppgadmin.<your deis endpoint>/`

Stop & Uninstall

1. set environment `export DEISCTL_UNITS=/var/lib/deis/units`
2. run `deisctl stop phppgadmin` to stop
3. run `deisctl uninstall phppgadmin` to uninstall

Only test (in your etcd cluster):
```
# run
docker run -it --name phppgadmin_v2.cmd.1 \
  --rm -p 10801:8000 \
  -e EXTERNAL_PORT=10801 \
  -e HOST=<your ip address in etct cluster> \
  hehecloud/phppgadmin

# clean etcd info
docker run -it --name phppgadmin_v2.cmd.1 \
  --rm -p 10801:8000 \
  -e EXTERNAL_PORT=10801 \
  -e HOST=<your ip address in etct cluster> \
  hehecloud/phppgadmin \
  /app/bin/clean
```

## Environment Variables

* **DEBUG** enables verbose output if set
* **ETCD_PORT** sets the TCP port on which to connect to the local etcd
  daemon (default: *4001*)
* **ETCD_PATH** sets the etcd directory where the database announces
  its configuration (default: */deis/database*)
* **ETCD_PATH** sets the etcd directory where the phppgadmin announces
  its configuration (default: */deis/phppgadmin*)
* **ETCD_TTL** sets the time-to-live before etcd purges a configuration
  value, in seconds (default: *10*)
* **HOST** Host's IP address
* **EXTERNAL_PORT** sets the TCP port on which the web server listens (default: *10801*)
