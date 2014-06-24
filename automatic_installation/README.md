# 自动安装

为了能够更方便的安装 Oracle 数据库，这里提供了几个脚本文件，用来分别完成[安装前配置](../pre_installation_config/README.md)、无人值守[安装](../installing_oracle_database_11g/README.md)和[安装后配置](../post_installation_config/README.md)等操作。

**注意：**在执行这些脚本前，请先阅读相关章节的安装说明。

## 安装前配置

下载 [pre-config.sh](assets/pre-config.sh) 脚本。

使用 root 账号运行以下命令：

```bash
sh pre-config.sh
```

脚本运行时会要求输入两个参数：

* `Please enter hostname [localhost.localdomain]:` 在这里输入系统的 hostname（方括号里面的内容是脚本自动检测到的系统当前 hostname，如果正确的话可以直接按回车键确认，否则输入新的 hostname）；
* `Please enter ip address [10.10.10.100]:` 在这里输入系统的 IP 地址（方括号里面的内容是系统自动检测到的 IP 地址，如果正确的话可以直接按回车键确认，否则输入新的 IP 地址）。

该脚本主要完成下列工作：

1. 更改系统的 hostname 和本地域名解析
2. 更新系统
3. 添加 Oracle public yum 服务器，并安装 oracle-validated 软件包
4. 安装其他 Oracle 数据库安装过程中所需要用到的软件包
5. 创建安装 Oracle 数据库所需的目录，并修改权限
6. 修改 oracle 账号密码
7. 修改 oracle 账号 .bash_profile 配置文件

**注意：**执行完该脚本以后，请重启服务器。

## 安装

下载 [install.sh](assets/install.sh) 和 [install.rsp](assets/install.rsp) 文件，将其存放到 oracle 账号的 home 目录下。

从 Oralce 官方网站下载 x86_64 版本的 Database 11g 安装包，该安装包分为 file1 和 file2 两个文件，也都存放到 oracle 账号的 home 目录下。

根据实际安装环境的不同，修改 install.rsp 文件，主要修改内容如下：

1. 修改 ORACLE_HOSTNAME 参数
2. 修改 oracle.install.db.config.starterdb.globalDBName 参数
3. 修改 oracle.install.db.config.starterdb.SID 参数
4. 修改 oracle.install.db.config.starterdb.password.ALL 参数
5. 修改 oracle.install.db.config.starterdb.automatedBackup.ospwd 参数

使用 oracle 账号运行以下命令：

```bash
sh install.sh
```

该脚本主要完成下列工作：

1. 解压缩安装包
2. 将解压后的安装文件移动到 `/u01/app/` 目录下
3. 使用 install.rsp 文件，启动静默安装

安装过程会出现如下提示信息：

```
Starting Oracle Universal Installer...

Checking Temp space: must be greater than 120 MB.   Actual 17990 MB     Passed
Checking swap space: must be greater than 150 MB.   Actual 3999 MB      Passed
Preparing to launch Oracle Universal Installer from /tmp/OraInstall2014-06-24_09-54-59AM. Please wait ...[oracle@orcl ~]$ You can find the log of this install session at:
 /u01/app/oraInventory/logs/installActions2014-06-24_09-54-59AM.log
```

如果想查看安装过程的详细日志，按照上面的提示，在新窗口中运行：

```
tail -f /u01/app/oraInventory/logs/installActions2014-06-24_09-54-59AM.log
```

等待安装完成，出现如下提示信息，说明安装成功：

```
The following configuration scripts need to be executed as the "root" user.
 #!/bin/sh
 #Root scripts to run

/u01/app/oraInventory/orainstRoot.sh
/u01/app/oracle/product/11.2.0/dbhome_1/root.sh
To execute the configuration scripts:
    1. Open a terminal window
    2. Log in as "root"
    3. Run the scripts
    4. Return to this window and hit "Enter" key to continue

Successfully Setup Software.
```

然后切换至 root 账号，按照上面提示的说明执行以下两个脚本：

```
/u01/app/oraInventory/orainstRoot.sh
/u01/app/oracle/product/11.2.0/dbhome_1/root.sh
```

## 安装后配置

下载 [post-config.sh](assets/post-config.sh) 脚本。

根据安装的实际情况，修改此脚本中 ORACLE\_SID 和 ORACLE\_HOME 两个变量的值，然后使用 root 账号执行以下命令：

```bash
sh post-config.sh
```

重新启动服务器，Oracle Database 11g 会自动启动，至此全部安装完成。

