# Build

This project contains common build scripts that are used by my project. The idea is to reduce the Makefile copy-paste from one project to another, standardize all the codebase and speed the development of a new project.

> In the future, I would like to put more logic in these makefiles to implement more versatility and some more check, for now, they are a little.

## Prerequisites

* [make](https://www.gnu.org/software/make/).

> Other prerequisites can be found under each folder, check it before `include` them. For sure [Docker](https://www.docker.com/) is a must since I will use containers every time I can.

## Configure

To use this build project just add a submodule to your project:

```shell
git submodule add https://github.com/giglium/build build -b main
```

and add a `Makefile` in the root folder.

An example of a minimal configuration is:

```makefile
# ====================================================================================
# Setup Project

include common.mk

# ====================================================================================
# Actions

.PHONY: all
all:  help

.PHONY: test
test: ; @:

.PHONY: clean
clean: ; @:
```

After that, you can include all the `*.mk` files to enable the out-of-the-box command.

## Version

For now, is impossible to use a tag on submodules. For this reason, I will create a branch with a pattern like `v0.0.1` every time I introduce breaking change. This branch will not be maintained but they will give enough time to migrate to the `main` version. So get a look every time you update the submodules!

## License

[MIT License](https://opensource.org/licenses/MIT)
