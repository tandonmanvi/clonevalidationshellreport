#!/usr/bin/expect

set timeout 15

set login [lindex $argv 0]
set addr [lindex $argv 2]
set pw [lindex $argv 1]
set ouser [lindex $argv 3]
spawn ssh -q -o stricthostkeychecking=no -t $login@HOSTNAME
expect "$login@HOSTNAME\'s password:"
send "$pw\r"
expect -re {[#>$] ?$} { send "/usr/bin/sudo -iu itss_portal\r" }
expect "*?: " { send "$pw\r" }
expect -re {[#>$] ?$} { send "grep $ouser /itss_portalap/home/itss_portal/content/new_instance_list.txt\r"} 
expect -re {[#>$] ?$} { send "exit\r" }
exit

