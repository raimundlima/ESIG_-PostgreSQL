#!/bin/bash

PGUSER="postgres"  # Usuário com permissões para fazer backup

# Função para listar bancos de dados e fazer backup
backup_dbs() {
    # Listar todos os bancos de dados
    DB_LIST=$(psql -U "$PGUSER" -d postgres -tAc "SELECT datname FROM pg_database WHERE datistemplate = false;")

    for DB_NAME in $DB_LIST; do
        BACKUP_FILE="backup_${DB_NAME}_$(date +%Y%m%d_%H%M%S).sql"
        echo "Criando backup do banco de dados '$DB_NAME'..."
        pg_dump -h localhost -U "$PGUSER" -d "$DB_NAME" -f "$BACKUP_FILE"
        echo "Backup criado: $BACKUP_FILE"

        # Salvar o nome do arquivo de backup mais recente para usar no restore.sh
        echo "$BACKUP_FILE" >> ultimo_backup.txt
    done
}

# Executar o backup dos bancos de dados
backup_dbs

