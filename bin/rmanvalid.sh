#/bin/bash 
ID=`id`
INST=`echo $ID| cut -d"(" -f2 | cut -d")" -f1 | cut -c2-`

cd /ots/rman_bkp/scripts/$INST
FILE=`ls -lrth | grep -i  "FULL" |  tail -1 | awk '{print $NF}'`

CONN=`head -2 $FILE`

( echo -e "$CONN \n resync catalog;" | rman ) > /tmp/resync.out

echo "====================== RMAN ==============="
cat /tmp/resync.out

grep "full resync complete" /tmp/resync.out


[[ $? -eq 0 ]] && echo "all ok" || echo "not ok"


