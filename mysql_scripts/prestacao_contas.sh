YEAR="$1"
FILE="$2"
if [ "$DB_NAME" = "" ];then
   DB_NAME="$DB_NAME_PREFIX$YEAR"
fi
TABLE_NAME="vagas"

case $YEAR in
    2002|2004|2006|2008|2010|2012)
        END_LINE="\r\n"
        ;;
    2014|2016)
        END_LINE="\n"
        ;;
    *)
        END_LINE=""
        ;;
esac


despesas_candidatos_2016(){

    TABLE_NAME="despesas_candidatos"

    CREATE_TABLE_CMD=$(cat <<-END_CREATE_TABLE
        CREATE TABLE IF NOT EXISTS $TABLE_NAME (
            cod_eleicao int(11) DEFAULT NULL,
            desc_eleicao varchar(255) DEFAULT NULL,
            data_hora datetime DEFAULT NULL,
            cnpj_prestador_conta bigint(11) DEFAULT NULL,
            sequencial_candidato bigint(11) DEFAULT NULL,
            uf varchar(255) DEFAULT NULL,
            sigla_ue varchar(255) DEFAULT NULL,
            nome_ue varchar(255) DEFAULT NULL,
            sigla_partido varchar(255) DEFAULT NULL,
            numero_candidato int(11) DEFAULT NULL,
            cargo varchar(255) DEFAULT NULL,
            nome_candidato varchar(255) DEFAULT NULL,
            cpf_candidato varchar(255) DEFAULT NULL,
            cpf_vice_suplente varchar(255) DEFAULT NULL,
            tipo_documento varchar(255) DEFAULT NULL,
            numero_documento varchar(255) DEFAULT NULL,
            cpf_cnpj_fornecedor varchar(255) DEFAULT NULL,
            nome_fornecedor varchar(255) DEFAULT NULL,
            nome_fornecedor_receita_federal varchar(255) DEFAULT NULL,
            cod_setor_economico_doador varchar(255) DEFAULT NULL,
            setor_economico_fornecedor varchar(255) DEFAULT NULL,
            data_despesa datetime DEFAULT NULL,
            valor_despesa decimal(10,2) DEFAULT NULL,
            tipo_despesa varchar(255) DEFAULT NULL,
            descricao_despesa varchar(255) DEFAULT NULL
        );
END_CREATE_TABLE
    )

    LOAD_DATA_CMD=$(cat <<-END_LOAD_TABLE
        load data local infile "$FILE"
            into table $TABLE_NAME
            fields terminated by ';' OPTIONALLY ENCLOSED BY '"'
            lines terminated by "$END_LINE"
            ignore 1 lines
            (@cod_eleicao,
            @desc_eleicao,
            @data_hora,
            @cnpj_prestador_conta,
            @sequencial_candidato,
            @uf,
            @sigla_ue,
            @nome_ue,
            @sigla_partido,
            @numero_candidato,
            @cargo,
            @nome_candidato,
            @cpf_candidato,
            @cpf_vice_suplente,
            @tipo_documento,
            @numero_documento,
            @cpf_cnpj_fornecedor,
            @nome_fornecedor,
            @nome_fornecedor_receita_federal,
            @cod_setor_economico_doador,
            @setor_economico_fornecedor,
            @data_despesa,
            @valor_despesa,
            @tipo_despesa,
            @descricao_despesa)
        SET
            cod_eleicao=NULLIF(TRIM(@cod_eleicao),""),
            desc_eleicao=NULLIF(TRIM(@desc_eleicao),""),
            data_hora=STR_TO_DATE(NULLIF(TRIM(@data_hora),""),"%d/%m/%Y%H:%i:%s"),
            cnpj_prestador_conta=NULLIF(TRIM(@cnpj_prestador_conta),""),
            sequencial_candidato=NULLIF(TRIM(@sequencial_candidato),""),
            uf=NULLIF(TRIM(@uf),""),
            sigla_ue=NULLIF(TRIM(@sigla_ue),""),
            nome_ue=NULLIF(TRIM(@nome_ue),""),
            sigla_partido=NULLIF(TRIM(@sigla_partido),""),
            numero_candidato=NULLIF(TRIM(@numero_candidato),""),
            cargo=NULLIF(TRIM(@cargo),""),
            nome_candidato=NULLIF(TRIM(@nome_candidato),""),
            cpf_candidato=NULLIF(TRIM(@cpf_candidato),""),
            cpf_vice_suplente=NULLIF(TRIM(@cpf_vice_suplente),""),
            tipo_documento=NULLIF(TRIM(@tipo_documento),""),
            numero_documento=NULLIF(TRIM(@numero_documento),""),
            cpf_cnpj_fornecedor=NULLIF(TRIM(@cpf_cnpj_fornecedor),""),
            nome_fornecedor=NULLIF(TRIM(@nome_fornecedor),""),
            nome_fornecedor_receita_federal=NULLIF(TRIM(@nome_fornecedor_receita_federal),""),
            cod_setor_economico_doador=NULLIF(TRIM(@cod_setor_economico_doador),""),
            setor_economico_fornecedor=NULLIF(TRIM(@setor_economico_fornecedor),""),
            data_despesa=STR_TO_DATE(NULLIF(TRIM(@data_despesa),""),"%d/%m/%Y%H:%i:%s"),
            valor_despesa=CONVERT(REPLACE(REPLACE(NULLIF(TRIM(@valor_despesa),""), '.', ''), ',', '.'), DECIMAL(10,2)),
            tipo_despesa=NULLIF(TRIM(@tipo_despesa),""),
            descricao_despesa=NULLIF(TRIM(@descricao_despesa),"");
END_LOAD_TABLE
    )
}

despesas_candidatos_2014(){

    TABLE_NAME="despesas_candidatos"

    CREATE_TABLE_CMD=$(cat <<-END_CREATE_TABLE
        CREATE TABLE IF NOT EXISTS $TABLE_NAME (
            cod_eleicao int(11) DEFAULT NULL,
            desc_eleicao varchar(255) DEFAULT NULL,
            data_hora datetime DEFAULT NULL,
            cnpj_prestador_conta bigint(11) DEFAULT NULL,
            sequencial_candidato bigint(11) DEFAULT NULL,
            uf varchar(255) DEFAULT NULL,
            sigla_partido varchar(255) DEFAULT NULL,
            numero_candidato int(11) DEFAULT NULL,
            cargo varchar(255) DEFAULT NULL,
            nome_candidato varchar(255) DEFAULT NULL,
            cpf_candidato varchar(255) DEFAULT NULL,
            tipo_documento varchar(255) DEFAULT NULL,
            numero_documento varchar(255) DEFAULT NULL,
            cpf_cnpj_fornecedor varchar(255) DEFAULT NULL,
            nome_fornecedor varchar(255) DEFAULT NULL,
            nome_fornecedor_receita_federal varchar(255) DEFAULT NULL,
            cod_setor_economico_doador varchar(255) DEFAULT NULL,
            setor_economico_fornecedor varchar(255) DEFAULT NULL,
            data_despesa datetime DEFAULT NULL,
            valor_despesa decimal(10,2) DEFAULT NULL,
            tipo_despesa varchar(255) DEFAULT NULL,
            descricao_despesa varchar(255) DEFAULT NULL
        );
END_CREATE_TABLE
    )

    LOAD_DATA_CMD=$(cat <<-END_LOAD_TABLE
        load data local infile "$FILE"
            into table $TABLE_NAME
            fields terminated by ';' OPTIONALLY ENCLOSED BY '"'
            lines terminated by "$END_LINE"
            ignore 1 lines
            (@cod_eleicao,
            @desc_eleicao,
            @data_hora,
            @cnpj_prestador_conta,
            @sequencial_candidato,
            @uf,
            @sigla_partido,
            @numero_candidato,
            @cargo,
            @nome_candidato,
            @cpf_candidato,
            @tipo_documento,
            @numero_documento,
            @cpf_cnpj_fornecedor,
            @nome_fornecedor,
            @nome_fornecedor_receita_federal,
            @cod_setor_economico_doador,
            @setor_economico_fornecedor,
            @data_despesa,
            @valor_despesa,
            @tipo_despesa,
            @descricao_despesa)
        SET
            cod_eleicao=NULLIF(TRIM(@cod_eleicao),""),
            desc_eleicao=NULLIF(TRIM(@desc_eleicao),""),
            data_hora=STR_TO_DATE(NULLIF(TRIM(@data_hora),""),"%d/%m/%Y%H:%i:%s"),
            cnpj_prestador_conta=NULLIF(TRIM(@cnpj_prestador_conta),""),
            sequencial_candidato=NULLIF(TRIM(@sequencial_candidato),""),
            uf=NULLIF(TRIM(@uf),""),
            sigla_partido=NULLIF(TRIM(@sigla_partido),""),
            numero_candidato=NULLIF(TRIM(@numero_candidato),""),
            cargo=NULLIF(TRIM(@cargo),""),
            nome_candidato=NULLIF(TRIM(@nome_candidato),""),
            cpf_candidato=NULLIF(TRIM(@cpf_candidato),""),
            tipo_documento=NULLIF(TRIM(@tipo_documento),""),
            numero_documento=NULLIF(TRIM(@numero_documento),""),
            cpf_cnpj_fornecedor=NULLIF(TRIM(@cpf_cnpj_fornecedor),""),
            nome_fornecedor=NULLIF(TRIM(@nome_fornecedor),""),
            nome_fornecedor_receita_federal=NULLIF(TRIM(@nome_fornecedor_receita_federal),""),
            cod_setor_economico_doador=NULLIF(TRIM(@cod_setor_economico_doador),""),
            setor_economico_fornecedor=NULLIF(TRIM(@setor_economico_fornecedor),""),
            data_despesa=STR_TO_DATE(NULLIF(TRIM(@data_despesa),""),"%d/%m/%Y%H:%i:%s"),
            valor_despesa=CONVERT(REPLACE(REPLACE(NULLIF(TRIM(@valor_despesa),""), '.', ''), ',', '.'), DECIMAL(10,2)),
            tipo_despesa=NULLIF(TRIM(@tipo_despesa),""),
            descricao_despesa=NULLIF(TRIM(@descricao_despesa),"");
END_LOAD_TABLE
    )
}

