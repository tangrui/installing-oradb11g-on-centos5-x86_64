# 安装后配置

以下命令如无特别说明，均使用 root 账号运行。

## 修改 oratab 文件

打开 `/etc/oratab` 文件，找到 `ecma:/u01/app/oracle/product/11.2.0/dbhome_1:N`，将最后的 `N` 改成 `Y`。

## 向 oracle 账号的 .bash_profile 文件中添加脚本

打开 `/home/oracle/.bash_profile` 文件，在结尾添加以下内容：

```bash
ORACLE_SID=ecma
ORAENV_ASK=NO
. oraenv

export ORACLE_SID
export ORACLE_BASE
export ORACLE_HOME
```

## 配置 oracle 启动脚本

创建 `/etc/init.d/oracle` 文件，内容如下：

```bash
#!/bin/bash

# oracle: Start/Stop Oracle Database 11g R2
#
# chkconfig: 345 90 10
# description: The Oracle Database is an Object-Relational Database Management System.
#
# processname: oracle

. /etc/rc.d/init.d/functions

LOCKFILE=/var/lock/subsys/oracle
ORACLE_HOME=/u01/app/oracle/product/11.2.0/dbhome_1
ORACLE_USER=oracle

case "$1" in
'start')
   if [ -f $LOCKFILE ]; then
      echo $0 already running.
      exit 1
   fi
   echo -n $"Starting Oracle Database:"
   su - $ORACLE_USER -c "$ORACLE_HOME/bin/lsnrctl start"
   su - $ORACLE_USER -c "$ORACLE_HOME/bin/dbstart \$ORACLE_HOME"
   su - $ORACLE_USER -c "$ORACLE_HOME/bin/emctl start dbconsole"
   touch $LOCKFILE
   ;;
'stop')
   if [ ! -f $LOCKFILE ]; then
      echo $0 already stopping.
      exit 1
   fi
   echo -n $"Stopping Oracle Database:"
   su - $ORACLE_USER -c "$ORACLE_HOME/bin/lsnrctl stop"
   su - $ORACLE_USER -c "$ORACLE_HOME/bin/dbshut \$ORACLE_HOME"
   su - $ORACLE_USER -c "$ORACLE_HOME/bin/emctl stop dbconsole"
   rm -f $LOCKFILE
   ;;
'restart')
   $0 stop
   $0 start
   ;;
'status')
   if [ -f $LOCKFILE ]; then
      echo $0 started.
      else
      echo $0 stopped.
   fi
   ;;
*)
   echo "Usage: $0 [start|stop|status]"
   exit 1
esac

exit 0
```

保存文件后，执行以下命令：

```bash
chmod 755 /etc/init.d/oracle
chkconfig --add oracle
chkconfig oracle on
```

重启服务器后，数据库会自动启动。
