---
layout: lab-post
title: Backup crontabs on Yunohost
lang: en
slug: backup-crontabs-on-yunohost
meta:
  - name: YunoHost
    description: |
        An operating system aiming for the simplest administration of a server, and therefore democratize self-hosting, while making sure it stays reliable, secure, ethical and lightweight.

        https://yunohost.org/en/whatsyunohost
  - name: borg
    description: |
        Deduplicating archiver with compression and encryption

        https://www.borgbackup.org

        The YunoHost application with the same name offers to extend YunoHost with an automated backup method.

        It's also what "The future default backup method integrated in YunoHost will be based on".
---


> YunoHost usually already knows what needs to be backed up. However, if you have made manual changes, such as installing an app outside of the YunoHost application system, you may want to extend YunoHost's mechanism to specify other files to be backed up.

I use borg as the backup method and after checking the archives (prefixed with `_auto_conf` and `_auto_data`) I found the crontab files are not included.

After reading the [official document][od], here's what I managed to do to backup them.

## Steps

Two hook files are all we need, this will work for backup methods other than borg too.

What will be included in the backup:

- `/var/spool/cron/crontabs` the `crontab -l` for **every* user
- The two hook files

Caution:

1. Do everything with **root**.
2. If you change the name of the hook files, adjust the file content accordinly.

### Create folders for hooks

```bash
mkdir -p /etc/yunohost/hooks.d/{backup,restore}
```

### Create the backup hook

`/etc/yunohost/hooks.d/backup/99-conf_custom`

<details><summary>Content</summary>

```bash
#!/bin/bash

# Source YNH helpers
source /usr/share/yunohost/helpers

ynh_restore_dest (){
    YNH_CWD="${YNH_BACKUP_DIR%/}/$1"
    cd "$YNH_CWD"
}


# Exit hook on subcommand error or unset variable
ynh_abort_if_errors

# Crontabs
ynh_restore_dest "conf/custom/crontabs"
ynh_restore_file "/var/spool/cron/crontabs"

# MISC (including this file)
ynh_restore_dest "conf/custom/misc"
ynh_restore_file "/etc/yunohost/hooks.d/backup/99-conf_custom"
ynh_restore_file "/etc/yunohost/hooks.d/restore/99-conf_custom"
```

</details>

### Create the restore hook

`/etc/yunohost/hooks.d/restore/99-conf_custom`

<details><summary>Content</summary>

```bash
#!/bin/bash

# Source YNH helpers
source /usr/share/yunohost/helpers

ynh_backup_dest (){
    YNH_CWD="${YNH_BACKUP_DIR%/}/$1"
    mkdir -p $YNH_CWD
    cd "$YNH_CWD"
}

# Exit hook on subcommand error or unset variable
ynh_abort_if_errors

# Crontabs
ynh_backup_dest "conf/custom/crontabs"
ynh_backup "/var/spool/cron/crontabs"

# MISC (including this file)
ynh_backup_dest "conf/custom/misc"
ynh_backup "/etc/yunohost/hooks.d/backup/99-conf_custom"
ynh_backup "/etc/yunohost/hooks.d/restore/99-conf_custom"
```

</details>

### Assign proper file permissions

This might not be necessary, but I did it just in case.

```bash
chmod 740 /etc/yunohost/hooks.d/{backup,restore}/99-conf_custom
```

### Fire up a backup to see if the hook works

For borg, to start a backup is as easy as `systemctl start borg`

The files will be included in the archive with the prefix `_auto_conf`, this will list the files in the `ARCHIVE_NAME`:

```bash
app=borg; BORG_PASSPHRASE="$(yunohost app setting $app passphrase)" BORG_RSH="ssh -i /root/.ssh/id_${app}_CHANGE_THIS -oStrictHostKeyChecking=yes " borg list "$(yunohost app setting $app repository)::ARCHIVE_NAME | grep crontabs"
```

[od]: https://web.archive.org/web/20230629205306/https://yunohost.org/en/backup/include_exclude_files
