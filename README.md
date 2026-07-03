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

Initialize this repo, set local machine data, then apply:

```sh
chezmoi init https://github.com/segunfamisa/dotfiles.git
chezmoi edit-config
chezmoi apply
```

The local chezmoi config must include an email address used by templated config such as Jujutsu:

```toml
[data]
email = "you@example.com"
```

For example, personal and work machines can use different local values without committing them to this repo.

During `chezmoi apply`, chezmoi also runs the managed Android tooling install script. Homebrew package installation is optional and can be run manually.

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
dot_config/jj/config.toml.tmpl    -> ~/.config/jj/config.toml
dot_config/jjui/config.toml.tmpl  -> ~/.config/jjui/config.toml
dot_config/ghostty/config.tmpl    -> ~/.config/ghostty/config
dot_config/zellij/config.kdl.tmpl -> ~/.config/zellij/config.kdl
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
dot_config/ghostty/config.tmpl
dot_config/jj/config.toml.tmpl
dot_config/jjui/config.toml.tmpl
dot_config/jjui/themes/
dot_config/zellij/config.kdl.tmpl
dot_config/zellij/themes/
dot_config/television/cable/files.toml
```

The Ghostty, jjui and Zellij configs are chezmoi templates that pick their
colour theme from `data.theme` (`tokyonight` by default, or `catppuccin`).
Each app still auto-switches between its light and dark variant based on the
terminal's reported colour scheme. See "Local and private config" for how to
set the theme.

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

Secrets and machine-specific values are intentionally kept outside this repository.

Required local chezmoi data:

```toml
[data]
email = "you@example.com"
```

Optional local chezmoi data:

```toml
[data]
# Colour theme shared by Ghostty, jjui and Zellij.
# Each app auto-switches its light/dark variant to match the terminal.
# Supported values: "tokyonight" (default), "catppuccin".
theme = "catppuccin"
```

Set these with:

```sh
chezmoi edit-config
```

The shell config also sources these optional files when present:

```text
~/.secrets.sh
~/.firefox.sh
~/.local-dotfiles.sh
```

Use these for machine-specific or private values that should not be committed.
