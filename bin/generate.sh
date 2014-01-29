#!/bin/bash
withoutdownload=$1
mkdir -p data/tableau data/json
if ! test "$withoutdownload" ; then
bash bin/download_table.sh
fi
cat data/tableau/*table | bash bin/parse_table.sh > data/final/tableau.csv
cat data/final/tableau.csv | awk -F ';' '{print $1";"$3}' | sort -k 1,1 -t ';' > data/final/tableau_selected.csv
if ! test "$withoutdownload" ; then
bash bin/download_json.sh
fi
python bin/json2csv.py data/json/*json* | tail -n +2 | sort -k 1,1 -t ';' | sed 's/;$//' | uniq > data/final/json.csv
join -t ';' -1 1 -2 1 data/final/json.csv data/final/tableau_selected.csv | sort -k 6,6 -t ';' > data/final/reserve_sans_nosdeputes.csv
curl -s http://www.nosdeputes.fr/deputes/csv | sort -k 19,19 -t ';' > data/deputes.csv
echo "ID_DEPUTE_AN;ID_SUBVENTION;NOM_BENEFICIAIRE;DESCRIPTION_SUBVENTION;ADRESSE_BENEFICIAIRE;PROGRAMME_PJL_FINANCE;CIVILITE;NOM_DEPUTE_AN;PRENOM_DEPUTE_AN;DEPARTEMENT_CIRCONSCRIPTION_AN;GROUPE_AN;MONTANT_SUBVENTION;ID_NOSDEPUTES;PRENOM_NOM_DEPUTE_NOSDEPUTES;NOM_DEPUTE_NOSDEPUTES;PRENOM_DEPUTE_NOSDEPUTES;SEXE_DEPUTE;DATE_NAISSANCE_DEPUTE;LIEU_NAISSANCE_DEPUTE;ID_DEPARTEMENT;DEPARTEMENT_NOSDEPUTES;NUMERO_CIRCONSCRIPTION;DATE_DEBUT_MANDAT;DATE_FIN_MANDAT;MANDAT_CLOS;GROUPE_SIGLE;PARTI_RATTACHEMENT_FINANCIER;PROFESSION;PLACE_HEMICYCLE;URL_DEPUTE_AN;SLUG_NOSDEPUTES;URL_DEPUTE_NOSDEPUTES;API_NOSDEPUTES;NB_MANDATS;" > data/final/reserve.csv
join -a 1 -t ';' -1 6 -2 19 data/final/reserve_sans_nosdeputes.csv  data/deputes.csv | 
  sed 's/^\(;.*;\(Groupe \([^;]\+\)\);.*\)$/\2\1;;;;;;;;;;;;;;\3;;;;;;;;/' |
  sed "s/^\(;.*;Présidence de l'Assembl.*\)$/Présidence de l'Assemblée (Réserve institutionnelle)\1;;;;;;;;;;;;;;;;;;;;;;/" |
  sort -n -t ';' -k 2,2 >> data/final/reserve.csv
awk -F ";" 'BEGIN { OFS = ";"} {print $2,$3,$4,$5,$6,$12,$14,$1,$13,$15,$16,$17,$18,$19,$20,21,$22,$23,$24,$25,$26,$27,$28,$29,$30,$31,$32,$33,$34}' data/final/reserve.csv > data/final/reserve-assemblee-2013.csv
