#!/bin/bash

ORACLE_SID=ecma
ORACLE_HOME=/u01/app/oracle/product/11.2.0/dbhome_1

ORACLE_HOME_TEMP=$( echo $ORACLE_HOME | sed "s/\//\\\\\//g" )
sed -i "s/$ORACLE_SID:$ORACLE_HOME_TEMP:N/$ORACLE_SID:$ORACLE_HOME_TEMP:Y/g" /etc/oratab

# Append scripts to oracle account's .bash_profile
cat >> /home/oracle/.bash_profile << EOF
ORACLE_SID=ecma
ORAENV_ASK=NO
. oraenv

export ORACLE_SID
export ORACLE_BASE
export ORACLE_HOME

EOF

# Generate oradb init script
touch /etc/init.d/oracle
cat > /etc/init.d/oracle << EOF
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

case "\$1" in
'start')
   if [ -f \$LOCKFILE ]; then
      echo \$0 already running.
      exit 1
   fi
   echo -n $"Starting Oracle Database:"
   su - \$ORACLE_USER -c "\$ORACLE_HOME/bin/lsnrctl start"
   su - \$ORACLE_USER -c "\$ORACLE_HOME/bin/dbstart \$ORACLE_HOME"
   su - \$ORACLE_USER -c "\$ORACLE_HOME/bin/emctl start dbconsole"
   touch \$LOCKFILE
   ;;
'stop')
   if [ ! -f \$LOCKFILE ]; then
      echo \$0 already stopping.
      exit 1
   fi
   echo -n $"Stopping Oracle Database:"
   su - \$ORACLE_USER -c "\$ORACLE_HOME/bin/lsnrctl stop"
   su - \$ORACLE_USER -c "\$ORACLE_HOME/bin/dbshut \$ORACLE_HOME"
   su - \$ORACLE_USER -c "\$ORACLE_HOME/bin/emctl stop dbconsole"
   rm -f \$LOCKFILE
   ;;
'restart')
   \$0 stop
   \$0 start
   ;;
'status')
   if [ -f \$LOCKFILE ]; then
      echo \$0 started.
      else
      echo \$0 stopped.
   fi
   ;;
*)
   echo "Usage: \$0 [start|stop|status]"
   exit 1
esac

exit 0
EOF

chmod 755 /etc/init.d/oracle
chkconfig --add oracle
chkconfig oracle on

