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

Add 

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