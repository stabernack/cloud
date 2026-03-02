# Stabernack Cloud

This is a simple cloud service that allows you to upload files and share them with others. It is built using nextcloud and traefik.

## Production

Before you can run `docker compose up` you need to create a docker network called `traefik-network` manually. This "external" network is then used by traefik to route to nextcloud correctly.   

```bash
docker network create traefik-network
```

Then search for the docker network’s subnet address:

```bash
docker network inspect traefik-network

# example output:
{
    "Name": "traefik-network",
    "Id": "…",
    "Created": "2023-10-01T12:34:56.789012345Z",
    "Scope": "local",
    "Driver": "bridge",
    "EnableIPv6": false,
    "IPAM": {
        "Driver": "default",
        "Config": [
            {
                "Subnet": "172.20.0/16",
                # …
```

Use this subnet address to set the `NEXTCLOUD_TRUSTED_PROXIES` environment variable in the `.env` file. This is used by nextcloud route requests correctly.

```env
# ...
NEXTCLOUD_TRUSTED_PROXIES=172.20.0/16
# ...
```