despesas_candidatos_2012(){

    TABLE_NAME="despesas_candidatos"

    CREATE_TABLE_CMD=$(cat <<-END_CREATE_TABLE
        CREATE TABLE IF NOT EXISTS $TABLE_NAME (
            data_hora datetime DEFAULT NULL,
            sequencial_candidato bigint(11) DEFAULT NULL,
            uf varchar(255) DEFAULT NULL,
            numero_ue varchar(255) DEFAULT NULL,
            municipio varchar(255) DEFAULT NULL,
            sigla_partido varchar(255) DEFAULT NULL,
            numero_candidato int(11) DEFAULT NULL,
            cargo varchar(255) DEFAULT NULL,
            nome_candidato varchar(255) DEFAULT NULL,
            cpf_candidato varchar(255) DEFAULT NULL,
            tipo_documento varchar(255) DEFAULT NULL,
            numero_documento varchar(255) DEFAULT NULL,
            cpf_cnpj_fornecedor varchar(255) DEFAULT NULL,
            nome_fornecedor varchar(255) DEFAULT NULL,
            data_despesa datetime DEFAULT NULL,
            valor_despesa decimal(10,2) DEFAULT NULL,
            tipo_despesa varchar(255) DEFAULT NULL,
            descricao_despesa varchar(255) DEFAULT NULL
        );
END_CREATE_TABLE
    )

    LOAD_DATA_CMD=$(cat <<-END_LOAD_TABLE
        load data local infile "$FILE"
            into table $TABLE_NAME
            fields terminated by ';' OPTIONALLY ENCLOSED BY '"'
            lines terminated by "$END_LINE"
            ignore 1 lines
            (@data_hora,
            @sequencial_candidato,
            @uf,
            @numero_ue,
            @municipio,
            @sigla_partido,
            @numero_candidato,
            @cargo,
            @nome_candidato,
            @cpf_candidato,
            @tipo_documento,
            @numero_documento,
            @cpf_cnpj_fornecedor,
            @nome_fornecedor,
            @data_despesa,
            @valor_despesa,
            @tipo_despesa,
            @descricao_despesa)
        SET
            data_hora=STR_TO_DATE(NULLIF(TRIM(@data_hora),""),"%d/%m/%Y%H:%i:%s"),
            sequencial_candidato=NULLIF(TRIM(@sequencial_candidato),""),
            uf=NULLIF(TRIM(@uf),""),
            numero_ue=NULLIF(TRIM(@numero_ue),""),
            municipio=NULLIF(TRIM(@municipio),""),
            sigla_partido=NULLIF(TRIM(@sigla_partido),""),
            numero_candidato=NULLIF(TRIM(@numero_candidato),""),
            cargo=NULLIF(TRIM(@cargo),""),
            nome_candidato=NULLIF(TRIM(@nome_candidato),""),
            cpf_candidato=NULLIF(TRIM(@cpf_candidato),""),
            tipo_documento=NULLIF(TRIM(@tipo_documento),""),
            numero_documento=NULLIF(TRIM(@numero_documento),""),
            cpf_cnpj_fornecedor=NULLIF(TRIM(@cpf_cnpj_fornecedor),""),
            nome_fornecedor=NULLIF(TRIM(@nome_fornecedor),""),
            data_despesa=STR_TO_DATE(NULLIF(TRIM(@data_despesa),""),"%d/%m/%Y"),
            valor_despesa=CONVERT(REPLACE(REPLACE(NULLIF(TRIM(@valor_despesa),""), '.', ''), ',', '.'), DECIMAL(10,2)),
            tipo_despesa=NULLIF(TRIM(@tipo_despesa),""),
            descricao_despesa=NULLIF(TRIM(@descricao_despesa),"");
END_LOAD_TABLE
    )
}

despesas_comites_2014(){
    TABLE_NAME="despesas_comites"

    CREATE_TABLE_CMD=$(cat <<-END_CREATE_TABLE
    CREATE TABLE IF NOT EXISTS $TABLE_NAME (
        cod_eleicao int(11) DEFAULT NULL,
        desc_eleicao varchar(255) DEFAULT NULL,
        data_hora datetime DEFAULT NULL,
        cnpj_prestador_conta bigint(11) DEFAULT NULL,
        sequencial_comite int(11) DEFAULT NULL,
        uf varchar(255) DEFAULT NULL,
        tipo_comite varchar(255) DEFAULT NULL,
        sigla_partido varchar(255) DEFAULT NULL,
        tipo_documento varchar(255) DEFAULT NULL,
        numero_documento varchar(255) DEFAULT NULL,
        cpf_cnpj_fornecedor varchar(255) DEFAULT NULL,
        nome_fornecedor varchar(255) DEFAULT NULL,
        nome_fornecedor_receita_federal varchar(255) DEFAULT NULL,
        cod_setor_economico_doador varchar(255) DEFAULT NULL,
        setor_economico_fornecedor varchar(255) DEFAULT NULL,
        data_despesa datetime DEFAULT NULL,
        valor_despesa decimal(10,2) DEFAULT NULL,
        tipo_despesa varchar(255) DEFAULT NULL,
        descricao_despesa varchar(255) DEFAULT NULL
    );
END_CREATE_TABLE
    )

    LOAD_DATA_CMD=$(cat <<-END_LOAD_TABLE
    load data local infile "$FILE"
      into table $TABLE_NAME
        fields terminated by ';' OPTIONALLY ENCLOSED BY '"'
        lines terminated by "$END_LINE"
        ignore 1 lines
        (@cod_eleicao,
        @desc_eleicao,
        @data_hora,
        @cnpj_prestador_conta,
        @sequencial_comite,
        @uf,
        @tipo_comite,
        @sigla_partido,
        @tipo_documento,
        @numero_documento,
        @cpf_cnpj_fornecedor,
        @nome_fornecedor,
        @nome_fornecedor_receita_federal,
        @cod_setor_economico_doador,
        @setor_economico_fornecedor,
        @data_despesa,
        @valor_despesa,
        @tipo_despesa,
        @descricao_despesa)
    SET
        cod_eleicao=NULLIF(TRIM(@cod_eleicao),""),
        desc_eleicao=NULLIF(TRIM(@desc_eleicao),""),
        data_hora=STR_TO_DATE(NULLIF(TRIM(@data_hora),""),"%d/%m/%Y%H:%i:%s"),
        cnpj_prestador_conta=NULLIF(TRIM(@cnpj_prestador_conta),""),
        sequencial_comite=NULLIF(TRIM(@sequencial_comite),""),
        uf=NULLIF(TRIM(@uf),""),
        tipo_comite=NULLIF(TRIM(@tipo_comite),""),
        sigla_partido=NULLIF(TRIM(@sigla_partido),""),
        tipo_documento=NULLIF(TRIM(@tipo_documento),""),
        numero_documento=NULLIF(TRIM(@numero_documento),""),
        cpf_cnpj_fornecedor=NULLIF(TRIM(@cpf_cnpj_fornecedor),""),
        nome_fornecedor=NULLIF(TRIM(@nome_fornecedor),""),
        nome_fornecedor_receita_federal=NULLIF(TRIM(@nome_fornecedor_receita_federal),""),
        cod_setor_economico_doador=NULLIF(TRIM(@cod_setor_economico_doador),""),
        setor_economico_fornecedor=NULLIF(TRIM(@setor_economico_fornecedor),""),
        data_despesa=STR_TO_DATE(NULLIF(TRIM(@data_despesa),""),"%d/%m/%Y%H:%i:%s"),
        valor_despesa=CONVERT(REPLACE(REPLACE(NULLIF(TRIM(@valor_despesa),""), '.', ''), ',', '.'), DECIMAL(10,2)),
        tipo_despesa=NULLIF(TRIM(@tipo_despesa),""),
        descricao_despesa=NULLIF(TRIM(@descricao_despesa),"");
END_LOAD_TABLE
    )
}

