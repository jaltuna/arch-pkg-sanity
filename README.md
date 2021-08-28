# Arch Package Sanity
[![License: MIT](https://img.shields.io/badge/License-MIT-informational.svg)](https://github.com/jaltuna/arch-pkg-sanity/blob/main/LICENSE)

Checking Arch Packages sanity:

* Check PKGBUILD
* Check .SRCINFO
* Check package file (*.pkg.tar.zst)

## Github docker action

Use [namcap](https://wiki.archlinux.org/title/Namcap) to check source PKGBUILD and the binary package.

### Inputs  

* `package`: The package name to check. Corresponds to a directory in this repository (**Required**)
  
* `warnings`: The warnings thrown by namcap without affecting the package (**Optional**)

### Example

```yaml
jobs:
  arch:
    runs-on: ubuntu-latest    
    steps:
      - uses: actions/checkout@v2
      - uses: ./
        with: 
          package: "package-name"
          warnings: |
            package-name W: Dependency included and not needed
            package-name W: Others warnings
```

## Packages
