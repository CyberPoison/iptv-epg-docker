
### TV EPG (Electronic Programme Guide)

### Deployment Instructions

##### Docker Container Deployment

To deploy the TV EPG Docker container, follow these steps:

1. Run the Docker container with the appropriate environment variables and port mapping:

    ```bash
    docker run -e WEBSITES=meo.pt,sky.com,chaines-tv.orange.tv -e CRON="0 0 * * *" -p 8080:3000 --name epg-tv cyberpoison/tv-epg
    ```

    Replace `WEBSITES` environment variable with the desired list of websites (explained below) and adjust the port mapping (`-p`) as needed.

### Environment Variable: WEBSITES

The `WEBSITES` environment variable specifies a list of websites from which the TV EPG data will be fetched. Each website should be separated by a comma. The variable can accept multiple choices of the following links:

- [iptv-org/epg: SITES.md](https://github.com/iptv-org/epg/blob/master/SITES.md)

For example, to fetch data from "meo.pt", "sky.com", and "chaines-tv.orange.tv", set `WEBSITES` as follows, cron can also be set to define a crontab to refresh the data:

```bash
WEBSITES=meo.pt,sky.com,chaines-tv.orange.tv
CRON="0 0 * * *"
```

## Supported CPU Architectures

| CPU Architecture | Support |
| ---------------- | ------- |
| linux/amd64      | ✅      |
| linux/arm/v6     | ❌      |
| linux/arm/v7     | ❌     |
| linux/arm64      | ✅     |

Note: Only `linux/amd64` is currently supported. Support for other architectures may be added in future releases.

---

This documentation provides instructions for deploying the TV EPG Docker container, explaining the usage of the `WEBSITES` environment variable and listing the supported CPU architectures.
