# AyaPay Infrastructure Provision Using Terraform



# ********Disclaimer: This is a test project for interview.******



# Overview

Whole infrastructure is hand code by scratch. Modules are split for reusability and easier management. Initially planned to use `.tfvars` but due to the nature of project is demonstration, I reduced the environment complexity by not using `.tfvars` and hand code almost everything inside [`variables.tf`] and `locals.tf`

# Modules

There is two modules 

- Networking
- Compute

Initially, I was planned to separate more modules, but to reduce modules verbosity, I only separate two and split layer inside the modules like `[securitygroups.tf]` and [`keypar.tf`].

# Setup and Run

Every required dependencies such as docker and nginx are installed at initial state of instance, and main app image is pulled. User only need to go inside the instance via bastion host and configure nginx and run the image.

The command to run the image

```docker
$ docker run -p <host-port>:<docker-port> \
-d -e PORT=3000 -e NODE_ENV=production \ 
khantki/ayapay-simple-node-app:main
```

Keypair was deployed via terraform but the Private key values are here

```docker
-----BEGIN OPENSSH PRIVATE KEY-----
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
-----END OPENSSH PRIVATE KEY-----
```