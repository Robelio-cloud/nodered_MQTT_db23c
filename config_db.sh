#!/bin/bash

echo "*** Ajustando permissões do tnsnames.ora ***"
chmod 666 /opt/oracle/product/23c/dbhomeFree/network/admin/tnsnames.ora

echo "*** Copiando libclntsh.so para instantclient ***"
mkdir -p /opt/oracle/product/23c/dbhomeFree/instantclient
cp /opt/oracle/product/23c/dbhomeFree/lib/libclntsh.so /opt/oracle/product/23c/dbhomeFree/instantclient/

echo "*** Baixando createuser.sql ***"
sudo -u oracle wget -O /home/oracle/createuser.sql https://raw.githubusercontent.com/Robelio-cloud/nodered_MQTT_db23c/main/createuser.sql
chown oracle:oinstall /home/oracle/createuser.sql

echo "*** Executando script SQL como oracle ***"
sudo -u oracle bash -c '
export ORACLE_SID=FREE
export ORAENV_ASK=NO
. /opt/oracle/product/23c/dbhomeFree/bin/oraenv
sqlplus / as sysdba @/home/oracle/createuser.sql
'
