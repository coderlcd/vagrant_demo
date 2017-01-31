# Node Details: Instances
$box_name      = "ubuntu/xenial64"
$box_memory       = 4096
$box_vcpus        = 1

$ssh_user          = "ubuntu"
$ssh_keypath       = "~/.ssh/id_rsa"
$ssh_port          = 22

# Ansible Details:
$ansible_limit     = "all"
$ansible_playbook  = "bootstrap_env/bootstrap.yml"
$ansible_inventory = ".vagrant/provisioners/ansible/inventory_override"
