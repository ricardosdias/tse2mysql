YEAR="$1"
FILE="$2"
if [ "$DB_NAME" = "" ];then
   DB_NAME="$DB_NAME_PREFIX$YEAR"
fi
TABLE_NAME="vagas"

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
        sigla_ue varchar(255) CHARACTER SET utf8 DEFAULT NULL,
        nome_ue varchar(255) CHARACTER SET utf8 DEFAULT NULL,
        codigo_cargo int(11) DEFAULT NULL,
        descricao_cargo varchar(255) CHARACTER SET utf8 DEFAULT NULL,
        qtde_vagas int(11) DEFAULT NULL
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
     @sigla_ue,
     @nome_ue,
     @codigo_cargo,
     @descricao_cargo,
     @qtde_vagas)
SET
    data_geracao=STR_TO_DATE(NULLIF(TRIM(@data_geracao), ""), "%d/%m/%Y"),
    hora_geracao=STR_TO_DATE(NULLIF(TRIM(@hora_geracao), ""), "%H:%i:%s"),
    ano_eleicao=NULLIF(@ano_eleicao, ""),
    descricao_eleicao=NULLIF(TRIM(@descricao_eleicao), ""),
    sigla_uf=NULLIF(TRIM(@sigla_uf), ""),
    sigla_ue=NULLIF(TRIM(@sigla_ue), ""),
    nome_ue=NULLIF(TRIM(@nome_ue), ""),
    codigo_cargo=NULLIF(@codigo_cargo, ""),
    descricao_cargo=NULLIF(TRIM(@descricao_cargo), ""),
    qtde_vagas=NULLIF(@qtde_vagas, "");
END
)
echo $LOAD_DATA_CMD | mysql -h$DB_HOST -u$DB_USER -p$DB_PASS $DB_NAME

exit 0
