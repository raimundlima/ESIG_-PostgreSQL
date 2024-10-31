Backup de Bancos de Dados PostgreSQL
Este repositório contém um script Bash para realizar backups automáticos de bancos de dados PostgreSQL. O script conecta-se ao servidor PostgreSQL, lista todos os bancos de dados não-template e cria arquivos de backup para cada um deles.

Pré-requisitos
PostgreSQL instalado.
Acesso ao usuário PostgreSQL com permissões para fazer backups (neste caso, o usuário padrão postgres).
Como Usar
Clone o Repositório:

bash
Copiar código
git clone https://seu-repositorio.git
cd seu-repositorio
Configure o Script:

O script é configurado para usar o usuário postgres. Se necessário, altere a variável PGUSER no script para outro usuário com permissões de backup.

bash
Copiar código
PGUSER="seu_usuario"
Execute o Script:

Para executar o script, utilize o comando:

bash
Copiar código
chmod +x backup_script.sh
./backup_script.sh
O script irá:

Listar todos os bancos de dados que não são templates.
Criar um backup para cada banco de dados, salvando os arquivos no formato backup_<nome_do_banco>_<data_e_hora>.sql.
Armazenar o nome do arquivo de backup mais recente no arquivo ultimo_backup.txt para uso futuro.
Saída
Os backups serão salvos no diretório atual com o seguinte formato de nome:

Copiar código
backup_nome_do_banco_YYYYMMDD_HHMMSS.sql
Além disso, um arquivo ultimo_backup.txt será criado, contendo o nome do backup mais recente.
