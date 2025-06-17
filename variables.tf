variable "compartment_ocid" {
  description = "OCID do compartimento onde a instância já está criada"
}

variable "instance_name" {
  description = "Nome da instância já criada"
}

variable "existing_instance_id" {
  description = "OCID da instância já criada pela parte 1"
  type        = string
}


variable "ssh_public_key_path" {
  description = "Caminho para a chave pública"
}

variable "ssh_private_key_path" {
  description = "Caminho para a chave privada"
}

variable "region" {
  description = "Região OCI"
}

variable "DB_PASS" {
  description = "Senha do SYSTEM e do PDBADMIN"
  default     = "Tiger$tr0ng2023"
}
