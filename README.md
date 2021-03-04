# OmniDB Server

Docker container based on Debian linux running **OmniDB 3.0.3b** with oracle client for easy database management via web interface.


**Creating a container**
```sh
docker run -it -d -p 8080:8080 -p 25482:25482  ugleiton/omnidbserver
```

**Creating a container with a websocket port other than 25482 (overwrite the entrypont)**
```sh
docker run -it -d -p 8080:8080 -p 25482:25482 --entrypoint "omnidb-server" ugleiton/omnidbserver --host=0.0.0.0 --port=8080 -e 35482
```

|Port| Usage  |
|--|--|
| 8080 | HTTP  |
| 25482| Websocket|
