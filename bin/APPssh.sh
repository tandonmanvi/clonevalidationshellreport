#!/usr/bin/expect

set timeout 140

set login [lindex $argv 0]
set addr [lindex $argv 2]
set pw [lindex $argv 1]
set user [lindex $argv 3]
set winode [lindex $argv 4]
set dappspwd [lindex $argv 5]
spawn ssh -q -t -o StrictHostKeyChecking=no -o CheckHostIP=no  $login@$winode
expect "$login@$winode\'s password:"
send "$pw\r"
expect -re {[#>$] ?$} { send "/usr/bin/sudo -iu a$user\r" }
expect "*?: " { send "$pw\r" }
expect -re {[#>$] ?$} { send "export INSTNAME=$user \r"}

expect -re {[#>$] ?$} { send "echo \$APPLPTMP\r"}
expect -re {[#>$] ?$} { send "adop -status\r"}
expect "Enter the APPS password:" { send "$dappspwd\r" }
#expect -re {[#>$] ?$} { send "id;date\r"}
expect -re {[#>$] ?$} { send "sqlplus apps/$dappspwd \r"} 
expect -re {[#>$] ?$} { send "\r"} 
expect -re {[#>$] ?$} { send "@/ots/clone_patch/AUTO_TEST/validation/bin/APPspool.sh \r"}
expect -re {SQL> ?$} { send "exit;\r"}
expect -re {[#>$] ?$} { send "chmod -R 777 /ots/clone_patch/AUTO_TEST/validation/Inst_Detail/$user \r"}
exit
