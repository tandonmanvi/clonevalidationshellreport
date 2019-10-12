#!/bin/bash

cd ./Inst_Details/$1/pre
cat ./sql.out | sed -n '/.*opatch lsinventory|tail/,/.*libobk.so.*/p'|head -n -1| perl -pe 's/\e([^\[\]]|\[.*?[a-zA-Z]|\].*?\a)//g' > opatch.out
cat ./sql.out | sed -n '/.*libobk.so/,/.*.so/p' | perl -pe 's/\e([^\[\]]|\[.*?[a-zA-Z]|\].*?\a)//g' > libobk.out
cat ./sql.out | sed -n '/.*srvctl status service.*/,/.*lsnrctl status.*/p' |head -n -1 |perl -pe 's/\e([^\[\]]|\[.*?[a-zA-Z]|\].*?\a)//g'> srvctl_status_service.out
cat ./sql.out | sed -n '/^LSNRCTL.*/,/.*rmanvalid.sh/p'| head -n -1|perl -pe 's/\e([^\[\]]|\[.*?[a-zA-Z]|\].*?\a)//g' > lsnrctl.out
cat ./sql.out | sed -n '/.*= RMAN =.*/,/.*as sysdba/p'|head -n -1|perl -pe 's/\e([^\[\]]|\[.*?[a-zA-Z]|\].*?\a)//g' > rman_validation.out
cat ./apps.out | sed -n '/.*echo $APPLPTMP/,/.*adop -status/p'| head -n -1 |grep -v APPLPTMP|perl -pe 's/\e([^\[\]]|\[.*?[a-zA-Z]|\].*?\a)//g' > APPLPTMP.out
dos2unix APPLPTMP.out 2> /dev/null
cat ./apps.out | sed -n '/.*adop -status/,/.*sqlplus apps.*/p'| head -n -1 |perl -pe 's/\e([^\[\]]|\[.*?[a-zA-Z]|\].*?\a)//g' > adop_status.out
cat ./itss_portal_temp.out | grep '~-~' > itss_portal.out
