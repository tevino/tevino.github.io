---
layout: lab-post
title: 在 Yunohost 上备份 crontabs
lang: zh
slug: backup-crontabs-on-yunohost
machine_translated: true
meta:
  - name: YunoHost
    description: |
        一个旨在实现服务器简单管理的操作系统，旨在民主化自托管，同时确保其可靠、安全、道德和轻量。

        https://yunohost.org/en/whatsyunohost
  - name: borg
    description: |
        具有压缩和加密功能的去重归档工具

        https://www.borgbackup.org

        与同名的YunoHost应用程序一起，提供了一种自动化备份方法，可扩展YunoHost。

        这也是“YunoHost中将成为默认备份方法的未来”。

---

> YunoHost通常已经知道需要备份什么。但是，如果您进行了手动更改，例如在YunoHost应用程序系统之外安装了应用程序，您可能希望扩展YunoHost的机制以指定其他要备份的文件。

我使用borg作为备份方法，并在检查归档（以 `_auto_conf` 和 `_auto_data` 为前缀）后发现crontab文件未包含在内。

阅读[官方文档][od]后，我成功备份了它们。

## 步骤

只需两个钩子文件，这对于除borg以外的备份方法也适用。

备份中将包括：

- `/var/spool/cron/crontabs` 所有用户的 `crontab -l`
- 两个钩子文件

注意：

1. 所有操作均以 **root** 用户执行。
2. 如果更改钩子文件的名称，请相应调整文件内容。

### 创建钩子文件夹

```bash
mkdir -p /etc/yunohost/hooks.d/{backup,restore}
```

### 创建备份钩子

`/etc/yunohost/hooks.d/backup/99-conf_custom`

<details><summary>内容</summary>

```bash
#!/bin/bash

# 引入YNH助手
source /usr/share/yunohost/helpers

ynh_restore_dest (){
    YNH_CWD="${YNH_BACKUP_DIR%/}/$1"
    cd "$YNH_CWD"
}


# 在子命令错误或未设置变量时退出钩子
ynh_abort_if_errors

# Crontabs
ynh_restore_dest "conf/custom/crontabs"
ynh_restore_file "/var/spool/cron/crontabs"

# 其他（包括此文件）
ynh_restore_dest "conf/custom/misc"
ynh_restore_file "/etc/yunohost/hooks.d/backup/99-conf_custom"
ynh_restore_file "/etc/yunohost/hooks.d/restore/99-conf_custom"
```

</details>

### 创建还原钩子

`/etc/yunohost/hooks.d/restore/99-conf_custom`

<details><summary>内容</summary>

```bash
#!/bin/bash

# 引入YNH助手
source /usr/share/yunohost/helpers

ynh_backup_dest (){
    YNH_CWD="${YNH_BACKUP_DIR%/}/$1"
    mkdir -p $YNH_CWD
    cd "$YNH_CWD"
}

# 在子命令错误或未设置变量时退出钩子
ynh_abort_if_errors

# Crontabs
ynh_backup_dest "conf/custom/crontabs"
ynh_backup "/var/spool/cron/crontabs"

# 其他（包括此文件）
ynh_backup_dest "conf/custom/misc"
ynh_backup "/etc/yunohost/hooks.d/backup/99-conf_custom"
ynh_backup "/etc/yunohost/hooks.d/restore/99-conf_custom"
```

</details>

### 分配适当的文件权限

这可能是不必要的，但我为了安全起见执行了这些操作。

```bash
chmod 740 /etc/yunohost/hooks.d/{backup,restore}/99-conf_custom
```

### 启动备份以查看钩子是否有效

对于 borg 来说，启动备份只需要简单执行 `systemctl start borg`

这些文件将包含在 `_auto_conf` 前缀的归档中，这将列出 `ARCHIVE_NAME` 中的文件：

```bash
app=borg; BORG_PASSPHRASE="$(yunohost app setting $app passphrase)" BORG_RSH="ssh -i /root/.ssh/id_${app}_CHANGE_THIS -oStrictHostKeyChecking=yes " borg list "$(yunohost app setting $app repository)::ARCHIVE_NAME | grep crontabs"
```

[od]: https://web.archive.org/web/20230629205306/https://yunohost.org/en/backup/include_exclude_files
