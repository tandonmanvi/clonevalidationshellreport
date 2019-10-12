#!/bin/bash  
INST=`echo $1 | tr '[:upper:]' '[:lower:]'`
USER=`grep NamedUser ./Inst_Details/$INST/data/DB_PARAMS | cut -f2 -d=`
PASS=`grep EnunxPass ./Inst_Details/$INST/data/DB_PARAMS | cut -c11- | base64 --decode`
host=`cat ./Inst_Details/$INST/data/DATABASE_NODES`
WINODE=`grep TGT_WEB_HOST ./Inst_Details/$INST/data/InstDetails | cut -f2 -d=`
DAPPSPWD=`grep DAppsPass ./Inst_Details/$INST/data/APP_PARAMS | cut -f2 -d=`
./bin/DBssh.sh $USER $PASS $host $INST > ./Inst_Details/$INST/pre/sql.out
./bin/ITSS.sh  $USER $PASS $host $INST > ./Inst_Details/$INST/pre/itss_portal_temp.out
./bin/APPssh.sh $USER $PASS $host $INST $WINODE $DAPPSPWD > ./Inst_Details/$INST/pre/apps.out
./bin/Separate.sh $INST
./bin/SendMail_pre.sh $INST $2
