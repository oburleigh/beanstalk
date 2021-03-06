# Introduction

The Notejam application was originally a monolith, containing a built-in webserver and SQLite database.

As part of a pilot the architecture has been redesigned to enable a move to a more cloud native solution and address several
identified business requirements.

The chosen AWS solution for the pilot is [Elastic Beanstalk](https://aws.amazon.com/elasticbeanstalk/) with a Flask application deployed.

- Creation of Core Network - ALB, VPC, Internet GW, Route Tables (RT), Routes, RT Association and Subnets
- Creation of external RDS DB
- Creation of Beanstalk Environment, Applications and Application Version
- Creation of S3 Bucket and Objects
- Creation of Security - Security Groups, IAM Policies

![High Level Architecture](elbs.svg)

## Pre-requisites

You will need to ensure your credentials are reachable in order to authenticate with AWS see this link
[AWS Provider Authentication Options](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

## Usage

Navigate to the ***Dev*** folder on the cloned repository locally on your device. A *webapp.tfvars* file has been provided as a base to update/amend values as you please. No data held in this [tfvars](https://www.terraform.io/docs/language/values/variables.html) file is sensitive but always exercise caution when storing these types of files on public reposititories as sensitive values can be present even by accident.

Note: one senstive value not stored in the tfvars file and that needs to be set is **db_password**, this value is to set the password for the RDS DB and could be autogenerated as part of a CI pipeline and then stored in a credential/secrets manager e.g. Hashicorp Vault. Its usage in this example is shown in the Terraform Plan section where you can set the value via the CLI.

Once happy with the inputs, you may execute

[Terraform Init](https://www.terraform.io/docs/cli/commands/init.html)

```bash
terraform init
```
[Terraform Plan](https://www.terraform.io/docs/cli/commands/plan.html)

```bash
terraform plan --var-file=webapp.tfvars --var="db_password=<YOUR_DB_PASSWORD>" -out=path<ADD YOUR TARGET>
```

If the result is what you expected, feel free to

[Terraform Apply](https://www.terraform.io/docs/cli/commands/apply.html)

```bash
terraform apply -auto-approve --var-file=webapp.tfvars --var="db_password=<YOUR_DB_PASSWORD>" <YOUR PLAN NAME AS ABOVE>
```

Note when you [Terraform Destroy](https://www.terraform.io/docs/cli/commands/destroy.html) you'll need to provide that tfvar file as input again.

## Providers

[AWS](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

## In Progress

- [x] Add architecture diagram
- [x] Add Autoscaling
- [ ] Add Rolling Deployments
- [ ] Add Rolling Updates
- [ ] Move EC2 Instances to dedicated Application Subnets
- [ ] Extend component logging
- [ ] Move state to S3 with Dynamo providing the locking
- [ ] Add switch functionality to turn on/off certain modules
- [ ] Move modules to own repositories
- [ ] Create more flexibility in data structure to process more objects i.e. for_each
- [ ] Split the existing Root module and create more state seperation together with wrapper script for executing commands with good user experience
- [ ] Add workspaces
- [ ] Enrich the current modules with the additional functionality provided by the Provider
- [ ] Add Terratest tests

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License
[MIT](https://choosealicense.com/licenses/mit/)
