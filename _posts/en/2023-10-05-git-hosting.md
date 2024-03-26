---
layout: lab-post
title: Private git hosting on OpenBSD
lang: en
slug: git-hosting
meta:
  - name: OpenBSD
    description: v7.3
  - name: Gogs
    description: v0.13
  - name: Gitea
    description: v1.18.5
  - name: Git
    description: v2.40.0
---

- 2023-12-11: Added an alternative way to clone

For years, I have hosted my personal git repositories on a self-hosted Gogs server. While some minor gliches have persisted for some time, I lived with them until recently. After yet another 500 error during a `push`, I finally decided it was time to migrate to a more reliable platform.

I decided to try Gitea, which I hoped could bring some stability and the code search feature that I had longed desired.

Although I didn't use features like issues and merge requests, Migration is not easy, I managed to migrate most of my repositories with a modified version of [a migration script in Perl][migs]. Other repositories had to be migrated in very manual ways due to various errors from Gitea during the migration.

When I finally migrated all of them I found that some repositories on Gitea were empty while their originals on Gogs were not, These repositories were in the first migration batch that Gitea claimed had succeeded, I figured out the issues and successfully migrated those empty repositories.

At this point, my migration was fully completed, Gitea was working with all my previous repositories. However the false positives[^mast] that Gitea gave to me were unacceptable, which could have cost me data loss if I had believed them, for git forges, data integrity always comes first.

Finally, I destroied the Gitea instance that I had just migrated to, and migrated all the repositoried to an raw OpenBSD server via SSH, it's simple, effective and rock solid, here's how.

## Prerequisites

- Enable `sshd(8)`[^proto]
- Install `git` (`pkg_add git`)
- Setup `doas(1)` (check `doas.conf(5)`) or modify the commands to not use it

## Setup the server

### Create git user

Even if you are the only one who access the repositories, a separate user provides more security and isolation, which is usually desired.

```
# mkdir -p /home/git
# user add git
# chown -R git:git /home/git
```

### Restrict the user
`git-shell(1)` comes with `git(1)`, is a restricted login shell for git-only SSH access.

Make this the default shell of the git user:

```
# chsh git -s $(which git-shell)
```

Append the following to `/etc/ssh/sshd_config` to restrict certain SSH capabilities for the **git** user, ensuring that it cannot do potentially risky actions via SSH.

```
Match User git
	AllowAgentForwarding no
	AllowTcpForwarding no
	X11Forwarding no
	PermitTTY no
```


### Create a repository

```
doas -u git git init --bare /home/git/test.git
```

This initialize git config values so maintenance tasks will be scheduled for this repository.
```
doas -u git GIT_DIR=/home/git/test.git git maintanence register
```

The result is in `/home/git/.gitconfig`:

```
[maintenance]
	repo = /home/git/test.git
```

### Start maintenance tasks

Run this once so the periodical maintanence tasks could be installed as cronjobs

```
# doas -u git GIT_DIR=/home/git/test.git git maintanence start
```

Check the tasks with:

```
# doas -u git crontab -l
```

They will look like this:

```
# BEGIN GIT MAINTENANCE SCHEDULE
# The following schedule was created by Git
# Any edits made in this region might be
# replaced in the future by a Git command.

0 1-23 * * * "/usr/local/libexec/git/git" --exec-path="/usr/local/libexec/git" for-each-repo --config=maintenance.repo maintenance run --schedule=hourly
0 0 * * 1-6 "/usr/local/libexec/git/git" --exec-path="/usr/local/libexec/git" for-each-repo --config=maintenance.repo maintenance run --schedule=daily
0 0 * * 0 "/usr/local/libexec/git/git" --exec-path="/usr/local/libexec/git" for-each-repo --config=maintenance.repo maintenance run --schedule=weekly

# END GIT MAINTENANCE SCHEDULE
```

## On the client side
Clone the repository

```
# git clone git@your.domain:test.git
```

For a repository under `/home/git/folder/repo.git`

```
# git clone git@your.domain:folder/repo.git
```

**Note**: This is a scp-like syntax, so no `ssh://`.

or 

```
# git clone ssh://git@your.domain:/~/folder/repo.git
```

You know the rest


## Going futher

- Setup backup for `/home/git` if you haven't already
- Create custom scripts[^sc] under `/home/git/git-shell-commands` for common tasks like repository CRUD
- Setup `git-daemon(1)` if you need public access, or `gitweb(1)`, [cgit][cgit] for a web UI


[^mast]: https://mastodon.tevinzhang.com/@tevin/111129696403308201
[^proto]: [Git official documentation had changed the recommended protocol multiple times, alternating between SSH and HTTPS][pt]. To me SSH is easier to setup, more secure and performant.
[^sc]: I currently have `help`, `add_key`, `ls`, `mkrepo`(with maintenance task registration) and `rm` (on top of `trash(1)`)

[pt]: https://web.archive.org/web/20230601051850/https://phoenixnap.com/kb/git-ssh-vs-https
[cgit]: https://git.zx2c4.com/cgit/
[migs]: https://github.com/Martchus/gogs2gitea/blob/3660f9dfc6fda004889be3c8ec819c2d23fa761e/gogs2gitea