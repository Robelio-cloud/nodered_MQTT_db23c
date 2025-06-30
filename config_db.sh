#!/bin/bash

echo "*** Ajustando permissões do tnsnames.ora ***"
chmod 666 /opt/oracle/product/23c/dbhomeFree/network/admin/tnsnames.ora

echo "*** Copiando libclntsh.so para instantclient ***"
mkdir -p /opt/oracle/product/23c/dbhomeFree/instantclient
cp /opt/oracle/product/23c/dbhomeFree/lib/libclntsh.so /opt/oracle/product/23c/dbhomeFree/instantclient/

echo "*** Baixando createuser.sql ***"
sudo -u oracle wget -O /home/oracle/createuser.sql https://raw.githubusercontent.com/badr42/nodered_MQTT_db23c/main/createuser.sql
chown oracle:oinstall /home/oracle/createuser.sql

echo "*** Executando script SQL como oracle ***"
sudo -u oracle bash -c '
export ORACLE_HOME=/opt/oracle/product/23c/dbhomeFree
export ORACLE_SID=FREE
export ORACLE_BASE=/opt/oracle
export PATH=$ORACLE_HOME/bin:$PATH
export LD_LIBRARY_PATH=$ORACLE_HOME/lib:$LD_LIBRARY_PATH

echo "ORACLE_HOME: $ORACLE_HOME"
echo "ORACLE_SID: $ORACLE_SID"
echo "PATH: $PATH"

# Verificar se sqlplus existe
if [ -f "$ORACLE_HOME/bin/sqlplus" ]; then
    echo "sqlplus encontrado em $ORACLE_HOME/bin/sqlplus"
    $ORACLE_HOME/bin/sqlplus / as sysdba @/home/oracle/createuser.sql
else
    echo "ERRO: sqlplus não encontrado em $ORACLE_HOME/bin/sqlplus"
    echo "Listando conteúdo do diretório bin:"
    ls -la $ORACLE_HOME/bin/ | head -10
fi
'