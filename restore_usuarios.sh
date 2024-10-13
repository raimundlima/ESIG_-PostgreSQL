#!/bin/bash

# Nome do banco de dados
DB_NAME="usuarios"

# Usuário do PostgreSQL
DB_USER="lima"

# Host do servidor PostgreSQL
DB_HOST="localhost"

# Lê o nome do arquivo de backup do arquivo 'ultimo_backup.txt'
BACKUP_FILE=$(cat ultimo_backup.txt)

# Verificar se o arquivo de backup existe
if [ ! -f "$BACKUP_FILE" ]; then
    echo "Arquivo de backup '$BACKUP_FILE' não encontrado. Restauração não pode ser realizada."
    exit 1
fi

# Definindo a senha do PostgreSQL
export PGPASSWORD="123456"

# Conectar ao banco de dados e excluir todas as tabelas
echo "Excluindo todas as tabelas do banco de dados '$DB_NAME'..."
psql -U $DB_USER -h $DB_HOST -d $DB_NAME -c "DO \$\$ DECLARE r RECORD; BEGIN FOR r IN (SELECT tablename FROM pg_tables WHERE schemaname = 'public') LOOP EXECUTE 'DROP TABLE IF EXISTS public.' || quote_ident(r.tablename) || ' CASCADE'; END LOOP; END \$\$;"

# Restaurar o banco de dados usando o arquivo de backup
echo "Restaurando o banco de dados '$DB_NAME' a partir do backup: $BACKUP_FILE"
psql -U $DB_USER -h $DB_HOST -d $DB_NAME -f "$BACKUP_FILE"

echo "Restauração concluída com sucesso!"

