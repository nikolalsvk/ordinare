# ordinare

[![Build Status](https://semaphoreci.com/api/v1/nikolalsvk/ordinare/branches/master/shields_badge.svg)](https://semaphoreci.com/nikolalsvk/ordinare)
[![Gem Version](https://badge.fury.io/rb/ordinare.svg)](https://badge.fury.io/rb/ordinare)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md#5-make-a-pull-request)

Ordinare sorts gems in your Gemfile alphabetically

![ordinare GIF](ordinare.gif)

In order to install the gem, do:

```
$ gem install ordinare
```

## Usage

Position yourself inside Rails project with Gemfile and do:

```
$ ordinare
```

You can find your ordered Gemfile at `Gemfile.ordinare` in the root of your
Rails project

## Advance usage

You can pass in path to your gemfile

```
$ ordinare --path my_awesome_project/Gemfile
```

You can find your ordered Gemfile at `my_awesome_project/Gemfile.ordinare`
