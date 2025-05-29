## Prometheus, grafana and node exporter

## prerequisites:
- EC2 instance Ubuntu
## Install node exporter on the ec2 instance
# Steps to install
- sudo apt update -y
- sudo apt install wget tar -y
- cd /opt
- sudo wget https://github.com/prometheus/node_exporter/releases/download/v0.18.1/node_exporter-0.18.1.linux-amd64.tar.gz
- sudo tar -xvzf node_exporter-0.18.1.linux-amd64.tar.gz
- sudo mv node_exporter /usr/local/bin/
- To create a systemd service, 
  sudo vi /etc/systemd/system/node_exporter.service
  - [Unit]
    Description=Node Exporter
    After=network.target
    [Service]
    Exec=/usr/local/bin/node_exporter
    User=nobody
    [Install]
    WantedBy=default.target
  - save the service file and execute the following commands
  - sudo systemctl daemon-reload
  - sudo systemctl enable node_exporter
  - sudo systemctl start node_exporter

## Install prometheus on the ec2 instance
# Steps to install
- cd /opt
- sudo wget https://github.com/prometheus/prometheus/releases/download/v2.1.0/prometheus-2.1.0.linux-amd64.tar.gz
- sudo tar -xvzf prometheus-2.1.0.linux-amd64.tar.gz
- sudo mv prometheus-2.1.0.linux-amd64/prometheus-2.1.0.linux-amd64/promtool /usr/local/bin
- sudo mv prometheus-2.1.0.linux-amd64/consoles prometheus-2.1.0.linux-amd64/console_libraries /etc/prometheus
- sudo vi /etc/prometheus/prometheus.yml , under scrape_configs:
   - job_name = 'node_exporter'
     static_configs:
       - targets = ['localhost:9100']

- Create a systemd service for prometheus also
   - sudo vi /etc/systemd/system/prometheus.service
     [Unit]
     Description = Prometheus
     After = network.target
     [Service]
     User=nobody
     ExecStart= /usr/local/bin/prometheus \
        --config.file=/etc/prometheus/prometheus.yml \
        --storage.tsdb.path=/var/lib/prometheus/ \
        --web.console.templates=/etc/prometheus/consoles \
        --web.console.libraries=/etc/prometheus/console_libraries
    [Install]
    WantedBy=target.local
  - sudo systemctl daemon-reload 
  - sudo systemctl enable prometheus
  - sudo systemctl start prometheus
    

## Install Grafana on the ec2 instance
Grafana is a system managed package , so follow the below 
# steps to install 

- cd /tmp
- sudo wget https://dl.grafana.com/oss/release/grafana_7.4.1_amd64.deb
- sudo apt-get install -f
- sudo dpkg -i grafana_7.4.1_amd64.
- sudo systemctl daemon-reload
- sudo systemctl enable grafana-server
- sudo systemctl start grafana-serverdeb

## Connect Prometheus to Grafana
- Go to Grafana Settings
- Add datasource, select prometheus

## Creating Dashboard
- Go to create dashboard, import
- select node exporter predefined dashboard with id 11074 
- select prometheus as data source
- save and import 

### Node exporter dashboard can be seen on grafana 