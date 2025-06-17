# =========================
# main.tf (refatorado - Parte 2)
# =========================

data "oci_core_instance" "existing_instance" {
  instance_id = var.existing_instance_id
}


resource "null_resource" "install_software" {
  connection {
    type        = "ssh"
    host        = data.oci_core_instance.existing_instance.public_ip
    user        = "opc"
    private_key = file(var.ssh_private_key_path)
  }

  provisioner "remote-exec" {
    inline = [
      "wget -qO - 'https://raw.githubusercontent.com/badr42/nodered_MQTT_db23c/main/database.sh' | sudo bash",
      "wget -qO - 'https://raw.githubusercontent.com/badr42/nodered_MQTT_db23c/main/config_db.sh' | bash",
      "wget -qO - 'https://raw.githubusercontent.com/badr42/nodered_MQTT_db23c/main/install.sh' | bash"
    ]
  }
}

output "instance_public_ip" {
  value = <<EOF

  to connect to node-red server 
  http://${data.oci_core_instance.existing_instance.public_ip}:1880

  to connect to the database 

  ssh -i server.key opc@${data.oci_core_instance.existing_instance.public_ip}

  sudo su - oracle 

  # set the environment variables 
  export ORACLE_SID=FREE 
  export ORAENV_ASK=NO 
  . /opt/oracle/product/23c/dbhomeFree/bin/oraenv
  cd $ORACLE_HOME/bin
  lsnrctl status
  ./sqlplus / as sysdba

EOF
}

output "instance_ip" {
  value = data.oci_core_instance.existing_instance.public_ip
}

