# 安装前配置

在安装 Oracle Database 11g 之前需要对默认安装的 CentOS Linux 5 进行一些配置，以满足 Oracle Database 11g 的要求。

在未做特别说明的情况下，以下命令均以 root 账号执行。

## 更新系统

```bash
yum update -y
```

## 添加 Oracle public yum 服务器

```bash
wget https://public-yum.oracle.com/public-yum-el5.repo -O /etc/yum.repos.d/public-yum-el5.repo --no-check-certificate
```

因为 public-yum.oracle.com 这个服务器的安全证书有问题，所以添加 `--no-check-certificate` 参数以忽略安全证书检查。

## 添加 PGP 密钥

```bash
wget https://public-yum.oracle.com/RPM-GPG-KEY-oracle-el5 -O /etc/pki/rpm-gpg/RPM-GPG-KEY-oracle --no-check-certificate
```

## 安装 oracle-validated 软件包

```bash
yum install oracle-validated -y
```

该 RPM 软件包做了如下一些工作：

1. 下载并安装数据库安装过程需要用到的各种特定版本的软件包，以及经由 yum 或 up2date 解析而来的依赖包
2. 创建 oracle 账号，及 oinstall 和 dba 组
3. 在 `/etc/sysctl.conf` 文件中修改指定的内核参数，以变更共享内存（shared memory）、信号量（semaphores）及文件描述符的最大数量（maximum number of file descriptors）等配置
4. 在 `/etc/security/limits.conf` 中修改软、硬 shell 资源的限额，诸如锁定内存地址空间（locked-in memory address space）、打开文件数量（number of open files）、进程数量（number of processes）及核心文件数量（core file size）
5. 为 x86_64 的机器在内核中设置 `numa=off`

## 清理

```bash
rm /etc/yum.repos.d/public-yum-el5.repo
rm /etc/pki/rpm-gpg/RPM-GPG-KEY-oracle
```

删除这两个文件，用来确保以后使用 yum 更新系统的时候，不会发生软件包冲突的问题。

## 安装其它依赖包

```
yum install unixODBC-2.2.11 -y
yum install pdksh-5.2.14 -y
```

## 设置 HOSTNAME

修改 `/etc/sysconfig/network` 文件中的 `HOSTNAME` 参数，在本例中假设为 `orcl.example.com`，需要根据实际情况来更改。

```
HOSTNAME=orcl.example.com
```

## 修改 hosts 文件

修改 `/etc/hosts` 文件，为该域名添加本地解析。

```
10.10.10.100 orcl.example.com orcl
```

**注意：**这里的 IP 地址 `10.10.10.100` 只是为了编写文章的需要而假定的，在测试或生产环境部署的时候，要根据实际情况，把 IP 地址改为对应网卡的地址。

## 重启网络服务

```bash
/etc/init.d/network restart
```

## 创建并修改文件夹权限

```bash
mkdir -p /u01/app/oracle/
mkdir /u01/oradata/
mkdir /u01/fast_recovery_area/

chown -R oracle:oinstall /u01/
chmod -R 755 /u01/
```

## 为 oracle 账号设置密码

```bash
echo 'oracle' | passwd oracle --stdin
```

**注意：**这里将 oracle 账号的密码设置为 oracle，以方便后续操作。实际安装时应该使用更加复杂的密码。

## 编辑 oracle 账号的 bash 配置文件

打开 oracle 账号 home 目录下的 `.bash_profile` 文件，添加如下片段：

```bash
# Oracle Settings
umask 022

TMP=/tmp; export TMP
TMPDIR=$TMP; export TMPDIR
```

至此，安装前的准备工作完成。
