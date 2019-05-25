easy-redis
===

Easy launching disposable redis single/cluster server for testing.

# Requirements

* docker (Which has feature multi-stage build)

# Build

```bash
$ docker build -t easy-redis .
```

# Run

* Single server (port=16379), Stop by CTRL+C
  ```bash
  $ docker run -ti --rm --net host easy-redis single
  ```

* Cluster mode (port=16379~16381, 3 nodes, 0 replica), Stop by CTRL+C
  ```bash
  $ docker run -ti --rm --net host easy-redis cluster
  ```

* Cluster mode (port=16379~16384, 6 nodes, 1 replica), Stop by CTRL+C
  ```bash
  $ docker run -ti --rm --net host easy-redis cluster -n 6 -r 1
  ```

# My Environment

* CentOS 7.5
* Docker 18.06.1-ce

