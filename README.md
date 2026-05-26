# dotfiles

Personal macOS dotfiles managed as a bare Git repository.

## Install

This repo is intended to be checked out with the bare repository at `~/.dotfiles` and `$HOME` as the working tree.

Bootstrap with:

```sh
bash <(curl -fsSL https://raw.githubusercontent.com/segunfamisa/dotfiles/main/.config/dotfiles/install.sh)
```

Or run the steps manually:

```sh
git clone --bare https://github.com/segunfamisa/dotfiles.git "$HOME/.dotfiles"
/usr/bin/git --git-dir="$HOME/.dotfiles" --work-tree="$HOME" checkout
/usr/bin/git --git-dir="$HOME/.dotfiles" --work-tree="$HOME" config status.showUntrackedFiles no
```

After checkout, the install script is available at:

```sh
bash ~/.config/dotfiles/install.sh
```

If checkout conflicts with existing files, the install script backs them up to:

```text
~/.dotfiles-backup
```

## Usage

The shell config defines a `dotfiles` alias:

```sh
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

Common commands:

```sh
dotfiles status
dotfiles add ~/.zshrc
dotfiles commit -m "Update shell config"
dotfiles push
```

## Layout

Main shell entrypoint:

```text
.zshrc
```

Organized dotfiles config:

```text
.config/dotfiles/init.sh
.config/dotfiles/homebrew.sh
.config/dotfiles/tools.sh
.config/dotfiles/aliases.sh
.config/dotfiles/secrets.sh
.config/dotfiles/local.sh
.config/dotfiles/firefox.sh
.config/dotfiles/toolchains.sh
.config/dotfiles/toolchains/
```

Toolchain-specific setup lives in:

```text
.config/dotfiles/toolchains/android.sh
.config/dotfiles/toolchains/java.sh
.config/dotfiles/toolchains/node.sh
.config/dotfiles/toolchains/python.sh
.config/dotfiles/toolchains/ruby.sh
.config/dotfiles/toolchains/rust.sh
```

Toolchain installers live alongside the toolchain config:

```text
.config/dotfiles/toolchains/android-install.sh
```

App/package config:

```text
.config/homebrew/brewfile
.config/ghostty/config
.config/television/cable/files.toml
```

## Homebrew

Packages and apps are listed in:

```text
.config/homebrew/brewfile
```

Install them with:

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
