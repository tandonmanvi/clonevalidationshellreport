#!/bin/bash
INSTNAME=$1
INSTNAME=`echo $INSTNAME | tr '[:upper:]' '[:lower:]'`
cd  /ots/clone_patch/AUTO_TEST/validation
mkdir -p ./Inst_Details/$INSTNAME/data 2> /dev/null
mkdir -p ./Inst_Details/$INSTNAME/pre 2> /dev/null
mkdir -p ./Inst_Details/$INSTNAME/post 2> /dev/null
chmod -R 777 ./Inst_Details/$INSTNAME/*
cp /ots/scripts/ots_support/oem/clone/$INSTNAME/DB_PARAMS ./Inst_Details/$INSTNAME/data/
cp /ots/scripts/ots_support/oem/clone/$INSTNAME/APP_PARAMS ./Inst_Details/$INSTNAME/data/
cp /ots/scripts/ots_support/oem/clone/$INSTNAME/DATABASE_NODES ./Inst_Details/$INSTNAME/data/
cp /ots/scripts/ots_support/oem/clone/$INSTNAME/InstDetails ./Inst_Details/$INSTNAME/data/
./bin/DbAppsDetails_Post.sh $INSTNAME
