# tse2mysql
Importa os dados eleitorais do TSE para um banco de dados MySQL

### Objetivo

Este projeto automatiza a tarefa de importação arquivos eleitorais do TSE, disponíveis no [Repositório de dados eleitorais](http://www.tse.jus.br/eleicoes/estatisticas/repositorio-de-dados-eleitorais/), para um banco de dados MySQL.

Os arquivos fornecidos pelo TSE estão no formato CSV. Planilhas possuem várias limitações e são difíceis para consultar e relacionar quando contém grande volume de dados, como é o caso dos arquivos fornecidos pelo TSE. O objetivo desse projeto é disponibilizar estes dados num banco de dados para poder consultar de forma mais fácil e rápida, além de permitir que estes dados sejam consumidos de forma mais apropriada por outras aplicações.

O processo de automatização incluí limpeza dos dados, conversão dos dados para os tipos apropriados e padronização.O formato dos arquivos e dos dados variam de um tipo de arquivo para outro e também variam de ano a ano.

### Requerimentos

* Sistema Operacional: Linux ou MacOS
* Acesso a um servidor de banco de dados MySQL (local ou remoto)
* Cliente do MySQL instalado

### Como utilizar

* Clonar o projeto;
* Alterar os arquivos de configuração de acordo com o ambiente onde será executado: database.env, directories.env e options.env;
* Rodar o script tse2mysql.sh passando o ano que deseja importar os dados, exemplo:

    ./tse2mysql.sh 2016
