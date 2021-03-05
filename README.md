# OmniDB Server

Docker container based on Debian linux running **OmniDB 3.0.3b** with oracle client for easy database management via web interface.


**Creating a container**
```sh
docker run -it -d -p 8080:8080 -p 25482:25482  ugleiton/omnidbserver
```


|Port| Usage  |
|--|--|
| 8080 | HTTP  |
