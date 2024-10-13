
Script de Backup para Banco de Dados PostgreSQL

Este script realiza o backup de um banco de dados PostgreSQL e salva o arquivo com um nome baseado na data e hora atuais. Além disso, ele armazena o nome do arquivo de backup mais recente em um arquivo de texto para ser utilizado posteriormente no processo de restauração.

Pré-requisitos

Antes de utilizar o script, certifique-se de que o seguinte está configurado corretamente:

- PostgreSQL instalado e em execução na máquina onde o backup será realizado.
- O pg_dump deve estar disponível (vem com a instalação do PostgreSQL).
- Acesso ao banco de dados PostgreSQL com as permissões necessárias para realizar o backup.

Variáveis Utilizadas

- DB_NAME: Nome do banco de dados a ser feito o backup (neste caso, usuarios).
- PGPASSWORD: Senha do usuário do PostgreSQL, definida temporariamente como variável de ambiente.

Estrutura do Script

1. Nome do Banco de Dados
O nome do banco de dados é definido com a variável DB_NAME. Por padrão, o banco de dados alvo é o banco usuarios:

DB_NAME="usuarios"

2. Definir o Nome do Arquivo de Backup
O nome do arquivo de backup será gerado automaticamente com base no nome do banco e na data/hora atuais:

BACKUP_FILE="backup_${DB_NAME}_$(date +%Y%m%d_%H%M%S).sql"

3. Definir a Senha do PostgreSQL
A senha para o usuário PostgreSQL é temporariamente definida como uma variável de ambiente para facilitar a execução do comando pg_dump:


Nota: Para questões de segurança, recomenda-se não deixar a senha exposta diretamente no código.

4. Criar o Backup
O comando pg_dump é utilizado para criar o backup do banco de dados, conectando-se via TCP/IP na máquina local (127.0.0.1):

pg_dump -h 127.0.0.1 -U lima -d "$DB_NAME" -f "$BACKUP_FILE"

Após a execução bem-sucedida, o script exibe uma mensagem com o nome do arquivo de backup gerado.

5. Armazenar o Nome do Último Backup
O nome do arquivo de backup mais recente é salvo no arquivo ultimo_backup.txt para referência futura, como no processo de restauração:

echo "$BACKUP_FILE" > ultimo_backup.txt

Como Usar

1. Executar o Script de Backup

1. Clone o repositório (se aplicável) ou baixe o script.
2. Garanta que o script tem permissão de execução:

    chmod +x backup.sh

3. Execute o script de backup:

    ./backup.sh

O arquivo de backup será gerado no diretório onde o script foi executado, e o nome do último backup será salvo no arquivo ultimo_backup.txt.

2. Restaurar o Backup

Para restaurar o backup criado, você pode utilizar um script de restauração separado (como restore.sh), que lê o nome do último backup salvo no arquivo ultimo_backup.txt e o utiliza no comando de restauração do PostgreSQL.

Observações

- Modifique as variáveis conforme necessário, como o nome do banco de dados, o host ou a senha.
- É recomendável configurar uma política de segurança adequada para proteger a senha do banco de dados.
