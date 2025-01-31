provider "aws" {}

variable "source_vault_name" {
  type = string
}

resource "aws_backup_vault" "source_vault" {
  name = var.source_vault_name
}

resource "aws_backup_vault_policy" "demo" {
  backup_vault_name = aws_backup_vault.source_vault.name
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