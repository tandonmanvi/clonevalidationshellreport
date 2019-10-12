#!/bin/bash  
INST=`echo $1 | tr '[:upper:]' '[:lower:]'`
USER=`grep NamedUser ./Inst_Details/$INST/data/DB_PARAMS | cut -f2 -d=`
PASS=`grep EnunxPass ./Inst_Details/$INST/data/DB_PARAMS | cut -c11- | base64 --decode`
host=`cat ./Inst_Details/$INST/data/DATABASE_NODES`
WINODE=`grep TGT_WEB_HOST ./Inst_Details/$INST/data/InstDetails | cut -f2 -d=`
DAPPSPWD=`grep DAppsPass ./Inst_Details/$INST/data/APP_PARAMS | cut -f2 -d=`
./bin/DBssh_Post.sh $USER $PASS $host $INST > ./Inst_Details/$INST/post/sql.out
./bin/ITSS.sh  $USER $PASS $host $INST > ./Inst_Details/$INST/post/itss_portal_temp.out
./bin/APPssh_Post.sh $USER $PASS $host $INST $WINODE $DAPPSPWD > ./Inst_Details/$INST/post/apps.out
./bin/Separate_Post.sh $INST
./bin/SendMail_Post.sh $INST $2
