#!/bin/bash

# Unzip oracle database installation files
unzip linux.x64_11gR2_database_1of2.zip
unzip linux.x64_11gR2_database_2of2.zip

mv database/ /u01/app/

cd /u01/app/database/
./runInstaller -silent -responseFile /home/oracle/install.rsp
