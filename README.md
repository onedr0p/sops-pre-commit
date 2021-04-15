# sops-pre-commit

[![pre-commit.ci status](https://results.pre-commit.ci/badge/github/k8s-at-home/sops-pre-commit/main.svg)](https://results.pre-commit.ci/latest/github/k8s-at-home/sops-pre-commit/main)

Sops [pre-commit](https://pre-commit.com/) hook.

* Check for unencrypted Kubernetes secrets in manifest files.

## Requirements

* Pre-commit 1.2 or later

## Installation

Add the following to your `.pre-commit-config.yaml`


```yaml
- repo: https://github.com/k8s-at-home/sops-pre-commit
  rev: v2.0.1
  hooks:
  - id: forbid-secrets
```

## License

This software is licensed under the MIT license (see the LICENSE file).

## Credits

[angelnu](https://github.com/angelnu/k8s-gitops/)
