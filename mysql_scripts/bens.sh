YEAR="$1"
FILE="$2"
if [ "$DB_NAME" = "" ];then
   DB_NAME="$DB_NAME_PREFIX$YEAR"
fi
TABLE_NAME="bens"

case $YEAR in
    2002|2004|2006|2008|2010)
        END_LINE="\r\n"
        ;;
    2012|2014|2016)
        END_LINE="\n"
        ;;
    *)
        END_LINE=""
        ;;
esac

CREATE_DATABASE_CMD="CREATE DATABASE IF NOT EXISTS $DB_NAME;"
echo $CREATE_DATABASE_CMD | mysql -h$DB_HOST -u$DB_USER -p$DB_PASS

CREATE_TABLE_CMD=$(cat <<-END
    CREATE TABLE IF NOT EXISTS $TABLE_NAME (
        data_geracao date DEFAULT NULL,
        hora_geracao time DEFAULT NULL,
        ano_eleicao int(11) DEFAULT NULL,
        descricao_eleicao varchar(255) CHARACTER SET utf8 DEFAULT NULL,
        sigla_uf varchar(255) CHARACTER SET utf8 DEFAULT NULL,
        sq_candidato bigint(11) DEFAULT NULL,
        cd_tipo_bem_candidato int(11) DEFAULT NULL,
        ds_tipo_bem_candidato varchar(255) CHARACTER SET utf8 DEFAULT NULL,
        detalhe_bem varchar(255) CHARACTER SET utf8 DEFAULT NULL,
        valor_bem decimal(10,2) DEFAULT NULL,
        data_ultima_atualizacao date DEFAULT NULL,
        hora_ultima_atualizacao time DEFAULT NULL
    );
END
)
echo $CREATE_TABLE_CMD | mysql -h$DB_HOST -u$DB_USER -p$DB_PASS $DB_NAME

LOAD_DATA_CMD=$(cat <<-END
load data local infile "$FILE"
  into table $TABLE_NAME
    fields terminated by ';' OPTIONALLY ENCLOSED BY '"'
    lines terminated by "$END_LINE"
    (@data_geracao,
     @hora_geracao,
     @ano_eleicao,
     @descricao_eleicao,
     @sigla_uf,
     @sq_candidato,
     @cd_tipo_bem_candidato,
     @ds_tipo_bem_candidato,
     @detalhe_bem,
     @valor_bem,
     @data_ultima_atualizacao,
     @hora_ultima_atualizacao)
SET
    data_geracao=STR_TO_DATE(NULLIF(TRIM(@data_geracao), ""), "%d/%m/%Y"),
    hora_geracao=STR_TO_DATE(NULLIF(TRIM(@hora_geracao), ""), "%H:%i:%s"),
    ano_eleicao=NULLIF(@ano_eleicao, ""),
    descricao_eleicao=NULLIF(TRIM(@descricao_eleicao), ""),
    sigla_uf=NULLIF(TRIM(@sigla_uf), ""),
    sq_candidato=NULLIF(TRIM(@sq_candidato), ""),
    cd_tipo_bem_candidato=NULLIF(@codigo_cargo, ""),
    ds_tipo_bem_candidato=NULLIF(TRIM(@ds_tipo_bem_candidato), ""),
    detalhe_bem=NULLIF(TRIM(@detalhe_bem), ""),
    valor_bem=CONVERT(REPLACE(REPLACE(NULLIF(TRIM(@valor_bem),""), '.', ''), ',', '.'), DECIMAL(10,2)),
    data_ultima_atualizacao=STR_TO_DATE(NULLIF(TRIM(@data_ultima_atualizacao), ""), "%d/%m/%Y"),
    hora_ultima_atualizacao=STR_TO_DATE(NULLIF(TRIM(@hora_ultima_atualizacao), ""), "%H:%i:%s");
END
)
echo $LOAD_DATA_CMD | mysql -h$DB_HOST -u$DB_USER -p$DB_PASS $DB_NAME


exit 0