despesas_comites_2012(){
    TABLE_NAME="despesas_comites"

    CREATE_TABLE_CMD=$(cat <<-END_CREATE_TABLE
    CREATE TABLE IF NOT EXISTS $TABLE_NAME (
        data_hora datetime DEFAULT NULL,
        sequencial_comite int(11) DEFAULT NULL,
        uf varchar(255) DEFAULT NULL,
        numero_ue varchar(255) DEFAULT NULL,
        municipio varchar(255) DEFAULT NULL,
        tipo_comite varchar(255) DEFAULT NULL,
        sigla_partido varchar(255) DEFAULT NULL,
        tipo_documento varchar(255) DEFAULT NULL,
        numero_documento varchar(255) DEFAULT NULL,
        cpf_cnpj_fornecedor varchar(255) DEFAULT NULL,
        nome_fornecedor varchar(255) DEFAULT NULL,
        data_despesa datetime DEFAULT NULL,
        valor_despesa decimal(10,2) DEFAULT NULL,
        tipo_despesa varchar(255) DEFAULT NULL,
        descricao_despesa varchar(255) DEFAULT NULL
    );
END_CREATE_TABLE
    )

    LOAD_DATA_CMD=$(cat <<-END_LOAD_TABLE
    load data local infile "$FILE"
      into table $TABLE_NAME
        fields terminated by ';' OPTIONALLY ENCLOSED BY '"'
        lines terminated by "$END_LINE"
        ignore 1 lines
        (@data_hora,
        @sequencial_comite,
        @uf,
        @numero_ue,
        @municipio,
        @tipo_comite,
        @sigla_partido,
        @tipo_documento,
        @numero_documento,
        @cpf_cnpj_fornecedor,
        @nome_fornecedor,
        @data_despesa,
        @valor_despesa,
        @tipo_despesa,
        @descricao_despesa)
    SET
        data_hora=STR_TO_DATE(NULLIF(TRIM(@data_hora),""),"%d/%m/%Y%H:%i:%s"),
        sequencial_comite=NULLIF(TRIM(@sequencial_comite),""),
        uf=NULLIF(TRIM(@uf),""),
        numero_ue=NULLIF(TRIM(@numero_ue),""),
        municipio=NULLIF(TRIM(@municipio),""),
        tipo_comite=NULLIF(TRIM(@tipo_comite),""),
        sigla_partido=NULLIF(TRIM(@sigla_partido),""),
        tipo_documento=NULLIF(TRIM(@tipo_documento),""),
        numero_documento=NULLIF(TRIM(@numero_documento),""),
        cpf_cnpj_fornecedor=NULLIF(TRIM(@cpf_cnpj_fornecedor),""),
        nome_fornecedor=NULLIF(TRIM(@nome_fornecedor),""),
        data_despesa=STR_TO_DATE(NULLIF(TRIM(@data_despesa),""),"%d/%m/%Y"),
        valor_despesa=CONVERT(REPLACE(REPLACE(NULLIF(TRIM(@valor_despesa),""), '.', ''), ',', '.'), DECIMAL(10,2)),
        tipo_despesa=NULLIF(TRIM(@tipo_despesa),""),
        descricao_despesa=NULLIF(TRIM(@descricao_despesa),"");
END_LOAD_TABLE
    )
}


despesas_partidos_2016(){
    TABLE_NAME="despesas_partidos"
    CREATE_TABLE_CMD=$(cat <<-END_CREATE_TABLE
        CREATE TABLE IF NOT EXISTS $TABLE_NAME (
            cod_eleicao int(11) DEFAULT NULL,
            desc_eleicao varchar(255) DEFAULT NULL,
            data_hora datetime DEFAULT NULL,
            cnpj_prestador_conta bigint(11) DEFAULT NULL,
            sequencial_prestador_conta int(11) DEFAULT NULL,
            uf varchar(255) DEFAULT NULL,
            sigla_ue varchar(255) DEFAULT NULL,
            nome_ue varchar(255) DEFAULT NULL,
            tipo_diretorio varchar(255) DEFAULT NULL,
            sigla_partido varchar(255) DEFAULT NULL,
            tipo_documento varchar(255) DEFAULT NULL,
            numero_documento varchar(255) DEFAULT NULL,
            cpf_cnpj_fornecedor varchar(255) DEFAULT NULL,
            nome_fornecedor varchar(255) DEFAULT NULL,
            nome_fornecedor_receita_federal varchar(255) DEFAULT NULL,
            cod_setor_economico_doador varchar(255) DEFAULT NULL,
            setor_economico_fornecedor varchar(255) DEFAULT NULL,
            data_despesa datetime DEFAULT NULL,
            valor_despesa decimal(10,2) DEFAULT NULL,
            tipo_despesa varchar(255) DEFAULT NULL,
            descricao_despesa varchar(255) DEFAULT NULL        );
END_CREATE_TABLE
    )

    LOAD_DATA_CMD=$(cat <<-END_LOAD_TABLE
        load data local infile "$FILE"
        into table $TABLE_NAME
            fields terminated by ';' OPTIONALLY ENCLOSED BY '"'
            lines terminated by "$END_LINE"
            ignore 1 lines
            (@cod_eleicao,
            @desc_eleicao,
            @data_hora,
            @cnpj_prestador_conta,
            @sequencial_prestador_conta,
            @uf,
            @sigla_ue,
            @nome_ue,
            @tipo_diretorio,
            @sigla_partido,
            @tipo_documento,
            @numero_documento,
            @cpf_cnpj_fornecedor,
            @nome_fornecedor,
            @nome_fornecedor_receita_federal,
            @cod_setor_economico_doador,
            @setor_economico_fornecedor,
            @data_despesa,
            @valor_despesa,
            @tipo_despesa,
            @descricao_despesa)
        SET
            cod_eleicao=NULLIF(TRIM(@cod_eleicao),""),
            desc_eleicao=NULLIF(TRIM(@desc_eleicao),""),
            data_hora=STR_TO_DATE(NULLIF(TRIM(@data_hora),""),"%d/%m/%Y%H:%i:%s"),
            cnpj_prestador_conta=NULLIF(TRIM(@cnpj_prestador_conta),""),
            sequencial_prestador_conta=NULLIF(TRIM(@sequencial_prestador_conta),""),
            uf=NULLIF(TRIM(@uf),""),
            sigla_ue=NULLIF(TRIM(@sigla_ue),""),
            nome_ue=NULLIF(TRIM(@nome_ue),""),
            tipo_diretorio=NULLIF(TRIM(@tipo_diretorio),""),
            sigla_partido=NULLIF(TRIM(@sigla_partido),""),
            tipo_documento=NULLIF(TRIM(@tipo_documento),""),
            numero_documento=NULLIF(TRIM(@numero_documento),""),
            cpf_cnpj_fornecedor=NULLIF(TRIM(@cpf_cnpj_fornecedor),""),
            nome_fornecedor=NULLIF(TRIM(@nome_fornecedor),""),
            nome_fornecedor_receita_federal=NULLIF(TRIM(@nome_fornecedor_receita_federal),""),
            cod_setor_economico_doador=NULLIF(TRIM(@cod_setor_economico_doador),""),
            setor_economico_fornecedor=NULLIF(TRIM(@setor_economico_fornecedor),""),
            data_despesa=STR_TO_DATE(NULLIF(TRIM(@data_despesa),""),"%d-%M-%y"),
            valor_despesa=CONVERT(REPLACE(REPLACE(NULLIF(TRIM(@valor_despesa),""), '.', ''), ',', '.'), DECIMAL(10,2)),
            tipo_despesa=NULLIF(TRIM(@tipo_despesa),""),
            descricao_despesa=NULLIF(TRIM(@descricao_despesa),"");
END_LOAD_TABLE
    )
}

despesas_partidos_2014(){
    TABLE_NAME="despesas_partidos"
    CREATE_TABLE_CMD=$(cat <<-END_CREATE_TABLE
        CREATE TABLE IF NOT EXISTS $TABLE_NAME (
            cod_eleicao int(11) DEFAULT NULL,
            desc_eleicao varchar(255) DEFAULT NULL,
            data_hora datetime DEFAULT NULL,
            cnpj_prestador_conta bigint(11) DEFAULT NULL,
            sequencial_diretorio int(11) DEFAULT NULL,
            uf varchar(255) DEFAULT NULL,
            tipo_diretorio varchar(255) DEFAULT NULL,
            sigla_partido varchar(255) DEFAULT NULL,
            tipo_documento varchar(255) DEFAULT NULL,
            numero_documento varchar(255) DEFAULT NULL,
            cpf_cnpj_fornecedor varchar(255) DEFAULT NULL,
            nome_fornecedor varchar(255) DEFAULT NULL,
            nome_fornecedor_receita_federal varchar(255) DEFAULT NULL,
            cod_setor_economico_doador varchar(255) DEFAULT NULL,
            setor_economico_fornecedor varchar(255) DEFAULT NULL,
            data_despesa datetime DEFAULT NULL,
            valor_despesa decimal(10,2) DEFAULT NULL,
            tipo_despesa varchar(255) DEFAULT NULL,
            descricao_despesa varchar(255) DEFAULT NULL
        );
END_CREATE_TABLE
    )

    LOAD_DATA_CMD=$(cat <<-END_LOAD_TABLE
        load data local infile "$FILE"
        into table $TABLE_NAME
            fields terminated by ';' OPTIONALLY ENCLOSED BY '"'
            lines terminated by "$END_LINE"
            ignore 1 lines
            (@cod_eleicao,
            @desc_eleicao,
            @data_hora,
            @cnpj_prestador_conta,
            @sequencial_diretorio,
            @uf,
            @tipo_diretorio,
            @sigla_partido,
            @tipo_documento,
            @numero_documento,
            @cpf_cnpj_fornecedor,
            @nome_fornecedor,
            @nome_fornecedor_receita_federal,
            @cod_setor_economico_doador,
            @setor_economico_fornecedor,
            @data_despesa,
            @valor_despesa,
            @tipo_despesa,
            @descricao_despesa)
        SET
            cod_eleicao=NULLIF(TRIM(@cod_eleicao),""),
            desc_eleicao=NULLIF(TRIM(@desc_eleicao),""),
            data_hora=STR_TO_DATE(NULLIF(TRIM(@data_hora),""),"%d/%m/%Y%H:%i:%s"),
            cnpj_prestador_conta=NULLIF(TRIM(@cnpj_prestador_conta),""),
            sequencial_diretorio=NULLIF(TRIM(@sequencial_diretorio),""),
            uf=NULLIF(TRIM(@uf),""),
            tipo_diretorio=NULLIF(TRIM(@tipo_diretorio),""),
            sigla_partido=NULLIF(TRIM(@sigla_partido),""),
            tipo_documento=NULLIF(TRIM(@tipo_documento),""),
            numero_documento=NULLIF(TRIM(@numero_documento),""),
            cpf_cnpj_fornecedor=NULLIF(TRIM(@cpf_cnpj_fornecedor),""),
            nome_fornecedor=NULLIF(TRIM(@nome_fornecedor),""),
            nome_fornecedor_receita_federal=NULLIF(TRIM(@nome_fornecedor_receita_federal),""),
            cod_setor_economico_doador=NULLIF(TRIM(@cod_setor_economico_doador),""),
            setor_economico_fornecedor=NULLIF(TRIM(@setor_economico_fornecedor),""),
            data_despesa=STR_TO_DATE(NULLIF(TRIM(@data_despesa),""),"%d-%M-%y"),
            valor_despesa=CONVERT(REPLACE(REPLACE(NULLIF(TRIM(@valor_despesa),""), '.', ''), ',', '.'), DECIMAL(10,2)),
            tipo_despesa=NULLIF(TRIM(@tipo_despesa),""),
            descricao_despesa=NULLIF(TRIM(@descricao_despesa),"");
END_LOAD_TABLE
    )
}

