#!/bin/bash

# Nome do banco de dados
DB_NAME="usuarios"


# Definir nome do arquivo de backup com base na data e hora
BACKUP_FILE="backup_${DB_NAME}_$(date +%Y%m%d_%H%M%S).sql"

#Definir a senha do PostgreSQL numa variavel de ambiente
export PGPASSWORD="123456"

# Criar o backup usando TCP/IP
echo "Criando backup do banco de dados..."
pg_dump -h 127.0.0.1 -U lima -d "$DB_NAME" -f "$BACKUP_FILE"
echo "Backup criado: $BACKUP_FILE"

# Salvar o nome do arquivo de backup mais recente para usar no restore.sh
echo "$BACKUP_FILE" > ultimo_backup.txt


