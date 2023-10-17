$num_instances = ENV['V_NUM_INSTANCE'].to_i
$subnet = ENV['V_SUBNET_PREFIX']
$os = "ubuntu2204"
$instance_name_prefix = ENV['CLUSTER_INSTANCE_PREFIX'] || 'k8s'