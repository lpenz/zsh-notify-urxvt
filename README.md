[![CI](https://github.com/lpenz/zsh-notify-urxvt/actions/workflows/ci.yml/badge.svg)](https://github.com/lpenz/zsh-notify-urxvt/actions/workflows/ci.yml)

zsh-notify-urxvt
================

Desktop notification for long-running commands in zsh
using [urxvt-ext-notify-osc](https://github.com/lpenz/urxvt-ext-notify-osc)

When a command takes more than 3s to run, this plugin triggers the notify-osc
urxvt perl extension, which shows a desktop notification and raises the urgency
hint of the window. This plugin works even on remote shells (no X forwarding
required) and under [tmux](https://github.com/tmux/tmux).

This is, in essence, a companion zsh plugin for [urxvt-ext-notify-osc](https://github.com/lpenz/urxvt-ext-notify-osc).


## Requirements

- [urxvt](http://software.schmorp.de/pkg/rxvt-unicode.html) ([rxvt-unicode](https://packages.debian.org/search?keywords=rxvt-unicode) in Debian)
- [urxvt-ext-notify-osc](https://github.com/lpenz/urxvt-ext-notify-osc)
- [xseturgent](https://github.com/lpenz/xseturgent) for the urgency hint
- notify-send (in [libnotify-bin](https://packages.debian.org/search?keywords=libnotify-bin) in Debian)


## Installation

Using zplug:

```shell
zplug "lpenz/zsh-notify-urxvt"
```