despesas_partidos_2012(){
    TABLE_NAME="despesas_partidos"
    CREATE_TABLE_CMD=$(cat <<-END_CREATE_TABLE
        CREATE TABLE IF NOT EXISTS $TABLE_NAME (
            data_hora datetime DEFAULT NULL,
            sequencial_diretorio int(11) DEFAULT NULL,
            uf varchar(255) DEFAULT NULL,
            numero_ue varchar(255) DEFAULT NULL,
            municipio varchar(255) DEFAULT NULL,
            tipo_diretorio varchar(255) DEFAULT NULL,
            sigla_partido varchar(255) DEFAULT NULL,
            tipo_documento varchar(255) DEFAULT NULL,
            numero_documento varchar(255) DEFAULT NULL,
            cpf_cnpj_fornecedor varchar(255) DEFAULT NULL,
            nome_fornecedor varchar(255) DEFAULT NULL,
            data_despesa datetime DEFAULT NULL,
            valor_despesa decimal(10,2) DEFAULT NULL,
            tipo_despesa varchar(255) DEFAULT NULL,
            descricao_despesa varchar(255) DEFAULT NULL
        );
END_CREATE_TABLE
    )

    LOAD_DATA_CMD=$(cat <<-END_LOAD_TABLE
        load data local infile "$FILE"
        into table $TABLE_NAME
            fields terminated by ';' OPTIONALLY ENCLOSED BY '"'
            lines terminated by "$END_LINE"
            ignore 1 lines
            (@data_hora,
            @sequencial_diretorio,
            @uf,
            @numero_ue,
            @municipio,
            @tipo_diretorio,
            @sigla_partido,
            @tipo_documento,
            @numero_documento,
            @cpf_cnpj_fornecedor,
            @nome_fornecedor,
            @data_despesa,
            @valor_despesa,
            @tipo_despesa,
            @descricao_despesa)
        SET
            data_hora=STR_TO_DATE(NULLIF(TRIM(@data_hora),""),"%d/%m/%Y%H:%i:%s"),
            sequencial_diretorio=NULLIF(TRIM(@sequencial_diretorio),""),
            uf=NULLIF(TRIM(@uf),""),
            numero_ue=NULLIF(TRIM(@numero_ue),""),
            municipio=NULLIF(TRIM(@municipio),""),
            tipo_diretorio=NULLIF(TRIM(@tipo_diretorio),""),
            sigla_partido=NULLIF(TRIM(@sigla_partido),""),
            tipo_documento=NULLIF(TRIM(@tipo_documento),""),
            numero_documento=NULLIF(TRIM(@numero_documento),""),
            cpf_cnpj_fornecedor=NULLIF(TRIM(@cpf_cnpj_fornecedor),""),
            nome_fornecedor=NULLIF(TRIM(@nome_fornecedor),""),
            data_despesa=STR_TO_DATE(NULLIF(TRIM(@data_despesa),""),"%d/%m/%Y"),
            valor_despesa=CONVERT(REPLACE(REPLACE(NULLIF(TRIM(@valor_despesa),""), '.', ''), ',', '.'), DECIMAL(10,2)),
            tipo_despesa=NULLIF(TRIM(@tipo_despesa),""),
            descricao_despesa=NULLIF(TRIM(@descricao_despesa),"");
END_LOAD_TABLE
    )
}

receitas_candidatos_2016(){
    TABLE_NAME="receitas_candidatos"

    CREATE_TABLE_CMD=$(cat <<-END_CREATE_TABLE
    CREATE TABLE IF NOT EXISTS $TABLE_NAME (
        cod_eleicao int(11) DEFAULT NULL,
        desc_eleicao varchar(255) DEFAULT NULL,
        data_hora datetime DEFAULT NULL,
        cnpj_prestador_conta bigint(11) DEFAULT NULL,
        sequencial_candidato bigint(11) DEFAULT NULL,
        uf varchar(255) DEFAULT NULL,
        sigla_ue varchar(255) DEFAULT NULL,
        nome_ue varchar(255) DEFAULT NULL,
        sigla_partido varchar(255) DEFAULT NULL,
        numero_candidato int(11) DEFAULT NULL,
        cargo varchar(255) DEFAULT NULL,
        nome_candidato varchar(255) DEFAULT NULL,
        cpf_candidato varchar(255) DEFAULT NULL,
        cpf_vice_suplente varchar(255) DEFAULT NULL,
        numero_recibo_eleitoral varchar(255) DEFAULT NULL,
        numero_documento varchar(255) DEFAULT NULL,
        cpf_cnpj_doador varchar(255) DEFAULT NULL,
        nome_doador varchar(255) DEFAULT NULL,
        nome_doador_receita_federal varchar(255) DEFAULT NULL,
        sigla_ue_doador varchar(255) DEFAULT NULL,
        numero_partido_doador int(11) DEFAULT NULL,
        numero_candidato_doador int(11) DEFAULT NULL,
        cod_setor_economico_doador varchar(255) DEFAULT NULL,
        setor_economico_doador varchar(255) DEFAULT NULL,
        data_receita datetime DEFAULT NULL,
        valor_receita decimal(10,2) DEFAULT NULL,
        tipo_receita varchar(255) DEFAULT NULL,
        fonte_recurso varchar(255) DEFAULT NULL,
        especie_recurso varchar(255) DEFAULT NULL,
        descricao_receita varchar(255) DEFAULT NULL,
        cpf_cnpj_doador_originario varchar(255) DEFAULT NULL,
        nome_doador_originario varchar(255) DEFAULT NULL,
        tipo_doador_originario varchar(255) DEFAULT NULL,
        setor_economico_doador_originario varchar(255) DEFAULT NULL,
        nome_doador_originario_receita_federal varchar(255) DEFAULT NULL
    );
END_CREATE_TABLE
    )

    LOAD_DATA_CMD=$(cat <<-END_LOAD_TABLE
    load data local infile "$FILE"
      into table $TABLE_NAME
        fields terminated by ';' OPTIONALLY ENCLOSED BY '"'
        lines terminated by "$END_LINE"
        ignore 1 lines
        (@cod_eleicao,
        @desc_eleicao,
        @data_hora,
        @cnpj_prestador_conta,
        @sequencial_candidato,
        @uf,
        @sigla_ue,
        @nome_ue,
        @sigla_partido,
        @numero_candidato,
        @cargo,
        @nome_candidato,
        @cpf_candidato,
        @cpf_vice_suplente,
        @numero_recibo_eleitoral,
        @numero_documento,
        @cpf_cnpj_doador,
        @nome_doador,
        @nome_doador_receita_federal,
        @sigla_ue_doador,
        @numero_partido_doador,
        @numero_candidato_doador,
        @cod_setor_economico_doador,
        @setor_economico_doador,
        @data_receita,
        @valor_receita,
        @tipo_receita,
        @fonte_recurso,
        @especie_recurso,
        @descricao_receita,
        @cpf_cnpj_doador_originario,
        @nome_doador_originario,
        @tipo_doador_originario,
        @setor_economico_doador_originario,
        @nome_doador_originario_receita_federal)
    SET
        cod_eleicao=NULLIF(TRIM(@cod_eleicao),""),
        desc_eleicao=NULLIF(TRIM(@desc_eleicao),""),
        data_hora=STR_TO_DATE(NULLIF(TRIM(@data_hora),""),"%d/%m/%Y%H:%i:%s"),
        cnpj_prestador_conta=NULLIF(TRIM(@cnpj_prestador_conta),""),
        sequencial_candidato=NULLIF(TRIM(@sequencial_candidato),""),
        uf=NULLIF(TRIM(@uf),""),
        sigla_ue=NULLIF(TRIM(@sigla_ue),""),
        nome_ue=NULLIF(TRIM(@nome_ue),""),
        sigla_partido=NULLIF(TRIM(@sigla_partido),""),
        numero_candidato=NULLIF(TRIM(@numero_candidato),""),
        cargo=NULLIF(TRIM(@cargo),""),
        nome_candidato=NULLIF(TRIM(@nome_candidato),""),
        cpf_candidato=NULLIF(TRIM(@cpf_candidato),""),
        cpf_vice_suplente=NULLIF(TRIM(@cpf_vice_suplente),""),
        numero_recibo_eleitoral=NULLIF(TRIM(@numero_recibo_eleitoral),""),
        numero_documento=NULLIF(TRIM(@numero_documento),""),
        cpf_cnpj_doador=NULLIF(TRIM(@cpf_cnpj_doador),""),
        nome_doador=NULLIF(TRIM(@nome_doador),""),
        nome_doador_receita_federal=NULLIF(TRIM(@nome_doador_receita_federal),""),
        sigla_ue_doador=NULLIF(TRIM(@sigla_ue_doador),""),
        numero_partido_doador=NULLIF(TRIM(@numero_partido_doador),""),
        numero_candidato_doador=NULLIF(TRIM(@numero_candidato_doador),""),
        cod_setor_economico_doador=NULLIF(TRIM(@cod_setor_economico_doador),""),
        setor_economico_doador=NULLIF(TRIM(@setor_economico_doador),""),
        data_receita=STR_TO_DATE(NULLIF(TRIM(@data_receita),""),"%d/%m/%Y%H:%i:%s"),
        valor_receita=CONVERT(REPLACE(REPLACE(NULLIF(TRIM(@valor_receita),""), '.', ''), ',', '.'), DECIMAL(10,2)),
        tipo_receita=NULLIF(TRIM(@tipo_receita),""),
        fonte_recurso=NULLIF(TRIM(@fonte_recurso),""),
        especie_recurso=NULLIF(TRIM(@especie_recurso),""),
        descricao_receita=NULLIF(TRIM(@descricao_receita),""),
        cpf_cnpj_doador_originario=NULLIF(TRIM(@cpf_cnpj_doador_originario),""),
        nome_doador_originario=NULLIF(TRIM(@nome_doador_originario),""),
        tipo_doador_originario=NULLIF(TRIM(@tipo_doador_originario),""),
        setor_economico_doador_originario=NULLIF(TRIM(@setor_economico_doador_originario),""),
        nome_doador_originario_receita_federal=NULLIF(TRIM(@nome_doador_originario_receita_federal),"");
END_LOAD_TABLE
    )

}

