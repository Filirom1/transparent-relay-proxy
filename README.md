# Transparent Relay Proxy

## Build

```
docker build -rm -t proxy ./
```

## Relay proxy

```
docker run --net=host -v `pwd`/PAC:/mnt/PAC --rm proxy pac+file:///mnt/PAC
all_proxy=localhost:3128 curl http://google.fr
all_proxy=localhost:3128 curl https://google.fr
```


## Transparent proxy

```
iptables -t nat -A PREROUTING -p tcp --dport 80  -j REDIRECT --to 3128  -w
iptables -t nat -A PREROUTING -p tcp --dport 443 -j REDIRECT --to 12345 -w
docker run --net=host -v `pwd`/PAC:/mnt/PAC --rm proxy pac+file:///mnt/PAC
```

## Debug

Add the following option to docker run `-e DEBUG=*`

## License

MIT
