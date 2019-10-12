#!/usr/bin/expect

set timeout 120
set login [lindex $argv 0]
set pw [lindex $argv 1]
set addr [lindex $argv 2]
set ouser [lindex $argv 3]
spawn ssh -q -t -o StrictHostKeyChecking=no -o CheckHostIP=no $login@$addr
expect "$login@$addr\'s password:"
send "$pw\r"
expect -re {[#>$] ?$} { send "/usr/bin/sudo -iu o$ouser\r" }
expect "*?: " { send "$pw\r" }
expect -re {[#>$] ?$} { send "export INSTNAME=$ouser\r"}

expect -re {[#>$] ?$} { send "opatch lsinventory|tail\r"}
expect -re {[#>$] ?$} { send "ls -lrth \$ORACLE_HOME/lib/libobk.so \r"} 
expect -re {[#>$] ?$} { send "srvctl status service -d $ouser \r"}
expect -re {[#>$] ?$} { send "lsnrctl status $ouser \r"}
expect -re {[#>$] ?$} { send "ksh /ots/clone_patch/AUTO_TEST/checklist/bin/rmanvalid.sh\r"} 
expect -re {[#>$] ?$} { send "sqlplus / as sysdba \r"} 
expect -re {[#>$] ?$} { send "@/ots/clone_patch/AUTO_TEST/validation/bin/DBspool_Post.sh \r"}
expect -re {SQL> ?$} { send "exit;\r"}
exit