receitas_candidatos_2014(){
    TABLE_NAME="receitas_candidatos"

    CREATE_TABLE_CMD=$(cat <<-END_CREATE_TABLE
    CREATE TABLE IF NOT EXISTS $TABLE_NAME (
        cod_eleicao int(11) DEFAULT NULL,
        desc_eleicao varchar(255) DEFAULT NULL,
        data_hora datetime DEFAULT NULL,
        cnpj_prestador_conta bigint(11) DEFAULT NULL,
        sequencial_candidato bigint(11) DEFAULT NULL,
        uf varchar(255) DEFAULT NULL,
        sigla_partido varchar(255) DEFAULT NULL,
        numero_candidato int(11) DEFAULT NULL,
        cargo varchar(255) DEFAULT NULL,
        nome_candidato varchar(255) DEFAULT NULL,
        cpf_candidato varchar(255) DEFAULT NULL,
        numero_recibo_eleitoral varchar(255) DEFAULT NULL,
        numero_documento varchar(255) DEFAULT NULL,
        cpf_cnpj_doador varchar(255) DEFAULT NULL,
        nome_doador varchar(255) DEFAULT NULL,
        nome_doador_receita_federal varchar(255) DEFAULT NULL,
        sigla_ue_doador varchar(255) DEFAULT NULL,
        numero_partido_doador int(11) DEFAULT NULL,
        numero_candidato_doador int(11) DEFAULT NULL,
        cod_setor_economico_doador varchar(255) DEFAULT NULL,
        setor_economico_doador varchar(255) DEFAULT NULL,
        data_receita datetime DEFAULT NULL,
        valor_receita decimal(10,2) DEFAULT NULL,
        tipo_receita varchar(255) DEFAULT NULL,
        fonte_recurso varchar(255) DEFAULT NULL,
        especie_recurso varchar(255) DEFAULT NULL,
        descricao_receita varchar(255) DEFAULT NULL,
        cpf_cnpj_doador_originario varchar(255) DEFAULT NULL,
        nome_doador_originario varchar(255) DEFAULT NULL,
        tipo_doador_originario varchar(255) DEFAULT NULL,
        setor_economico_doador_originario varchar(255) DEFAULT NULL,
        nome_doador_originario_receita_federal varchar(255) DEFAULT NULL
    );
END_CREATE_TABLE
    )

    LOAD_DATA_CMD=$(cat <<-END_LOAD_TABLE
    load data local infile "$FILE"
      into table $TABLE_NAME
        fields terminated by ';' OPTIONALLY ENCLOSED BY '"'
        lines terminated by "$END_LINE"
        ignore 1 lines
        (@cod_eleicao,
        @desc_eleicao,
        @data_hora,
        @cnpj_prestador_conta,
        @sequencial_candidato,
        @uf,
        @sigla_partido,
        @numero_candidato,
        @cargo,
        @nome_candidato,
        @cpf_candidato,
        @numero_recibo_eleitoral,
        @numero_documento,
        @cpf_cnpj_doador,
        @nome_doador,
        @nome_doador_receita_federal,
        @sigla_ue_doador,
        @numero_partido_doador,
        @numero_candidato_doador,
        @cod_setor_economico_doador,
        @setor_economico_doador,
        @data_receita,
        @valor_receita,
        @tipo_receita,
        @fonte_recurso,
        @especie_recurso,
        @descricao_receita,
        @cpf_cnpj_doador_originario,
        @nome_doador_originario,
        @tipo_doador_originario,
        @setor_economico_doador_originario,
        @nome_doador_originario_receita_federal)
    SET
        cod_eleicao=NULLIF(TRIM(@cod_eleicao),""),
        desc_eleicao=NULLIF(TRIM(@desc_eleicao),""),
        data_hora=STR_TO_DATE(NULLIF(TRIM(@data_hora),""),"%d/%m/%Y%H:%i:%s"),
        cnpj_prestador_conta=NULLIF(TRIM(@cnpj_prestador_conta),""),
        sequencial_candidato=NULLIF(TRIM(@sequencial_candidato),""),
        uf=NULLIF(TRIM(@uf),""),
        sigla_partido=NULLIF(TRIM(@sigla_partido),""),
        numero_candidato=NULLIF(TRIM(@numero_candidato),""),
        cargo=NULLIF(TRIM(@cargo),""),
        nome_candidato=NULLIF(TRIM(@nome_candidato),""),
        cpf_candidato=NULLIF(TRIM(@cpf_candidato),""),
        numero_recibo_eleitoral=NULLIF(TRIM(@numero_recibo_eleitoral),""),
        numero_documento=NULLIF(TRIM(@numero_documento),""),
        cpf_cnpj_doador=NULLIF(TRIM(@cpf_cnpj_doador),""),
        nome_doador=NULLIF(TRIM(@nome_doador),""),
        nome_doador_receita_federal=NULLIF(TRIM(@nome_doador_receita_federal),""),
        sigla_ue_doador=NULLIF(TRIM(@sigla_ue_doador),""),
        numero_partido_doador=NULLIF(TRIM(@numero_partido_doador),""),
        numero_candidato_doador=NULLIF(TRIM(@numero_candidato_doador),""),
        cod_setor_economico_doador=NULLIF(TRIM(@cod_setor_economico_doador),""),
        setor_economico_doador=NULLIF(TRIM(@setor_economico_doador),""),
        data_receita=STR_TO_DATE(NULLIF(TRIM(@data_receita),""),"%d/%m/%Y%H:%i:%s"),
        valor_receita=CONVERT(REPLACE(REPLACE(NULLIF(TRIM(@valor_receita),""), '.', ''), ',', '.'), DECIMAL(10,2)),
        tipo_receita=NULLIF(TRIM(@tipo_receita),""),
        fonte_recurso=NULLIF(TRIM(@fonte_recurso),""),
        especie_recurso=NULLIF(TRIM(@especie_recurso),""),
        descricao_receita=NULLIF(TRIM(@descricao_receita),""),
        cpf_cnpj_doador_originario=NULLIF(TRIM(@cpf_cnpj_doador_originario),""),
        nome_doador_originario=NULLIF(TRIM(@nome_doador_originario),""),
        tipo_doador_originario=NULLIF(TRIM(@tipo_doador_originario),""),
        setor_economico_doador_originario=NULLIF(TRIM(@setor_economico_doador_originario),""),
        nome_doador_originario_receita_federal=NULLIF(TRIM(@nome_doador_originario_receita_federal),"");
END_LOAD_TABLE
    )

}

receitas_candidatos_2012(){
    TABLE_NAME="receitas_candidatos"

    CREATE_TABLE_CMD=$(cat <<-END_CREATE_TABLE
    CREATE TABLE IF NOT EXISTS $TABLE_NAME (
        data_hora datetime DEFAULT NULL,
        sequencial_candidato bigint(11) DEFAULT NULL,
        uf varchar(255) DEFAULT NULL,
        numero_ue varchar(255) DEFAULT NULL,
        municipio varchar(255) DEFAULT NULL,
        sigla_partido varchar(255) DEFAULT NULL,
        numero_candidato int(11) DEFAULT NULL,
        cargo varchar(255) DEFAULT NULL,
        nome_candidato varchar(255) DEFAULT NULL,
        cpf_candidato varchar(255) DEFAULT NULL,
        numero_recibo_eleitoral varchar(255) DEFAULT NULL,
        numero_documento varchar(255) DEFAULT NULL,
        cpf_cnpj_doador varchar(255) DEFAULT NULL,
        nome_doador varchar(255) DEFAULT NULL,
        data_receita datetime DEFAULT NULL,
        valor_receita decimal(10,2) DEFAULT NULL,
        tipo_receita varchar(255) DEFAULT NULL,
        fonte_recurso varchar(255) DEFAULT NULL,
        especie_recurso varchar(255) DEFAULT NULL,
        descricao_receita varchar(255) DEFAULT NULL
    );
END_CREATE_TABLE
    )

    LOAD_DATA_CMD=$(cat <<-END_LOAD_TABLE
    load data local infile "$FILE"
      into table $TABLE_NAME
        fields terminated by ';' OPTIONALLY ENCLOSED BY '"'
        lines terminated by "$END_LINE"
        ignore 1 lines
        (@data_hora,
        @sequencial_candidato,
        @uf,
        @numero_ue,
        @municipio,
        @sigla_partido,
        @numero_candidato,
        @cargo,
        @nome_candidato,
        @cpf_candidato,
        @numero_recibo_eleitoral,
        @numero_documento,
        @cpf_cnpj_doador,
        @nome_doador,
        @data_receita,
        @valor_receita,
        @tipo_receita,
        @fonte_recurso,
        @especie_recurso,
        @descricao_receita)
    SET
        data_hora=STR_TO_DATE(NULLIF(TRIM(@data_hora),""),"%d/%m/%Y%H:%i:%s"),
        sequencial_candidato=NULLIF(TRIM(@sequencial_candidato),""),
        uf=NULLIF(TRIM(@uf),""),
        numero_ue=NULLIF(TRIM(@numero_ue),""),
        municipio=NULLIF(TRIM(@municipio),""),
        sigla_partido=NULLIF(TRIM(@sigla_partido),""),
        numero_candidato=NULLIF(TRIM(@numero_candidato),""),
        cargo=NULLIF(TRIM(@cargo),""),
        nome_candidato=NULLIF(TRIM(@nome_candidato),""),
        cpf_candidato=NULLIF(TRIM(@cpf_candidato),""),
        numero_recibo_eleitoral=NULLIF(TRIM(@numero_recibo_eleitoral),""),
        numero_documento=NULLIF(TRIM(@numero_documento),""),
        cpf_cnpj_doador=NULLIF(TRIM(@cpf_cnpj_doador),""),
        nome_doador=NULLIF(TRIM(@nome_doador),""),
        data_receita=STR_TO_DATE(NULLIF(TRIM(@data_receita),""),"%d/%m/%Y%H:%i:%s"),
        valor_receita=CONVERT(REPLACE(REPLACE(NULLIF(TRIM(@valor_receita),""), '.', ''), ',', '.'), DECIMAL(10,2)),
        tipo_receita=NULLIF(TRIM(@tipo_receita),""),
        fonte_recurso=NULLIF(TRIM(@fonte_recurso),""),
        especie_recurso=NULLIF(TRIM(@especie_recurso),""),
        descricao_receita=NULLIF(TRIM(@descricao_receita),"");
END_LOAD_TABLE
    )

}


