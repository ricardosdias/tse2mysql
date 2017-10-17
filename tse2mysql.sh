#!/bin/bash

###############################################################################
# This shell import TSE files into a MySQL database
###############################################################################

###############################################################################
# Script parameters
###############################################################################
#$1 - Year

# Check if the number of parameters are correct
if [ $# -ne 1 ]
then
    echo "The number of parameters are not correct!"
    echo "Must call: ./import.sh Year"
    exit 1
fi
YEAR=$1

# Check if the year is valid
case $YEAR in
    2002|2004|2006|2008|2010|2012|2014|2016)
        ;;
    *)
        echo "$YEAR is not a valid year!"
        echo "Vou must report a year that there were general elections after 2002"
        echo "Valid years are: 2002, 2004, 2006, 2008, 2010, 2012, 2014 and 2016"
        exit 2
        ;;
esac

# load config files
BASEDIR=$(pwd)
for env_file in $BASEDIR/config/*.env
do
    source $env_file
done

# load tse files names and types
TSE_FILES=$(. $BASEDIR/tse_files.sh $YEAR)


log() {
    message=$1
    if [ $VERBOSE == true ]; then
        echo $(date "+%Y-%m-%d %T") "- $message"
    fi
}


download() {
    url="$1"
    download_dir="$2"
    log "Downloading $url ..."
    wget -nc "$url" -P $download_dir
    log "Download done."
}


uncompress(){
    file_name="$1"
    download_dir="$2"
    unzip_file_dir="$3"

    file_path="$download_dir/$file_name"

    log "uncompressing $file_path ..."
    unzip $file_path -d $unzip_file_dir
    log "uncompress done."
}


import2mysql() {
    file_type="$1"
    unzip_file_dir="$2"

    #for tse_file in $unzip_file_dir/*.txt
    find $unzip_file_dir \( -name "*.txt" -o -name "*.csv" -o -name "*.TXT" -o -name "*.CSV" \) | while read tse_file
    do
        log "Importing $file_type file: $tse_file ..."
        case $file_type in
            "CANDIDATO")
                $BASEDIR/mysql_scripts/candidatos.sh $YEAR $tse_file
                ;;
            "BENS")
                $BASEDIR/mysql_scripts/bens.sh $YEAR $tse_file
                ;;
            "LEGENDAS")
                $BASEDIR/mysql_scripts/legendas.sh $YEAR $tse_file
                ;;
            "VAGAS")
                $BASEDIR/mysql_scripts/vagas.sh $YEAR $tse_file
                ;;
            "PRESTACAO_CONTAS")
                $BASEDIR/mysql_scripts/prestacao_contas.sh $YEAR $tse_file
                ;;

            *)
                echo ""
                ;;
        esac
        log "Import done."
    done
}

clean_tse_file() {
    unzip_file_dir="$1"

    #for tse_file in $unzip_file_dir/*.txt
    find $unzip_file_dir \( -name "*.txt" -o -name "*.csv" -o -name "*.TXT" -o -name "*.CSV" \) | while read tse_file
    do
        log "Cleaning $tse_file file..."
        LC_ALL=C sed -i'.bak' -e 's/#NULO#//g; s/#NE#//g; s/#NI#//g; s/#NULO//g' $tse_file
        log "Cleaning done."
    done
}


download_dir="$DIR_DOWNLOAD/$YEAR"
mkdir -p $tse_file_dir
log "BEGIN SCRIPT: importing TSE files of $YEAR ..."
for i in ${TSE_FILES[@]}; do
    IFS=,  read url file_type <<< "$i"
    download $url $download_dir

    file=${url##*/}
    unzip_file_dir="$download_dir/$file_type"
    mkdir -p $unzip_file_dir
    uncompress $file $download_dir $unzip_file_dir

    clean_tse_file $unzip_file_dir

    import2mysql $file_type $unzip_file_dir
done
log "END SCRIPT: import done."

exit 0
