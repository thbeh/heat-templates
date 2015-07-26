# heat-templates

heat -v stack-create hadoop-clusters -f heat_4b.yaml -P "key=cloud;image=centos-6.6-x86_64;shared_ip=172.0.33.12;vmname=consul0;num_instances=2" -e env_client_node.yaml