receitas_comites_2014(){
    TABLE_NAME="receitas_comites"

    CREATE_TABLE_CMD=$(cat <<-END_CREATE_TABLE
    CREATE TABLE IF NOT EXISTS $TABLE_NAME (
        cod_eleicao int(11) DEFAULT NULL,
        desc_eleicao varchar(255) DEFAULT NULL,
        data_hora datetime DEFAULT NULL,
        cnpj_prestador_conta bigint(11) DEFAULT NULL,
        sequencial_comite bigint(11) DEFAULT NULL,
        uf varchar(255) DEFAULT NULL,
        tipo_comite varchar(255) DEFAULT NULL,
        sigla_partido varchar(255) DEFAULT NULL,
        tipo_documento varchar(255) DEFAULT NULL,
        numero_documento varchar(255) DEFAULT NULL,
        cpf_cnpj_doador varchar(255) DEFAULT NULL,
        nome_doador varchar(255) DEFAULT NULL,
        nome_doador_receita_federal varchar(255) DEFAULT NULL,
        sigla_ue_doador varchar(255) DEFAULT NULL,
        numero_partido_doador int(11) DEFAULT NULL,
        numero_candidato_doador int(11) DEFAULT NULL,
        cod_setor_economico_doador varchar(255) DEFAULT NULL,
        setor_economico_doador varchar(255) DEFAULT NULL,
        data_receita datetime DEFAULT NULL,
        valor_receita decimal(10,2) DEFAULT NULL,
        tipo_receita varchar(255) DEFAULT NULL,
        fonte_recurso varchar(255) DEFAULT NULL,
        especie_recurso varchar(255) DEFAULT NULL,
        descricao_receita varchar(255) DEFAULT NULL,
        cpf_cnpj_doador_originario varchar(255) DEFAULT NULL,
        nome_doador_originario varchar(255) DEFAULT NULL,
        tipo_doador_originario varchar(255) DEFAULT NULL,
        setor_economico_doador_originario varchar(255) DEFAULT NULL,
        nome_doador_originario_receita_federal varchar(255) DEFAULT NULL
    );
END_CREATE_TABLE
    )

    LOAD_DATA_CMD=$(cat <<-END_LOAD_TABLE
    load data local infile "$FILE"
      into table $TABLE_NAME
        fields terminated by ';' OPTIONALLY ENCLOSED BY '"'
        lines terminated by "$END_LINE"
        ignore 1 lines
        (@cod_eleicao,
        @desc_eleicao,
        @data_hora,
        @cnpj_prestador_conta,
        @sequencial_comite,
        @uf,
        @tipo_comite,
        @sigla_partido,
        @tipo_documento,
        @numero_documento,
        @cpf_cnpj_doador,
        @nome_doador,
        @nome_doador_receita_federal,
        @sigla_ue_doador,
        @numero_partido_doador,
        @numero_candidato_doador,
        @cod_setor_economico_doador,
        @setor_economico_doador,
        @data_receita,
        @valor_receita,
        @tipo_receita,
        @fonte_recurso,
        @especie_recurso,
        @descricao_receita,
        @cpf_cnpj_doador_originario,
        @nome_doador_originario,
        @tipo_doador_originario,
        @setor_economico_doador_originario,
        @nome_doador_originario_receita_federal)
    SET
        cod_eleicao=NULLIF(TRIM(@cod_eleicao),""),
        desc_eleicao=NULLIF(TRIM(@desc_eleicao),""),
        data_hora=STR_TO_DATE(NULLIF(TRIM(@data_hora),""),"%d/%m/%Y%H:%i:%s"),
        cnpj_prestador_conta=NULLIF(TRIM(@cnpj_prestador_conta),""),
        sequencial_comite=NULLIF(TRIM(@sequencial_comite),""),
        uf=NULLIF(TRIM(@uf),""),
        tipo_comite=NULLIF(TRIM(@tipo_comite),""),
        sigla_partido=NULLIF(TRIM(@sigla_partido),""),
        tipo_documento=NULLIF(TRIM(@tipo_documento),""),
        numero_documento=NULLIF(TRIM(@numero_documento),""),
        cpf_cnpj_doador=NULLIF(TRIM(@cpf_cnpj_doador),""),
        nome_doador=NULLIF(TRIM(@nome_doador),""),
        nome_doador_receita_federal=NULLIF(TRIM(@nome_doador_receita_federal),""),
        sigla_ue_doador=NULLIF(TRIM(@sigla_ue_doador),""),
        numero_partido_doador=NULLIF(TRIM(@numero_partido_doador),""),
        numero_candidato_doador=NULLIF(TRIM(@numero_candidato_doador),""),
        cod_setor_economico_doador=NULLIF(TRIM(@cod_setor_economico_doador),""),
        setor_economico_doador=NULLIF(TRIM(@setor_economico_doador),""),
        data_receita=STR_TO_DATE(NULLIF(TRIM(@data_receita),""),"%d/%m/%Y%H:%i:%s"),
        valor_receita=CONVERT(REPLACE(REPLACE(NULLIF(TRIM(@valor_receita),""), '.', ''), ',', '.'), DECIMAL(10,2)),
        tipo_receita=NULLIF(TRIM(@tipo_receita),""),
        fonte_recurso=NULLIF(TRIM(@fonte_recurso),""),
        especie_recurso=NULLIF(TRIM(@especie_recurso),""),
        descricao_receita=NULLIF(TRIM(@descricao_receita),""),
        cpf_cnpj_doador_originario=NULLIF(TRIM(@cpf_cnpj_doador_originario),""),
        nome_doador_originario=NULLIF(TRIM(@nome_doador_originario),""),
        tipo_doador_originario=NULLIF(TRIM(@tipo_doador_originario),""),
        setor_economico_doador_originario=NULLIF(TRIM(@setor_economico_doador_originario),""),
        nome_doador_originario_receita_federal=NULLIF(TRIM(@nome_doador_originario_receita_federal),"");
END_LOAD_TABLE
    )
}

receitas_comites_2012(){
    TABLE_NAME="receitas_comites"

    CREATE_TABLE_CMD=$(cat <<-END_CREATE_TABLE
    CREATE TABLE IF NOT EXISTS $TABLE_NAME (
        data_hora datetime DEFAULT NULL,
        sequencial_comite bigint(11) DEFAULT NULL,
        uf varchar(255) DEFAULT NULL,
        numero_ue varchar(255) DEFAULT NULL,
        municipio varchar(255) DEFAULT NULL,
        tipo_comite varchar(255) DEFAULT NULL,
        sigla_partido varchar(255) DEFAULT NULL,
        tipo_documento varchar(255) DEFAULT NULL,
        numero_documento varchar(255) DEFAULT NULL,
        cpf_cnpj_doador varchar(255) DEFAULT NULL,
        nome_doador varchar(255) DEFAULT NULL,
        data_receita datetime DEFAULT NULL,
        valor_receita decimal(10,2) DEFAULT NULL,
        tipo_receita varchar(255) DEFAULT NULL,
        fonte_recurso varchar(255) DEFAULT NULL,
        especie_recurso varchar(255) DEFAULT NULL,
        descricao_receita varchar(255) DEFAULT NULL
    );
END_CREATE_TABLE
    )

    LOAD_DATA_CMD=$(cat <<-END_LOAD_TABLE
    load data local infile "$FILE"
      into table $TABLE_NAME
        fields terminated by ';' OPTIONALLY ENCLOSED BY '"'
        lines terminated by "$END_LINE"
        ignore 1 lines
        (@data_hora,
        @sequencial_comite,
        @uf,
        @numero_ue,
        @municipio,
        @tipo_comite,
        @sigla_partido,
        @tipo_documento,
        @numero_documento,
        @cpf_cnpj_doador,
        @nome_doador,
        @data_receita,
        @valor_receita,
        @tipo_receita,
        @fonte_recurso,
        @especie_recurso,
        @descricao_receita)
    SET
        data_hora=STR_TO_DATE(NULLIF(TRIM(@data_hora),""),"%d/%m/%Y%H:%i:%s"),
        sequencial_comite=NULLIF(TRIM(@sequencial_comite),""),
        uf=NULLIF(TRIM(@uf),""),
        numero_ue=NULLIF(TRIM(@numero_ue),""),
        municipio=NULLIF(TRIM(@municipio),""),
        tipo_comite=NULLIF(TRIM(@tipo_comite),""),
        sigla_partido=NULLIF(TRIM(@sigla_partido),""),
        tipo_documento=NULLIF(TRIM(@tipo_documento),""),
        numero_documento=NULLIF(TRIM(@numero_documento),""),
        cpf_cnpj_doador=NULLIF(TRIM(@cpf_cnpj_doador),""),
        nome_doador=NULLIF(TRIM(@nome_doador),""),
        data_receita=STR_TO_DATE(NULLIF(TRIM(@data_receita),""),"%d/%m/%Y"),
        valor_receita=CONVERT(REPLACE(REPLACE(NULLIF(TRIM(@valor_receita),""), '.', ''), ',', '.'), DECIMAL(10,2)),
        tipo_receita=NULLIF(TRIM(@tipo_receita),""),
        fonte_recurso=NULLIF(TRIM(@fonte_recurso),""),
        especie_recurso=NULLIF(TRIM(@especie_recurso),""),
        descricao_receita=NULLIF(TRIM(@descricao_receita),"");
END_LOAD_TABLE
    )
}


