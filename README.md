# Vault as secret store for GitHub Actions
> Example using HashiCorp Vault in place of the GitHub Actions secret store

## Motivation

Though GitHub Actions comes with an encrypted [secret store](https://help.github.com/en/actions/configuring-and-managing-workflows/creating-and-storing-encrypted-secrets), some users will prefer to keep secrets in [HashiCorp Vault](https://www.vaultproject.io/), either out of feature set comparison or convenience in already having secrets stored in Vault.

This repository contains an example [GitHub Actions workflow](.github/workflows/build.yml) leveraging [self hosted runners](https://help.github.com/en/actions/hosting-your-own-runners/about-self-hosted-runners), a community action ([`RichiCoder1/vault-action`](https://github.com/RichiCoder1/vault-action)), and a pre-configured AppRole and [policy](actions-policy.hcl).

Please adapt this example to the security needs of your own organization and the official Vault Production Hardening advice [here](https://learn.hashicorp.com/vault/operations/production-hardening).

## Setup

First go through these setup steps, adapted from this original Vault tutorial, [AppRole Pull Authentication](https://learn.hashicorp.com/vault/developer/approle):
1. (self hosted runner host) Set up a [self hosted runner](https://help.github.com/en/actions/hosting-your-own-runners/about-self-hosted-runners).
1. (Vault host) Download, install, and start up Vault on a machine which is network-connected to the self hosted runner. [eg. [steps](https://learn.hashicorp.com/vault/operations/ops-deployment-guide)]
1. (Vault host) Create a new policy `actions` based on [`actions-policy.hcl`](actions-policy.hcl). [eg. [steps](https://www.vaultproject.io/docs/concepts/policies#creating-policies)]
1. (Vault host) Enable the AppRole authentication method, create a named role `actions` with the `actions` policy attached, and fetch the RoleID and SecretID. [eg. [steps](https://www.vaultproject.io/docs/auth/approle#via-the-cli-1)]
1. (self hosted runner host) Export the RoleID and SecretID as environment variables:

```
export ROLE_ID=<my-role-id>
export SECRET_ID=<my-secret-id>
```
1. In the GitHub Actions workflow, point `url` to the location of your Vault instance.

## Usage

In this example, we get Docker login credentials from Vault that we had previously added via:

```
vault kv put secret/docker/creds login=<my-login> token=<my-token>
```

and we use them to log into Docker. 🎉

## Credits
- The community action [`RichiCoder1/vault-action`](https://github.com/RichiCoder1/vault-action)

## Contributing

Pull requests are welcome!

## License

[MIT](LICENSE)