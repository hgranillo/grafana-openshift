docker build \
  --tag "kriev/grafana-openshift:latest" \
  --no-cache=true .
docker tag \
  kriev/grafana-openshift:latest \
  kriev/grafana-openshift:4.6.3