receitas_partidos_2016(){
    TABLE_NAME="receitas_partidos"

    CREATE_TABLE_CMD=$(cat <<-END_CREATE_TABLE
    CREATE TABLE IF NOT EXISTS $TABLE_NAME (
        cod_eleicao int(11) DEFAULT NULL,
        desc_eleicao varchar(255) DEFAULT NULL,
        data_hora datetime DEFAULT NULL,
        cnpj_prestador_conta bigint(11) DEFAULT NULL,
        sequencial_prestador_conta bigint(11) DEFAULT NULL,
        uf varchar(255) DEFAULT NULL,
        sigla_ue varchar(255) DEFAULT NULL,
        nome_ue varchar(255) DEFAULT NULL,
        tipo_diretorio varchar(255) DEFAULT NULL,
        sigla_partido varchar(255) DEFAULT NULL,
        numero_recibo_eleitoral varchar(255) DEFAULT NULL,
        numero_documento varchar(255) DEFAULT NULL,
        cpf_cnpj_doador varchar(255) DEFAULT NULL,
        nome_doador varchar(255) DEFAULT NULL,
        nome_doador_receita_federal varchar(255) DEFAULT NULL,
        sigla_ue_doador varchar(255) DEFAULT NULL,
        numero_partido_doador int(11) DEFAULT NULL,
        numero_candidato_doador int(11) DEFAULT NULL,
        cod_setor_economico_doador varchar(255) DEFAULT NULL,
        setor_economico_doador varchar(255) DEFAULT NULL,
        data_receita datetime DEFAULT NULL,
        valor_receita decimal(10,2) DEFAULT NULL,
        tipo_receita varchar(255) DEFAULT NULL,
        fonte_recurso varchar(255) DEFAULT NULL,
        especie_recurso varchar(255) DEFAULT NULL,
        descricao_receita varchar(255) DEFAULT NULL,
        cpf_cnpj_doador_originario varchar(255) DEFAULT NULL,
        nome_doador_originario varchar(255) DEFAULT NULL,
        tipo_doador_originario varchar(255) DEFAULT NULL,
        setor_economico_doador_originario varchar(255) DEFAULT NULL,
        nome_doador_originario_receita_federal varchar(255) DEFAULT NULL
    );
END_CREATE_TABLE
    )

    LOAD_DATA_CMD=$(cat <<-END_LOAD_TABLE
    load data local infile "$FILE"
      into table $TABLE_NAME
        fields terminated by ';' OPTIONALLY ENCLOSED BY '"'
        lines terminated by "$END_LINE"
        ignore 1 lines
        (@cod_eleicao,
        @desc_eleicao,
        @data_hora,
        @cnpj_prestador_conta,
        @sequencial_prestador_conta,
        @uf,
        @sigla_ue,
        @nome_ue,
        @tipo_diretorio,
        @sigla_partido,
        @numero_recibo_eleitoral,
        @numero_documento,
        @cpf_cnpj_doador,
        @nome_doador,
        @nome_doador_receita_federal,
        @sigla_ue_doador,
        @numero_partido_doador,
        @numero_candidato_doador,
        @cod_setor_economico_doador,
        @setor_economico_doador,
        @data_receita,
        @valor_receita,
        @tipo_receita,
        @fonte_recurso,
        @especie_recurso,
        @descricao_receita,
        @cpf_cnpj_doador_originario,
        @nome_doador_originario,
        @tipo_doador_originario,
        @setor_economico_doador_originario,
        @nome_doador_originario_receita_federal)
    SET
        cod_eleicao=NULLIF(TRIM(@cod_eleicao),""),
        desc_eleicao=NULLIF(TRIM(@desc_eleicao),""),
        data_hora=STR_TO_DATE(NULLIF(TRIM(@data_hora),""),"%d/%m/%Y%H:%i:%s"),
        cnpj_prestador_conta=NULLIF(TRIM(@cnpj_prestador_conta),""),
        sequencial_prestador_conta=NULLIF(TRIM(@sequencial_prestador_conta),""),
        uf=NULLIF(TRIM(@uf),""),
        sigla_ue=NULLIF(TRIM(@sigla_ue),""),
        nome_ue=NULLIF(TRIM(@nome_ue),""),
        tipo_diretorio=NULLIF(TRIM(@tipo_diretorio),""),
        sigla_partido=NULLIF(TRIM(@sigla_partido),""),
        numero_recibo_eleitoral=NULLIF(TRIM(@numero_recibo_eleitoral),""),
        numero_documento=NULLIF(TRIM(@numero_documento),""),
        cpf_cnpj_doador=NULLIF(TRIM(@cpf_cnpj_doador),""),
        nome_doador=NULLIF(TRIM(@nome_doador),""),
        nome_doador_receita_federal=NULLIF(TRIM(@nome_doador_receita_federal),""),
        sigla_ue_doador=NULLIF(TRIM(@sigla_ue_doador),""),
        numero_partido_doador=NULLIF(TRIM(@numero_partido_doador),""),
        numero_candidato_doador=NULLIF(TRIM(@numero_candidato_doador),""),
        cod_setor_economico_doador=NULLIF(TRIM(@cod_setor_economico_doador),""),
        setor_economico_doador=NULLIF(TRIM(@setor_economico_doador),""),
        data_receita=STR_TO_DATE(NULLIF(TRIM(@data_receita),""),"%d-%M-%y"),
        valor_receita=CONVERT(REPLACE(REPLACE(NULLIF(TRIM(@valor_receita),""), '.', ''), ',', '.'), DECIMAL(10,2)),
        tipo_receita=NULLIF(TRIM(@tipo_receita),""),
        fonte_recurso=NULLIF(TRIM(@fonte_recurso),""),
        especie_recurso=NULLIF(TRIM(@especie_recurso),""),
        descricao_receita=NULLIF(TRIM(@descricao_receita),""),
        cpf_cnpj_doador_originario=NULLIF(TRIM(@cpf_cnpj_doador_originario),""),
        nome_doador_originario=NULLIF(TRIM(@nome_doador_originario),""),
        tipo_doador_originario=NULLIF(TRIM(@tipo_doador_originario),""),
        setor_economico_doador_originario=NULLIF(TRIM(@setor_economico_doador_originario),""),
        nome_doador_originario_receita_federal=NULLIF(TRIM(@nome_doador_originario_receita_federal),"");
END_LOAD_TABLE
    )
}

