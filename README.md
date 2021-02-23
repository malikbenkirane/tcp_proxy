# tcp_proxy

[![godoc](https://godoc.org/github.com/malikbenkirane/tcp_proxy?status.svg)](https://godoc.org/github.com/malikbenkirane/tcp_proxy) 
[![go report](https://goreportcard.com/badge/github.com/malikbenkirane/tcp_proxy)](https://goreportcard.com/report/github.com/malikbenkirane/tcp_proxy)

Simple tcp proxy with ssl/tls suppoort ready for containerization (kubernetes, docker, ...).

Fork of github.com/kahlys/proxy
> This code is for test purpose, it is sometimes ugly, it is not production ready, and the API will probably change.

## Build

### Local install (`tcpproxy`)

With a correctly configured [Go toolchain](https://golang.org/doc/install):

```console
$ git clone github.com/malikbenkirane/tcp_proxy/
$ cd tcp_proxy
$ go install ./cmd/tcpproxy
```

### Container image

```console
$ # alias podman=docker # if you have to use Docker
$ podman build .        # name it and tag it at your needs
$ podman run --rm -d -p $host_port:$lhost_port $image:$tag /opt/bin/tcpproxy $flags
```

## Comprehensive introduction

```text
                     +----------+            +--------+
  Client ----(TLS)-->| Listener |-----(TLS)->| Remote |
                     +----------+            +--------+
```

Listener setup options are prefixed with `-l`
- `-lhost 0.0.0.0:4444`
- `-lkey` enables TLS
- `-lcert path/to/cert`
- `-lkey path/to/key`

Remote setup options are prefixed with `-r`
- `-rhost 0.0.0.0:4444`
- `-rkey` enables TLS
- `-rcert path/to/cert`
- `-rkey path/to/key`

The example executable provides both TCP and TCP/TLS connection: `cmd/tcpproxy/main.go`

By default, the proxy address is *localhost:4444* and the target address is *localhost:80* (no TLS Layer).

```console
$ tcpproxy
2018/12/13 17:10:25 Proxying from :4444 to :80
```

## Options

```console
$ tcpproxy -help
Usage of tcpproxy:
  -lcert string
        certificate file for proxy server side
  -lhost string
        proxy local address (default ":4444")
  -lkey string
        key x509 file for proxy server side
  -ltls
        tls/ssl between client and proxy, you must set 'lcert' and 'lkey'
  -rcert string
        certificate file for proxy client side
  -rhost string
        proxy remote address (default ":80")
  -rkey string
        key x509 file for proxy client side
  -rtls
        tls/ssl between proxy and target, you must set 'rcert' and 'rkey'
```
