# Ansible Build
Steps to build the kubernetes cluster and the hosts in the cluster. Also some steps to install applications like Istio.

The first few sections are the set up the PC/Laptop. Once done only the last few sections are needed to build the kubernetes cluster.

## Update ansible.cfg file
Most of [ansible.cfg](https://docs.ansible.com/ansible/latest/reference_appendices/config.html#the-configuration-file) is commented out, but note the 3 items not commented out. **Run the `ansible-playbook` command from within the same folder ansible.cfg exists.** That way Ansible will find the key used to login, the username used, and not check for the host's key (for MIM attacks, etc).

Makes sure to edit the `private_key_file` with the location of the private key that relates to the public key that was given to Terraform when the AWS infra was created.
```
private_key_file=~/.ssh/id_rsa000
remote_user=ubuntu
host_key_checking=False
``` 

## Install pyenv and python version and create a VirtualEnv
Install pyenv
```
brew install pyenv
```
Install Python and create a virtual environment for Ansible
```
pyenv install 3.11.9
pyenv virtualenv 3.11.9 ansible
```
Activate virtual environment
```
pyenv activate ansible
python --version
```
If not on the proper python version, try running `pyenv init` or `eval "$(pyenv init -)"`

## Install Ansible
Make sure you are in the ansible virtualenv and install Ansible
```
pyenv virtualenvs
pip install ansible==10.3.0
```

## Add host VARs to the shell
See the Terraform README.md for how to add these VARs

## Creating the K8s cluster and tools
The Ansible playbooks show all the commands that will be ran on the hosts. So learn ansible if you want to know how the K8s cluster is created. 😉

**All commands below will assume they are ran from this folder** since the `ansible.cfg` and `hosts` file is in this folder.

Can check the reachability of the hosts with
```
ansible -i hosts all -m ping
```
Install K8s
```
ansible-playbook -i hosts playbooks/kubernetes/main_playbook.yml
```
Carefull when needing to run the playbooks more than once. I tried to make Ansible detect when something was already done so it would skip, but not everything works out that well.

Moved a lot of installs from shell commands to ansible modules like `apt`, `apt-key`, etc to allow for ansible to detect the install. Let the old shell commands in as a comment for comparison.

## Access via Control Host
The control host has kubectl and other tools installed on it and configured to interact with the K8s cluster.

Log into the hosts using env var values
```
ssh -i ~/.ssh/id_rsa ubuntu@$control1
```