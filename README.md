# terraform-k3s
A [Breakable Toy](https://www.oreilly.com/library/view/apprenticeship-patterns/9780596806842/ch05.html#breakable_toys) to learn Terraform by provisioning a [K3S](https://k3s.io/) cluster on Digital Ocean.

## Setup
1. Create an account on [Digital Ocean](https://www.digitalocean.com/).
2. Create a Digital Ocean [Personal Access Token](https://docs.digitalocean.com/reference/api/create-personal-access-token/).
3. Rename `terraform.tfvars.template` to `terraform.tfvars`.
4. Provide the necessary configuration in `terraform.tfvars`:
    1. To find your ssh key fingerprint, run: `ssh-keygen -l -E md5 -f <path to ssh public key file>`
5. Run `terraform init` to download the Digital Ocean provider and ha-k3s module.
6. Run `terraform plan` to validate that your configuration is correct (a "dry run").
7. Run `terraform apply` to provision your HA K3S cluster.
    1. Remember: This will create resources on your Digital Ocean account and will cost a small amount of money!

## Explanation
`main.tf` depends on the external module `ha-k3s`.

The `ha-k3s` module (see [https://github.com/aigisuk/terraform-digitalocean-ha-k3s](https://github.com/aigisuk/terraform-digitalocean-ha-k3s)) contains a number of individual configuration files, which use the `.tf` extension.

When a Terrform module is applied, all files are parsed (in alphabetical order) and a dependency graph is created. Note that some resources provide a `depends_on` property that may impact this graph, for example:

```
# server.tf

resource "digitalocean_droplet" "k3s_server" {
  # ...
  depends_on = [
    digitalocean_droplet.k3s_server_init
  ]
}
```

Therefore, when applying a module with multiple configuration files, you can expect that some will be run in parallel.

## References
Based off of an example from [colinwilson](https://github.com/colinwilson/example-terraform-modules/tree/terraform-digitalocean-ha-k3s).
