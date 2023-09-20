# Terraform Beginner Bootcamp 2023

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

### Considerations for Linux Distribution + OS Version

This project is built using the Ubuntu distribution of Linux. If your project is anything other than Ubuntu, be aware that you may need to alter the scripts per your distribution. 

How to check distro + version: ```cat /etc/os-release```

[How To Check Which Linux Disribution You're Using](https://www.tecmint.com/check-linux-os-version/#:~:text=The%20best%20way%20to%20determine,on%20almost%20all%20Linux%20systems)

### Refactoring into Bash Scripts

The code provided for a Terraform CLI install is large, so it has been condensed in our Gitpod Task File ([.gitpod.yml](.gitpod.yml)).

Link to the Bash Script provided by Hashi: [./bin/install_terraform_cli](./bin/install_terraform_cli)


### Shebang



https://en.wikipedia.org/wiki/Shebang_(Unix)

- https://www.gitpod.io/docs/configure/workspaces/tasks#prebuild-and-new-workspaces
- https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
- https://www.hashicorp.com/official-packaging-guide
- https://en.wikipedia.org/wiki/Shebang_(Unix)
- https://linuxize.com/post/how-to-use-apt-command/
- https://en.wikipedia.org/wiki/Chmod
- https://www.gnupg.org/
- https://www.liquidweb.com/kb/is-gpg-still-useful-in-todays-insecure-world/#:~:text=What%20Goal%20Does%20GPG%20Help,security%20against%20modification%20and%20tampering.
- https://manpages.ubuntu.com/manpages/xenial/en/man1/gpg.1.html