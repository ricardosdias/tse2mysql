#!/bin/bash
YEAR=$1

URL="http://agencia.tse.jus.br/estatistica/sead/odsele"

case $YEAR in
    2016)
        echo "$URL/consulta_cand/consulta_cand_2016.zip,CANDIDATO"
        echo "$URL/bem_candidato/bem_candidato_2016.zip,BENS"
        echo "$URL/consulta_legendas/consulta_legendas_2016.zip,LEGENDAS"
        echo "$URL/consulta_vagas/consulta_vagas_2016.zip,VAGAS"
        echo "$URL/prestacao_contas/prestacao_contas_final_2016.zip,PRESTACAO_CONTAS"
        ;;
    2014)
        echo "$URL/consulta_cand/consulta_cand_2014.zip,CANDIDATO"
        echo "$URL/bem_candidato/bem_candidato_2014.zip,BENS"
        echo "$URL/consulta_legendas/consulta_legendas_2014.zip,LEGENDAS"
        echo "$URL/consulta_vagas/consulta_vagas_2014.zip,VAGAS"
        echo "$URL/prestacao_contas/prestacao_final_2014.zip,PRESTACAO_CONTAS"
        ;;
    2012)
        echo "$URL/consulta_cand/consulta_cand_2012.zip,CANDIDATO"
        echo "$URL/bem_candidato/bem_candidato_2012.zip,BENS"
        echo "$URL/consulta_legendas/consulta_legendas_2012.zip,LEGENDAS"
        echo "$URL/consulta_vagas/consulta_vagas_2012.zip,VAGAS"
        echo "$URL/prestacao_contas/prestacao_final_2012.zip,PRESTACAO_CONTAS"
        ;;
    2010)
        echo "$URL/consulta_cand/consulta_cand_2010.zip,CANDIDATO"
        echo "$URL/bem_candidato/bem_candidato_2010.zip,BENS"
        echo "$URL/consulta_legendas/consulta_legendas_2010.zip,LEGENDAS"
        echo "$URL/consulta_vagas/consulta_vagas_2010.zip,VAGAS"
        #echo "$URL/prestacao_contas/prestacao_contas_2010.zip,PRESTACAO_CONTAS"
        ;;
    2008)
        echo "$URL/consulta_cand/consulta_cand_2008.zip,CANDIDATO"
        echo "$URL/bem_candidato/bem_candidato_2008.zip,BENS"
        echo "$URL/consulta_legendas/consulta_legendas_2008.zip,LEGENDAS"
        echo "$URL/consulta_vagas/consulta_vagas_2008.zip,VAGAS"
        #echo "$URL/prestacao_contas/prestacao_contas_2008.zip,PRESTACAO_CONTAS"
        ;;
    2006)
        echo "$URL/consulta_cand/consulta_cand_2006.zip,CANDIDATO"
        echo "$URL/bem_candidato/bem_candidato_2006.zip,BENS"
        echo "$URL/consulta_legendas/consulta_legendas_2006.zip,LEGENDAS"
        echo "$URL/consulta_vagas/consulta_vagas_2006.zip,VAGAS"
        #echo "$URL/prestacao_contas/prestacao_contas_2006.zip,PRESTACAO_CONTAS"
        ;;
    2004)
        echo "$URL/consulta_cand/consulta_cand_2004.zip,CANDIDATO"
        echo "$URL/consulta_legendas/consulta_legendas_2004.zip,LEGENDAS"
        echo "$URL/consulta_vagas/consulta_vagas_2004.zip,VAGAS"
        #echo "$URL/prestacao_contas/prestacao_contas_2004.zip,PRESTACAO_CONTAS"
        ;;
    2002)
        echo "$URL/consulta_cand/consulta_cand_2002.zip,CANDIDATO"
        echo "$URL/consulta_legendas/consulta_legendas_2002.zip,LEGENDAS"
        echo "$URL/consulta_vagas/consulta_vagas_2002.zip,VAGAS"
        #echo "$URL/prestacao_contas/prestacao_contas_2002.zip,PRESTACAO_CONTAS"
        ;;
    *)
        echo ""
        ;;
esac
