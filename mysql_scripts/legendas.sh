YEAR="$1"
FILE="$2"
if [ "$DB_NAME" = "" ];then
   DB_NAME="$DB_NAME_PREFIX$YEAR"
fi
TABLE_NAME="legendas"

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
        num_turno int(11) DEFAULT NULL,
        descricao_eleicao varchar(255) CHARACTER SET utf8 DEFAULT NULL,
        sigla_uf varchar(255) CHARACTER SET utf8 DEFAULT NULL,
        sigla_ue varchar(255) CHARACTER SET utf8 DEFAULT NULL,
        nome_ue varchar(255) CHARACTER SET utf8 DEFAULT NULL,
        codigo_cargo int(11) DEFAULT NULL,
        descricao_cargo varchar(255) CHARACTER SET utf8 DEFAULT NULL,
        tipo_legenda varchar(255) CHARACTER SET utf8 DEFAULT NULL,
        num_partido int(11) DEFAULT NULL,
        sigla_partido varchar(255) CHARACTER SET utf8 DEFAULT NULL,
        nome_partido varchar(255) CHARACTER SET utf8 DEFAULT NULL,
        sigla_coligacao varchar(255) CHARACTER SET utf8 DEFAULT NULL,
        nome_coligacao varchar(255) CHARACTER SET utf8 DEFAULT NULL,
        composicao_coligacao varchar(255) CHARACTER SET utf8 DEFAULT NULL,
        sequencial_coligacao int(11) DEFAULT NULL
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
     @num_turno,
     @descricao_eleicao,
     @sigla_uf,
     @sigla_ue,
     @nome_ue,
     @codigo_cargo,
     @descricao_cargo,
     @tipo_legenda,
     @num_partido,
     @sigla_partido,
     @nome_partido,
     @sigla_coligacao,
     @nome_coligacao,
     @composicao_coligacao,
     @sequencial_coligacao)
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
    tipo_legenda=NULLIF(TRIM(@tipo_legenda), ""),
    num_partido=NULLIF(@num_partido, ""),
    sigla_partido=NULLIF(TRIM(@sigla_partido), ""),
    nome_partido=NULLIF(TRIM(@nome_partido), ""),
    sigla_coligacao=NULLIF(TRIM(@sigla_coligacao), ""),
    nome_coligacao=NULLIF(TRIM(@nome_coligacao), ""),
    composicao_coligacao=NULLIF(TRIM(@composicao_coligacao), ""),
    sequencial_coligacao=IF(@sequencial_coligacao="" OR @sequencial_coligacao=-1 OR @sequencial_coligacao=-3, null, @sequencial_coligacao);
END
)
echo $LOAD_DATA_CMD | mysql -h$DB_HOST -u$DB_USER -p$DB_PASS $DB_NAME

exit 0
