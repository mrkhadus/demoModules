provider "aws" {}

variable "source_vault_name" {
  type = string
}

variable "create_backup_vault" {
  type    = bool
  default = true
}

variable "create_backup_vault_policy" {
  type    = bool
  default = true
}

resource "aws_backup_vault" "source_vault" {
  name = var.source_vault_name
  count = var.create_backup_vault ? 1 : 0
}

resource "aws_backup_vault_policy" "demo" {
  backup_vault_name = aws_backup_vault.source_vault.name
  count = var.create_backup_vault_policy ? 1 : 0
  policy = jsonencode({
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "backup.amazonaws.com"
        },
        "Action": "backup:DeleteBackupVaultAccessPolicy",
        "Resource": "*"
      }
    ]
  })
  
}