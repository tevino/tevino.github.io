---
layout: lab-post
title: 在OpenBSD上进行私有Git托管
lang: zh
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
machine_translated: true
---

- 2023-12-11: 添加了第二种 clone 方式

多年来，我一直在自托管的Gogs服务器上托管我的个人Git仓库。尽管一些小问题一直存在，但我一直忍受着，直到最近。在再次 `push` 时发生了500错误后，我终于决定是时候迁移到一个更可靠的平台了。

我决定尝试Gitea，希望它能带来一些稳定性以及我一直渴望的代码搜索功能。

虽然我没有使用像问题和合并请求等功能，但迁移并不容易，我设法使用[一个修改版本的 Perl 迁移脚本][migs]成功迁移了大多数仓库。由于在迁移过程中Gitea出现了各种错误，其他仓库必须以非常手动的方式迁移。

当我最终迁移了所有仓库时，我发现Gitea上的一些仓库是空的，而它们在Gogs上的原始仓库不是空的。这些仓库是第一批迁移，Gitea声称已成功迁移，我找出了问题并成功迁移了那些空的仓库。

此时，我的迁移已完全完成，Gitea正与我以前的所有仓库一起工作。然而，Gitea给我的虚假阳性[^mast]是不可接受的，如果我相信了它们，可能会导致数据丢失，对于Git仓库，数据完整性始终是第一位的。

最后，我销毁了刚刚迁移到的Gitea实例，并将所有仓库通过SSH迁移到了一个原始的OpenBSD服务器上，这简单、有效且非常稳定，下面是具体步骤。

## 先决条件

- 启用 `sshd(8)`[^proto]
- 安装 `git` (`pkg_add git`)
- 设置 `doas(1)`（查看 `doas.conf(5)`）或修改命令以不使用它

## 配置服务器

### 创建git用户

即使您是唯一访问这些仓库的人，也提供了更多的安全性和隔离，通常是需要的。

```
# mkdir -p /home/git
# user add git
# chown -R git:git /home/git
```

### 限制用户
`git-shell(1)` 随 `git(1)` 一起提供，是专门用于Git-Only SSH访问的受限登录Shell。

将这个Shell设置为git用户的默认Shell：

```
# chsh git -s $(which git-shell)
```

将以下内容添加到 `/etc/ssh/sshd_config` 以限制**git**用户的某些SSH功能，确保它不能通过SSH执行潜在的风险操作。


```
Match User git
	AllowAgentForwarding no
	AllowTcpForwarding no
	X11Forwarding no
	PermitTTY no
```


### 创建仓库

```
doas -u git git init --bare /home/git/test.git
```

这会初始化git配置，以便为该仓库计划定时维护任务。

```
doas -u git GIT_DIR=/home/git/test.git git maintanence register
```

结果保存在 `/home/git/.gitconfig`

```
[maintenance]
	repo = /home/git/test.git
```

### 启动定时维护任务

只需运行一次，在 cron 中安装定期维护任务

```
# doas -u git GIT_DIR=/home/git/test.git git maintanence start
```

使用以下命令查看添加的 cron 任务：

```
# doas -u git crontab -l
```

添加的任务大概长这样

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


## 在客户端

克隆仓库

```
# git clone git@your.domain:test.git
```

对于位于 `/home/git/folder/repo.git` 下的仓库


```
# git clone git@your.domain:folder/repo.git
```

**注意**: 这是一个类 scp 语法, 因此不用加 `ssh://`.

或者 

```
# git clone ssh://git@your.domain:/~/folder/repo.git
```

剩下的你知道了


## 下一步

- 如果还没有，请为 `/home/git` 设置备份
- 在 `/home/git/git-shell-commands` 下创建自定义脚本[^sc] 以执行常见的仓库操作，如CRUD
- 如果需要公共访问，或者需要Web UI，设置 `git-daemon(1)`，`giweb(1)`，[cgit][cgit]


[^mast]: https://mastodon.tevinzhang.com/@tevin/111129696403308201
[^proto]: [Git 官方文档在 SSH 和 HTTPS 之间多次反复变更了建议的协议][pt]. 对我而言，SSH 更容易配置， 更安全并且性能更高。
[^sc]: 我目前实现了 `help`，`add_key`，`ls`，`mkrepo`(包括维护任务的注册) 和 `rm` (基于 `trash(1)`)

[pt]: https://web.archive.org/web/20230601051850/https://phoenixnap.com/kb/git-ssh-vs-https
[cgit]: https://git.zx2c4.com/cgit/
[migs]: https://github.com/Martchus/gogs2gitea/blob/3660f9dfc6fda004889be3c8ec819c2d23fa761e/gogs2gitea