receitas_partidos_2014(){
    TABLE_NAME="receitas_partidos"

    CREATE_TABLE_CMD=$(cat <<-END_CREATE_TABLE
    CREATE TABLE IF NOT EXISTS $TABLE_NAME (
        cod_eleicao int(11) DEFAULT NULL,
        desc_eleicao varchar(255) DEFAULT NULL,
        data_hora datetime DEFAULT NULL,
        cnpj_prestador_conta bigint(11) DEFAULT NULL,
        sequencial_diretorio bigint(11) DEFAULT NULL,
        uf varchar(255) DEFAULT NULL,
        tipo_diretorio varchar(255) DEFAULT NULL,
        sigla_partido varchar(255) DEFAULT NULL,
        tipo_documento varchar(255) DEFAULT NULL,
        numero_documento varchar(255) DEFAULT NULL,
        cpf_cnpj_doador varchar(255) DEFAULT NULL,
        nome_doador varchar(255) DEFAULT NULL,
        nome_doador_receita_federal varchar(255) DEFAULT NULL,
        sigla_ue_doador varchar(255) DEFAULT NULL,
        numero_partido_doador int(11) DEFAULT NULL,
        numero_candidato_doador int(11) DEFAULT NULL,
        cod_setor_economico_doador varchar(255) DEFAULT NULL,
        setor_economico_doador varchar(255) DEFAULT NULL,
        data_receita datetime DEFAULT NULL,
        valor_receita decimal(10,2) DEFAULT NULL,
        tipo_receita varchar(255) DEFAULT NULL,
        fonte_recurso varchar(255) DEFAULT NULL,
        especie_recurso varchar(255) DEFAULT NULL,
        descricao_receita varchar(255) DEFAULT NULL,
        cpf_cnpj_doador_originario varchar(255) DEFAULT NULL,
        nome_doador_originario varchar(255) DEFAULT NULL,
        tipo_doador_originario varchar(255) DEFAULT NULL,
        setor_economico_doador_originario varchar(255) DEFAULT NULL,
        nome_doador_originario_receita_federal varchar(255) DEFAULT NULL
    );
END_CREATE_TABLE
    )

    LOAD_DATA_CMD=$(cat <<-END_LOAD_TABLE
    load data local infile "$FILE"
      into table $TABLE_NAME
        fields terminated by ';' OPTIONALLY ENCLOSED BY '"'
        lines terminated by "$END_LINE"
        ignore 1 lines
        (@cod_eleicao,
        @desc_eleicao,
        @data_hora,
        @cnpj_prestador_conta,
        @sequencial_diretorio,
        @uf,
        @tipo_diretorio,
        @sigla_partido,
        @tipo_documento,
        @numero_documento,
        @cpf_cnpj_doador,
        @nome_doador,
        @nome_doador_receita_federal,
        @sigla_ue_doador,
        @numero_partido_doador,
        @numero_candidato_doador,
        @cod_setor_economico_doador,
        @setor_economico_doador,
        @data_receita,
        @valor_receita,
        @tipo_receita,
        @fonte_recurso,
        @especie_recurso,
        @descricao_receita,
        @cpf_cnpj_doador_originario,
        @nome_doador_originario,
        @tipo_doador_originario,
        @setor_economico_doador_originario,
        @nome_doador_originario_receita_federal)
    SET
        cod_eleicao=NULLIF(TRIM(@cod_eleicao),""),
        desc_eleicao=NULLIF(TRIM(@desc_eleicao),""),
        data_hora=STR_TO_DATE(NULLIF(TRIM(@data_hora),""),"%d/%m/%Y%H:%i:%s"),
        cnpj_prestador_conta=NULLIF(TRIM(@cnpj_prestador_conta),""),
        sequencial_diretorio=NULLIF(TRIM(@sequencial_diretorio),""),
        uf=NULLIF(TRIM(@uf),""),
        tipo_diretorio=NULLIF(TRIM(@tipo_diretorio),""),
        sigla_partido=NULLIF(TRIM(@sigla_partido),""),
        tipo_documento=NULLIF(TRIM(@tipo_documento),""),
        numero_documento=NULLIF(TRIM(@numero_documento),""),
        cpf_cnpj_doador=NULLIF(TRIM(@cpf_cnpj_doador),""),
        nome_doador=NULLIF(TRIM(@nome_doador),""),
        nome_doador_receita_federal=NULLIF(TRIM(@nome_doador_receita_federal),""),
        sigla_ue_doador=NULLIF(TRIM(@sigla_ue_doador),""),
        numero_partido_doador=NULLIF(TRIM(@numero_partido_doador),""),
        numero_candidato_doador=NULLIF(TRIM(@numero_candidato_doador),""),
        cod_setor_economico_doador=NULLIF(TRIM(@cod_setor_economico_doador),""),
        setor_economico_doador=NULLIF(TRIM(@setor_economico_doador),""),
        data_receita=STR_TO_DATE(NULLIF(TRIM(@data_receita),""),"%d-%M-%y"),
        valor_receita=CONVERT(REPLACE(REPLACE(NULLIF(TRIM(@valor_receita),""), '.', ''), ',', '.'), DECIMAL(10,2)),
        tipo_receita=NULLIF(TRIM(@tipo_receita),""),
        fonte_recurso=NULLIF(TRIM(@fonte_recurso),""),
        especie_recurso=NULLIF(TRIM(@especie_recurso),""),
        descricao_receita=NULLIF(TRIM(@descricao_receita),""),
        cpf_cnpj_doador_originario=NULLIF(TRIM(@cpf_cnpj_doador_originario),""),
        nome_doador_originario=NULLIF(TRIM(@nome_doador_originario),""),
        tipo_doador_originario=NULLIF(TRIM(@tipo_doador_originario),""),
        setor_economico_doador_originario=NULLIF(TRIM(@setor_economico_doador_originario),""),
        nome_doador_originario_receita_federal=NULLIF(TRIM(@nome_doador_originario_receita_federal),"");
END_LOAD_TABLE
    )
}

receitas_partidos_2012(){
    TABLE_NAME="receitas_partidos"

    CREATE_TABLE_CMD=$(cat <<-END_CREATE_TABLE
    CREATE TABLE IF NOT EXISTS $TABLE_NAME (
        data_hora datetime DEFAULT NULL,
        sequencial_diretorio bigint(11) DEFAULT NULL,
        uf varchar(255) DEFAULT NULL,
        numero_ue varchar(255) DEFAULT NULL,
        municipio varchar(255) DEFAULT NULL,
        tipo_diretorio varchar(255) DEFAULT NULL,
        sigla_partido varchar(255) DEFAULT NULL,
        tipo_documento varchar(255) DEFAULT NULL,
        numero_documento varchar(255) DEFAULT NULL,
        cpf_cnpj_doador varchar(255) DEFAULT NULL,
        nome_doador varchar(255) DEFAULT NULL,
        data_receita datetime DEFAULT NULL,
        valor_receita decimal(10,2) DEFAULT NULL,
        tipo_receita varchar(255) DEFAULT NULL,
        fonte_recurso varchar(255) DEFAULT NULL,
        especie_recurso varchar(255) DEFAULT NULL,
        descricao_receita varchar(255) DEFAULT NULL
    );
END_CREATE_TABLE
    )

    LOAD_DATA_CMD=$(cat <<-END_LOAD_TABLE
    load data local infile "$FILE"
      into table $TABLE_NAME
        fields terminated by ';' OPTIONALLY ENCLOSED BY '"'
        lines terminated by "$END_LINE"
        ignore 1 lines
        (@data_hora,
        @sequencial_diretorio,
        @uf,
        @numero_ue,
        @municipio,
        @tipo_diretorio,
        @sigla_partido,
        @tipo_documento,
        @numero_documento,
        @cpf_cnpj_doador,
        @nome_doador,
        @data_receita,
        @valor_receita,
        @tipo_receita,
        @fonte_recurso,
        @especie_recurso,
        @descricao_receita)
    SET
        data_hora=STR_TO_DATE(NULLIF(TRIM(@data_hora),""),"%d/%m/%Y%H:%i:%s"),
        sequencial_diretorio=NULLIF(TRIM(@sequencial_diretorio),""),
        uf=NULLIF(TRIM(@uf),""),
        numero_ue=NULLIF(TRIM(@numero_ue),""),
        municipio=NULLIF(TRIM(@municipio),""),
        tipo_diretorio=NULLIF(TRIM(@tipo_diretorio),""),
        sigla_partido=NULLIF(TRIM(@sigla_partido),""),
        tipo_documento=NULLIF(TRIM(@tipo_documento),""),
        numero_documento=NULLIF(TRIM(@numero_documento),""),
        cpf_cnpj_doador=NULLIF(TRIM(@cpf_cnpj_doador),""),
        nome_doador=NULLIF(TRIM(@nome_doador),""),
        data_receita=STR_TO_DATE(NULLIF(TRIM(@data_receita),""),"%d/%m/%Y"),
        valor_receita=CONVERT(REPLACE(REPLACE(NULLIF(TRIM(@valor_receita),""), '.', ''), ',', '.'), DECIMAL(10,2)),
        tipo_receita=NULLIF(TRIM(@tipo_receita),""),
        fonte_recurso=NULLIF(TRIM(@fonte_recurso),""),
        especie_recurso=NULLIF(TRIM(@especie_recurso),""),
        descricao_receita=NULLIF(TRIM(@descricao_receita),"");
END_LOAD_TABLE
    )
}



case "$FILE" in
    *[Dd]espesas*[Cc]andidatos*)
        case $YEAR in
            2002|2004|2006|2008|2010|2012)
                despesas_candidatos_2012
                ;;
            2014)
                despesas_candidatos_2014
                ;;
            2016)
                despesas_candidatos_2016
                ;;
            *)
                echo "ERROR - FILE $FILE is unknown in $YEAR."
                ;;

        esac
        ;;

    *[Dd]espesas*[Cc]omites*)
        case $YEAR in
            2002|2004|2006|2008|2010|2012)
                despesas_comites_2012
                ;;
            2014)
                despesas_comites_2014
                ;;
            *)
                echo "ERROR - FILE $FILE is unknown in $YEAR."
                ;;

        esac
        ;;


    *[Dd]espesas*[Pp]artidos*)
        case $YEAR in
            2002|2004|2006|2008|2010|2012)
                despesas_partidos_2012
                ;;
            2014)
                despesas_partidos_2014
                ;;
            2016)
                despesas_partidos_2016
                ;;
            *)
                echo "ERROR - FILE $FILE is unknown in $YEAR."
                ;;

        esac
        ;;

    *[Rr]eceitas*[Cc]andidatos*)
        case $YEAR in
            2002|2004|2006|2008|2010|2012)
                receitas_candidatos_2012
                ;;
            2014)
                receitas_candidatos_2014
                ;;
            2016)
                receitas_candidatos_2016
                ;;
            *)
                echo "ERROR - FILE $FILE is unknown in $YEAR."
                ;;

        esac
        ;;

    *[Rr]eceitas*[Cc]omites*)
        case $YEAR in
            2002|2004|2006|2008|2010|2012)
                receitas_comites_2012
                ;;
            2014)
                receitas_comites_2014
                ;;
            *)
                echo "ERROR - FILE $FILE is unknown in $YEAR."
                ;;
        esac
        ;;

    *[Rr]eceitas*[Pp]artidos*)
        case $YEAR in
            2002|2004|2006|2008|2010|2012)
                receitas_partidos_2012
                ;;
            2014)
                receitas_partidos_2014
                ;;
            2016)
                receitas_partidos_2016
                ;;

            *)
                echo "ERROR - FILE $FILE is unknown in $YEAR."
                ;;
        esac
        ;;
    *)
        echo "ERROR - FILE $FILE is unknown."
        ;;

esac

CREATE_DATABASE_CMD="CREATE DATABASE IF NOT EXISTS $DB_NAME;"
echo $CREATE_DATABASE_CMD | mysql -h$DB_HOST -u$DB_USER -p$DB_PASS

echo $CREATE_TABLE_CMD | mysql -h$DB_HOST -u$DB_USER -p$DB_PASS $DB_NAME
echo $LOAD_DATA_CMD | mysql -h$DB_HOST -u$DB_USER -p$DB_PASS $DB_NAME

exit 0
