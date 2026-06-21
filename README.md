# dotfiles

Personal macOS dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## Prerequisites

This setup assumes macOS.

Recommended first-time prerequisites:

```sh
xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install chezmoi
```

Some casks may still ask for an admin password or macOS permissions during install or first launch.

## Install

Initialize and apply this repo:

```sh
chezmoi init --apply https://github.com/segunfamisa/dotfiles.git
```

During `chezmoi init --apply`, chezmoi also runs the managed Android tooling install script. Homebrew package installation is optional and can be run manually.

After the first install, update with:

```sh
chezmoi update
```

## Usage

Common commands:

```sh
chezmoi status
chezmoi diff
chezmoi apply
chezmoi edit ~/.zshrc
chezmoi cd
```

## Managed install scripts

chezmoi runs this script from the source repo once per machine:

```text
run_once_after_install-android-tooling.sh
```

The Android script delegates to:

```sh
bash ~/.config/dotfiles/toolchains/android-install.sh
```

That installs the Android CLI and Perfetto tools.

Homebrew package installation is intentionally manual/optional so different machines can choose whether to install the full Brewfile.

The optional Homebrew installer is applied to:

```text
~/.config/dotfiles/homebrew-install.sh
```

Run it manually with:

```sh
bash ~/.config/dotfiles/homebrew-install.sh
```

## Source layout

chezmoi keeps this repository as source state and applies files into `$HOME`.

Examples:

```text
dot_zshrc                         -> ~/.zshrc
dot_config/dotfiles/init.sh       -> ~/.config/dotfiles/init.sh
dot_config/homebrew/brewfile      -> ~/.config/homebrew/brewfile
dot_config/jj/config.toml         -> ~/.config/jj/config.toml
```

Main shell entrypoint:

```text
dot_zshrc
```

Organized dotfiles config:

```text
dot_config/dotfiles/init.sh
dot_config/dotfiles/homebrew.sh
dot_config/dotfiles/homebrew-install.sh.tmpl
dot_config/dotfiles/tools.sh
dot_config/dotfiles/aliases.sh
dot_config/dotfiles/secrets.sh
dot_config/dotfiles/local.sh
dot_config/dotfiles/firefox.sh
dot_config/dotfiles/toolchains.sh
dot_config/dotfiles/toolchains/
```

Toolchain-specific setup lives in:

```text
dot_config/dotfiles/toolchains/android.sh
dot_config/dotfiles/toolchains/java.sh
dot_config/dotfiles/toolchains/node.sh
dot_config/dotfiles/toolchains/python.sh
dot_config/dotfiles/toolchains/ruby.sh
dot_config/dotfiles/toolchains/rust.sh
```

Toolchain installers live alongside the toolchain config:

```text
dot_config/dotfiles/toolchains/android-install.sh
```

App/package config:

```text
dot_config/homebrew/brewfile
dot_config/ghostty/config
dot_config/jj/config.toml
dot_config/television/cable/files.toml
```

## Homebrew

Packages and apps are listed in:

```text
dot_config/homebrew/brewfile
```

Install them manually with:

```sh
bash ~/.config/dotfiles/homebrew-install.sh
```

Or run `brew bundle` directly:

```sh
brew bundle --file ~/.config/homebrew/brewfile
```

## Local and private config

Secrets are intentionally kept outside this repository. The config sources these optional files when present:

```text
~/.secrets.sh
~/.firefox.sh
~/.local-dotfiles.sh
```

Use these for machine-specific or private values that should not be committed.
