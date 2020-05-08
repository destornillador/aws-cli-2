# aws-cli-2 + aws sso credentials wrapper

The final Docker image created from the [Dockerfile](./Dockerfile) will containt
[aws-cli-2](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
and [aws-sso-cred-restore](https://github.com/destornillador/aws-sso-cred-restore)
binaries.

## Problem it resolves

Terraform gets the temporary AWS credentials from `~/.aws/credentials` file by
specifying an AWS profile through an environment variable (`AWS_PROFILE`).

Unlike other SSO tools, the `aws-cli-2` does not update the `~/.aws/credentials`
file but put them on `~/.aws/sso/cache/`. This is not useful for Terraform because
it expects them to be in other files.

Here is when `aws-sso-cred-restore` comes to rescue. It requests to the AWS SSO
a pair of key access and write them down in to the `credentials` file.

## Building

```sh
sudo docker build . -t local/aws-cli-2:latest
```

## How to use it

The container also has a small script named [update_credentials.sh](./update_credentials.sh)
that is in charge of log in to the SSO and running `aws-sso-cred-restore` binary.

You may run the container on this way:
```sh
export AWS_PROFILE=my_profile && sudo docker run -ti --rm -v "$HOME/.aws:/root/.aws" -e AWS_PROFILE=$AWS_PROFILE docker.pkg.github.com/destornillador/aws-cli-2/aws-cli-2:latest update_credentials.sh
```

NOTE: Your `.aws/` is mounted in to the container in order to get the `credentials`
file updated.
