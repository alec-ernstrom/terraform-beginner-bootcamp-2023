# Terraform Beginner Bootcamp 2023

- [Semantic Versioning](#semantic-versioning)
- [Install the Terraform CLI](#install-the-terraform-cli)
  * [Considerations for Linux Distribution and OS Version](#considerations-for-linux-distribution-and-os-version)
  * [Refactoring into Bash Scripts](#refactoring-into-bash-scripts)
  * [Shebang](#shebang)
  * [Setting Project Root Env Vars](#setting-project_root-env-var)
  * [Creating a bash script for The Terraform Cloud Token](#creating-a-bash-script-for-the-terraform-cloud-token)
- [AWS CLI Installation](#aws-cli-installation)
  * [AWS CLI Env Vars](#aws-cli-env-vars)
  * [AWS CLI - Check Credentials](#aws-cli---check-credentials)
- [Congfiguring main.tf Providers](#congfiguring-maintf-providers)
  * [Terraform Cloud](#terraform-cloud)
  * [Creating an alias for Terraform](#creating-an-alias-for-terraform)
  * [Storing the alias in the bash profile](#storing-the-alias-in-the-bash-profile)

## Semantic Versioning

Bunch of stuff about **semantic versioning**

- Things to do with semantic versioning
- *More* things to do with semantic versioning
- *Even __more__* things to do with semantic versioning

Very cool! :thumbsup:
:shrug:

## Install the Terraform CLI

The Terraform installation instructions have changed due to gpg keyring changes. Refer to the latest installation instructions for more information.

[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Considerations for Linux Distribution and OS Version

This project is built using the Ubuntu distribution of Linux. If your project is anything other than Ubuntu, be aware that you may need to alter the scripts per your distribution. 

How to check distro + version: 

```sh
cat /etc/os-release
```

[How To Check Which Linux Disribution You're Using](https://www.tecmint.com/check-linux-os-version/#:~:text=The%20best%20way%20to%20determine,on%20almost%20all%20Linux%20systems)

### Refactoring into Bash Scripts

The code provided for a Terraform CLI install is large, so it has been condensed in our Gitpod Task File ([.gitpod.yml](.gitpod.yml)).

Link to the Bash Script provided by Hashi: [./bin/install_terraform_cli](./bin/install_terraform_cli)


### Shebang

https://en.wikipedia.org/wiki/Shebang_(Unix)

### Setting $PROJECT_ROOT Env Var

We can set a default location for working with our Terraform module after install into our terminal environment by placing the following code in our bash scripts:

```sh
PROJECT_ROOT='/workspace/terraform-beginner-bootcamp-2023'
```

This, coupled with a ```cd``` command will allow us to navigate to that location every time the bash script has finished initializing our terminal

```sh
cd '/workspace/terraform-beginner-bootcamp-2023'
```

### Creating a bash script for The Terraform Cloud Token

You'll need to generate a token from the Terraform Cloud GUI at:

https://app.terraform.io/app/settings/tokens

Once generated, you can import your token into your local terraform terminal environment using ```export``` and ```gp env```:

```sh
export TERRAFORM_CLOUD_TOKEN="<token>"
gp env TERRAFORM_CLOUD_TOKEN="<token>"
```

Next you'll use a code block similar to the following, inside of a bash script, to create a directory inside your environment to hold a file that will store this token, and apply it each time you spin up your environment, saving you from having to manually perform a ```terraform login```:

```sh
#!/usr/bin/env bash

# Check if the TERRAFORM_CLOUD_TOKEN environment variable is set
if [ -z "$TERRAFORM_CLOUD_TOKEN" ]; then
  echo "TERRAFORM_CLOUD_TOKEN environment variable is not set."
  exit 1
fi

# Define the target directory
target_dir="/home/gitpod/.terraform.d"

# Create the directory if it doesn't exist
mkdir -p "$target_dir"

# Create the JSON structure for credentials.tfrc.json
cat <<EOF > "$target_dir/credentials.tfrc.json"
{
  "credentials": {
    "app.terraform.io": {
      "token": "$TERRAFORM_CLOUD_TOKEN"
    }
  }
}
EOF

echo "credentials.tfrc.json has been created in $target_dir with the provided token."
```

### AWS CLI Installation

AWS CLI is installed for this project via a bash script [./bin/install_aws_cli](./bin/install_aws_cli)

[Install or update the latest version of the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

### AWS CLI Env Vars

[AWS CLI Env Vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

Env Vars are stored in both the Gitpod Global Variables, as well as the individual Workspace env vars

### AWS CLI - Check Credentials

```
aws sts get-caller-identity
```

### Congfiguring main.tf Providers

When you configure you're provider, you'll need to make sure you add lines for authentication:

```sh
provider "aws" {
  region     = "us-west-2"
  access_key = "my-access-key"
  secret_key = "my-secret-key"
}
```
*** ^^ THIS IS BAD - DON'T DO THIS**
This method is insecure, because it involves placing your secure keys in clear-text within your configuration file, which is an obvious security concern.

If you only have set your Access Keys in your Global Variables for your Workspace, it you won't be able to finish your init - because the provider config has nothing to reference. You have to specifically call our your env var's using **export**:

```sh
export AWS_ACCESS_KEY_ID="anaccesskey"
export AWS_SECRET_ACCESS_KEY="asecretkey"
export AWS_REGION="us-west-2"
terraform plan
```

[Authentication and Configuration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication-and-configuration)

### Terraform Cloud

If you're using the Terraform Cloud block in your configuration file, you're telling your configuration environment to run IN the cloud, versus locally in your editor, so you need to remember to set environment variables IN the cloud GUI, so that environment can make use of them when referencing whatever API's it needs

From the Terraform Cloud Login page:

```"Terraform Cloud runs Terraform operations and stores state remotely, so you can use Terraform without worrying about the stability of your local machine, or the security of your state file."```

[Terraform Cloud Login](https://developer.hashicorp.com/terraform/tutorials/cloud-get-started/cloud-login)

### Creating an alias for Terraform

```sh
open ~/.bash_profile
```

Place the below lines into the profile

```sh
alias tf=terraform
```

### Storing the alias in the bash profile

need to add documentation here. Essentially create a file in ``/bin/`` to be referenced, with information about creating the alias. and then in the ``gitpod.yml``, we'll call out that directory where that file exists


### Additional Resources

- https://www.gitpod.io/docs/configure/workspaces/tasks#prebuild-and-new-workspaces
- https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
- https://www.hashicorp.com/official-packaging-guide
- https://en.wikipedia.org/wiki/Shebang_(Unix)
- https://linuxize.com/post/how-to-use-apt-command/
- https://en.wikipedia.org/wiki/Chmod
- https://www.gnupg.org/
- https://www.liquidweb.com/kb/is-gpg-still-useful-in-todays-insecure-world/#:~:text=What%20Goal%20Does%20GPG%20Help,security%20against%20modification%20and%20tampering.
- https://manpages.ubuntu.com/manpages/xenial/en/man1/gpg.1.html