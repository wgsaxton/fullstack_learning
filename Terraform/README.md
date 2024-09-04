# Terraform Build
Steps to build the IaaS on AWS with terraform

## Install tfenv
Use to get the correct version of terraform on PC

```
brew install tfenv
tfenv install 1.5.2
tfenv use 1.5.2
```

## Create a SSH public key pair
This will be used for logging into hosts. Ansible will be using this too.

RSA is the example. Other types like ed25519 should work too.
```
ssh-keygen -t rsa -b 4096    # then answer questions
# Can verify the type of key pair by:
ssh-keygen -l -f testing
```

Add the public key as an env var. `cat` the pulic file to see it's contents
```
cat testing.pub
export TF_VAR_aws_ssh_pub_key=ssh-rsa ...
```

## Set Env Vars

ACloud Guru gives these keys when a playground is created.

The AWS key variables should be env vars and not in the tf files. Set the env vars by:
```
export TF_VAR_aws_access_key="YOUR_ACCESS_KEY"
export TF_VAR_aws_secret_key="YOUR SECRET KEY"
```

_2nd option (less prefered):_ These env vars really relate to the AWS CLI, but terraform picks them up. So the env vars reference is [here](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html).
```
export AWS_ACCESS_KEY_ID="YOUR_ACCESS_KEY"
export AWS_SECRET_ACCESS_KEY="YOUR SECRET KEY"
```

## Run terraform cmds

```
terraform init
terraform plan
terraform apply
```
To remove all AWS built infra when done
```
terraform destroy
```

## Terraform Output
Terraform will output the host names with public IPs.

Terraform also outputs the command to format the info in a way that adds the hosts to environment variables. Add these VARs to your shell to help with SSH (below section) and for Ansible.

**Ansible needs these VARs in your shell to access the hosts.**

Example: Copy the `export` commands and paste them into the shell Ansible will use.
```
❯ terraform output -json servers_output | jq -r '.[0,1,2,3]'
export control1='54.172.108.66'
export worker1='54.242.7.180'
export worker2='54.196.221.98'
export worker3='54.152.143.84'
```

## SSH to instances
if using ACG playgroud, the username is `cloud_user` or whatever the username is to log into the sandbox's console.

Example:
If you put the env vars in after running terraform you can do
```
ssh -i ~/.ssh/id_rsa ubuntu@$control1
``` 
another example
```
% ssh -i id_rsa ubuntu@3.88.16.48
```