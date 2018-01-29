# Grafana docker image for Openshift Cluster

This build is based on the official [Grafana docker image](https://github.com/grafana/grafana-docker).

Theres several projects on Github that fixes this issue. But none of them reuses the [run.sh](https://github.com/grafana/grafana-docker/blob/master/run.sh) script from the official image, or uses a diferent distribution to build the image.

In this project I use the [official Dockerfile](https://github.com/grafana/grafana-docker/blob/master/Dockerfile) as a starting point and a modified version of their [entrypoint script](https://github.com/grafana/grafana-docker/blob/master/run.sh).

## Why?
Official Grafana docker image needs root to execute [run.sh](https://github.com/grafana/grafana-docker/blob/master/run.sh).
Since the container starts with other uid - witch is not root - it cannot execute chown directories.
```
chown: changing ownership of '/var/lib/grafana': Operation not permitted
chown: changing ownership of '/var/log/grafana': Operation not permitted
```

## Configuration

The recommended way to configure this image is using environment variables,
http://docs.grafana.org/installation/configuration/#using-environment-variables

For example:
```
- name: GF_DATABASE_URL
  value: "${GF_DATABASE_URL}"
- name: GF_SECURITY_ADMIN_USER
  value: "${GF_SECURITY_ADMIN_USER}"
- name: GF_SECURITY_ADMIN_PASSWORD
  value: "${GF_SECURITY_ADMIN_PASSWORD}"
- name: GF_USERS_ALLOW_SIGN_UP
  value: "${GF_USERS_ALLOW_SIGN_UP}"
- name: GF_AUTH_ANONYMOUS_ENABLED
  value: "${GF_AUTH_ANONYMOUS_ENABLED}"
- name: GF_AUTH_ANONYMOUS_ORG_ROLE
  value: "${GF_AUTH_ANONYMOUS_ORG_ROLE}"
```
