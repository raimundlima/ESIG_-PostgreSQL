#!/bin/bash

PGUSER="postgres"  # Usuário com permissões para restaurar
BACKUP_FILE="ultimo_backup.txt"

# Função para restaurar o banco de dados
restore_db() {
    # Ler o nome do arquivo de backup
    if [[ ! -f $BACKUP_FILE ]]; then
        echo "Arquivo de backup '$BACKUP_FILE' não encontrado."
        exit 1
    fi

    # Obter o último arquivo de backup
    LAST_BACKUP=$(cat "$BACKUP_FILE")
    DB_NAME=$(basename "$LAST_BACKUP" | cut -d'_' -f2-)

    # Verificar se o banco de dados existe
    DB_EXISTS=$(psql -U "$PGUSER" -d postgres -tAc "SELECT 1 FROM pg_database WHERE datname='$DB_NAME'")

    if [[ $DB_EXISTS ]]; then
        read -p "O banco de dados '$DB_NAME' já existe. Deseja excluí-lo e restaurar a partir do backup? (s/n): " CONFIRM
        if [[ $CONFIRM != "s" ]]; then
            echo "Restauração abortada."
            exit 0
        fi
        echo "Excluindo o banco de dados '$DB_NAME'..."
        dropdb -U "$PGUSER" "$DB_NAME"
    fi

    echo "Restaurando o banco de dados '$DB_NAME' a partir do backup '$LAST_BACKUP'..."
    createdb -U "$PGUSER" "$DB_NAME"
    psql -U "$PGUSER" -d "$DB_NAME" -f "$LAST_BACKUP"
    echo "Restauração concluída."
}

# Executar a restauração
restore_db

