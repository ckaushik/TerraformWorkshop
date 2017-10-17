# TerraformWorkshop

### Generate a key pair called deployer
```
ssh-keygen -t rsa
``` 
Copy the private key to deployer.pem in current directory <br/>
Replace the public key value in aws_key_pair block in aws.tf


### Add your AWS credentials in aws.tf
ACCESS_KEY <br/>
SECRET_KEY

### Run Terraform
```
terraform plan
terraform apply
```
