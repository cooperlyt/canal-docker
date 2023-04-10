cpu_arch=`arch`

if [ "$cpu_arch" = "x86_64" ]
then
  cpu_arch = "amd64"
fi

wget "https://github.com/prometheus/node_exporter/releases/download/v0.18.1/node_exporter-0.18.1.linux-$cpu_arch.tar.gz" -O /tmp/node_exporter.tar.gz