#!/bin/bash

INST="$1"
PREDIR="./Inst_Details/$INST/pre/" 
POSTDIR="./Inst_Details/$INST/post/"
REPORT="./Inst_Details/$INST/summary.html"
MAIL="XYZ@gmail.com"

printok(){ 
echo '<td style="background-color:green;color:white" >OK</td></tr>' >> $REPORT
}

printnok(){ 
echo '<td style="background-color:red;color:white" >NOT OK</td></tr>' >> $REPORT
}

echo "<!DOCTYPE html>
<html>
<head>
<style>
table {
  border-collapse: collapse;
}

table, th, td {
  border: 1px solid black;
}
</style>
</head>
<body><h2>$INST</h2>
" > $REPORT

if [[ $2 != "pre" ]]; then
 
echo "  
<table style="width:50%">
  <tr>
    <th>Parameter</th>
    <th>Status</th>  
  </tr>">> $REPORT

#*********COMPARISON REPORT START*********#

#workflow_component_value.out
echo "<tr>
    <td>Workflow Component Value</td>" >> $REPORT
ST=`diff $PREDIR/workflow_component_value.out $POSTDIR/workflow_component_value.out`
[[ $ST == "" ]] && printok || printnok

#workflow_count.out
echo "<tr>
    <td>Workflow Count</td>" >> $REPORT
#ST=`diff $PREDIR/workflow_count.out $POSTDIR/workflow_count.out`
ST=`tail -2 $POSTDIR/workflow_count.out`
echo "<td> $ST </td></tr>" >> $REPORT

#workflow_system_admin_value.out
echo "<tr>
    <td>Workflow System Administrator Value '*'</td>" >> $REPORT
ST=`diff $PREDIR/workflow_system_admin_value.out $POSTDIR/workflow_system_admin_value.out`
[[ $ST == "" ]] && printok || printnok

#fnd_conc_req_value.out
echo "<tr>
    <td>FND Concurrent Requests Value</td>" >> $REPORT
#ST=`diff $PREDIR/fnd_conc_req_value.out $POSTDIR/fnd_conc_req_value.out`
ST=`tail -2 $POSTDIR/fnd_conc_req_value.out`
echo "<td> $ST </td></tr>" >> $REPORT

#dba_services.out
echo "<tr>
<td>dba_services</td>" >> $REPORT
ST=`diff $PREDIR/dba_services.out $POSTDIR/dba_services.out`
[[ $ST == "" ]] && printok || printnok

#archive.out
echo "<tr>
<td>Archive Destination</td>" >> $REPORT
ST=`diff <(head -n 3 $PREDIR/archive.out) <(head -n 3 $POSTDIR/archive.out)`
[[ $ST == "" ]] && printok || printnok

#srvctl_status_service.out
echo "<tr>
<td>srvctl status service</td>" >> $REPORT
ST=`diff $PREDIR/srvctl_status_service.out $POSTDIR/srvctl_status_service.out`
[[ $ST == "" ]] && printok || printnok


#drop_undo_tblspce.out
echo "<tr>
<td>Drop Extra Undo Tablespace</td>" >> $REPORT
ST=`diff $PREDIR/drop_undo_tblspce.out $POSTDIR/drop_undo_tblspce.out`
[[ $ST == "" ]] && printok || printnok

#Open Links should not be 0
echo "<tr>
    <td>Open Links</td>" >> $REPORT
#ST='diff $PREDIR/open_links.out $POSTDIR/open_links.out'
#[[ $ST == "" ]] && printok || printnok
ST=`grep open_links $POSTDIR/open_links.out`
echo "<td> $ST </td></tr>" >> $REPORT


#XXINT_MIGRATION_DIR Path Value
echo "<tr>
    <td>XXINT_MIGRATION_DIR Path Value</td>" >> $REPORT
ST=`diff $PREDIR/XXINT_MIGRATION_DIR.out $POSTDIR/XXINT_MIGRATION_DIR.out`
[[ $ST == "" ]] && printok || printnok

#APPLPTMP.out
echo "<tr>
<td>APPLPTMP Value</td>" >> $REPORT
ST=`diff $PREDIR/APPLPTMP.out $POSTDIR/APPLPTMP.out`
[[ $ST == "" ]] && printok || printnok

#block_change_tracking.out
echo "<tr>
<td>Block Change Tracking</td>" >> $REPORT
ST=`diff $PREDIR/block_change_tracking.out $POSTDIR/block_change_tracking.out`
[[ $ST == "" ]] && printok || printnok

#opatch.out
echo "<tr>
<td>opatch lsinv</td>" >> $REPORT
ST=`diff $PREDIR/opatch.out  $POSTDIR/opatch.out`
[[ $ST == "" ]] && printok || printnok

#dba_db_links.out
echo "<tr>
<td>dba_db_links</td>" >> $REPORT
ST=`diff $PREDIR/dba_db_links.out $POSTDIR/dba_db_links.out`
#[[ $ST == "" ]] && printok || printnok
echo "<td> Check Manually </td></tr>" >> $REPORT

#rman_validation.out
echo "<tr>
<td>RMAN Validation</td>" >> $REPORT
ST=`tail -1 $POSTDIR/rman_validation.out|sed  's/\x0D$//'`
[[ $ST == "all ok" ]] && printok || printnok
: '
#adop_status.out
echo "<tr>
<td>adop -status</td>" >> $REPORT
#ST='diff $PREDIR/adop_status.out $POSTDIR/adop_status.out'
#[[ $ST == "" ]] && printok || printnok
MASTER=`grep -i master $POSTDIR/adop_status.out  |cut -d' ' -f1`
grep $MASTER /ots/scripts/ots_support/oem/clone/'echo $INST| tr [:upper:] [:lower:]'/InstDetails | grep TGT_WEB_HOST > /dev/null && printok || printnok
'
#FND Logins more than 50, please check
echo "<tr>
<td>FND Logins</td>" >> $REPORT
#ST=`diff $PREDIR/fnd_logins.out $POSTDIR/fnd_logins.out`
ST=`grep -Eo '[0-9]{1,4}' $POSTDIR/fnd_logins.out`
echo "<td> $ST (Please check if value is more than 50) </td></tr>" >> $REPORT


#Global Name
echo "<tr>
<td>Global Name</td>" >> $REPORT
ST=`diff $PREDIR/global_name.out $POSTDIR/global_name.out`
[[ $ST == "" ]] && printok || printnok

#All Email Status Should Be 0
echo "<tr>
<td>All Email Status Should Be 0</td>" >> $REPORT
#ST=`diff <(head -n 4 $PREDIR/email_status_0.out) <(head -n 4 $POSTDIR/email_status_0.out)`
#[[ $ST == "" ]] && printok || printnok
OUT=`grep -Eo '[0-9]' $POSTDIR/email_status_0.out | grep -v 0`
[[ $OUT == '' ]] &&  printok || printnok

#XDO Config Table
echo "<tr>
<td>XDO Config Table</td>" >> $REPORT
ST=`diff $PREDIR/XDO_config_table.out $POSTDIR/XDO_config_table.out`
[[ $ST == "" ]] && printok || printnok

#*********COMPARISON REPORT END*********#
fi

#********* SUMMARY REPORT START *********#

echo '</table>
<h3> Below is the detailed summary: </h3>
<table style="width:100%">' >> $REPORT

#Instance Name
echo "<tr><td>Instance Name</td><td>" >> $REPORT
cat $POSTDIR/instance_name.out| sed 's/$/<br>/'  >> $REPORT
echo "</td></tr>" >> $REPORT

#workflow_mailer_status.out
echo "<tr><td>Workflow Mailer Status</td><td>" >> $REPORT
cat $POSTDIR/workflow_mailer_status.out| sed 's/$/<br>/'  >> $REPORT
echo "</td></tr>" >> $REPORT

#workflow_component_value.out
echo "<tr><td>Workflow Component Value</td><td>" >> $REPORT
cat $POSTDIR/workflow_component_value.out| sed 's/$/<br>/'  >> $REPORT
echo "</td></tr>" >> $REPORT

#workflow_count.out
echo "<tr><td>Workflow Count</td><td>" >> $REPORT
cat $POSTDIR/workflow_count.out| sed 's/$/<br>/'  >> $REPORT
echo "</td></tr>" >> $REPORT

#workflow_system_admin_value.out
echo "<tr><td>Workflow System Administrator Value '*'</td><td>" >> $REPORT
cat $POSTDIR/workflow_system_admin_value.out| sed 's/$/<br>/'  >> $REPORT
echo "</td></tr>" >> $REPORT

#fnd_conc_req_value.out
echo "<tr><td>FND Concurrent Requests Value</td><td>" >> $REPORT
cat $POSTDIR/fnd_conc_req_value.out| sed 's/$/<br>/'  >> $REPORT
echo "</td></tr>" >> $REPORT

#spfile.out
echo "<tr><td>spfile</td><td>" >> $REPORT
cat $POSTDIR/spfile.out| sed 's/$/<br>/'>> $REPORT
echo "</td></tr>" >> $REPORT

#archive.out
echo "<tr><td>Archive Destination</td><td>" >> $REPORT
cat $POSTDIR/archive.out| sed 's/$/<br>/'>> $REPORT
echo "</td></tr>" >> $REPORT

#dba_services
echo "<tr><td>dba_services</td><td>" >> $REPORT
cat $POSTDIR/dba_services.out| sed 's/$/<br>/'>> $REPORT
echo "</td></tr>" >> $REPORT

#srvctl status service
echo "<tr><td>srvctl status service</td><td>" >> $REPORT
cat $POSTDIR/srvctl_status_service.out| sed 's/$/<br>/'>> $REPORT
echo "</td></tr>" >> $REPORT

#lsnrctl status
echo "<tr><td>lsnrctl status</td><td>" >> $REPORT
cat $POSTDIR/lsnrctl.out| sed 's/$/<br>/'>> $REPORT
echo "</td></tr>" >> $REPORT

#Drop Extra Undo Tablespace
echo "<tr><td>Drop Extra Undo Tablespace</td><td>" >> $REPORT
cat $POSTDIR/drop_undo_tblspce.out| sed 's/$/<br>/'>> $REPORT
echo "</td></tr>" >> $REPORT

#Undo Tablespace
echo "<tr><td>Undo Tablespace</td><td>" >> $REPORT
cat $POSTDIR/undo.out| sed 's/$/<br>/'>> $REPORT
echo "</td></tr>" >> $REPORT

#redo_log_files.out
echo "<tr><td>Redo Log Files</td><td>" >> $REPORT
cat $POSTDIR/redo_log_files.out| sed 's/$/<br>/'>> $REPORT
echo "</td></tr>" >> $REPORT

#control_file.out
echo "<tr><td>Control File</td><td>" >> $REPORT
cat $POSTDIR/control_file.out| sed 's/$/<br>/'>> $REPORT
echo "</td></tr>" >> $REPORT

#open_links.out
echo "<tr><td>Open Links</td><td>" >> $REPORT
cat $POSTDIR/open_links.out| sed 's/$/<br>/'>> $REPORT
echo "</td></tr>" >> $REPORT

#XXINT_MIGRATION_DIR.out
echo "<tr><td>XXINT_MIGRATION_DIR Path Value</td><td>" >> $REPORT
cat $POSTDIR/XXINT_MIGRATION_DIR.out| sed 's/$/<br>/'>> $REPORT
echo "</td></tr>" >> $REPORT

#utl_file_dir
echo "<tr><td>utl_file_dir</td><td>" >> $REPORT
#cat $POSTDIR/utl_file_dir.out| sed 's/$/<br>/'>> $REPORT
echo "</td></tr>" >> $REPORT

#APPLPTMP Value
echo "<tr><td>APPLPTMP Value</td><td>" >> $REPORT
cat $POSTDIR/APPLPTMP.out| sed 's/$/<br>/' >> $REPORT
echo "</td></tr>" >> $REPORT

#libobk.so
echo "<tr><td>libobk.so </td><td>" >> $REPORT
cat $POSTDIR/libobk.out| sed 's/$/<br>/' >> $REPORT
echo "</td></tr>" >> $REPORT

#Block Change Tracking
echo "<tr><td>Block Change Tracking</td><td>" >> $REPORT
cat $POSTDIR/block_change_tracking.out| sed 's/$/<br>/' >> $REPORT
echo "</td></tr>" >> $REPORT

#Invalid Count
echo "<tr><td>Invalid Count</td><td>" >> $REPORT
cat $POSTDIR/invalid_count.out| sed 's/$/<br>/' >> $REPORT
echo "</td></tr>" >> $REPORT

#opatch lsinv
echo "<tr><td>opatch lsinv</td><td>" >> $REPORT
cat $POSTDIR/opatch.out| sed 's/$/<br>/' >> $REPORT
echo "</td></tr>" >> $REPORT

#dba_db_links
echo "<tr><td>dba_db_links</td><td>" >> $REPORT
cat $POSTDIR/dba_db_links.out| sed 's/$/<br>/' >> $REPORT
echo "</td></tr>" >> $REPORT

#fnd_concurrent_queues
echo "<tr><td>fnd_concurrent_queues</td><td>" >> $REPORT
#cat $POSTDIR/fnd_concurrent_queues.out| sed 's/$/<br>/' >> $REPORT
echo "</td></tr>" >> $REPORT

#fnd_profile_option_values
echo "<tr><td>fnd_profile_option_values</td><td>" >> $REPORT
#cat $POSTDIR/fnd_profile_option_values.out| sed 's/$/<br>/'>> $REPORT
echo "</td></tr>" >> $REPORT

#dba_directories
echo "<tr><td>dba_directories</td><td>" >> $REPORT
#cat $POSTDIR/dba_directories.out| sed 's/$/<br>/'>> $REPORT
echo "</td></tr>" >> $REPORT

#RMAN Validation
echo "<tr><td>RMAN Validation</td><td>" >> $REPORT
cat $POSTDIR/rman_validation.out|sed 's/$/<br>/'>> $REPORT
echo "</td></tr>" >> $REPORT

#adop -status
echo "<tr><td>adop -status</td><td>" >> $REPORT
cat $PREDIR/adop_status.out | sed 's/$/<br>/' >> $REPORT
echo "</td></tr>" >> $REPORT

#fnd_logins.out
echo "<tr><td>FND Logins</td><td>" >> $REPORT
cat $POSTDIR/fnd_logins.out| sed 's/$/<br>/' >> $REPORT
echo "</td></tr>" >> $REPORT

#global_name.out
echo "<tr><td>Global Name</td><td>" >> $REPORT
cat $POSTDIR/global_name.out| sed 's/$/<br>/' >> $REPORT
echo "</td></tr>" >> $REPORT

#email_status_0.out
echo "<tr><td>All Email Status Should Be 0</td><td>" >> $REPORT
cat $POSTDIR/email_status_0.out| sed 's/$/<br>/' >> $REPORT
echo "</td></tr>" >> $REPORT

#db_links.out
echo "<tr><td>DB Links</td><td>" >> $REPORT
cat $POSTDIR/db_links.out| sed 's/$/<br>/' >> $REPORT
echo "</td></tr>" >> $REPORT

#profile_option_prod.out
echo "<tr><td>Profile Options Having Production Entries</td><td>" >> $REPORT
cat $POSTDIR/profile_option_prod.out| sed 's/$/<br>/' >> $REPORT
echo "</td></tr>" >> $REPORT

#conc_manager_processes.out
echo "<tr><td>Concurrent Manager Processes</td><td>" >> $REPORT
#cat $POSTDIR/conc_manager_processes.out| sed 's/$/<br>/' >> $REPORT
echo "</td></tr>" >> $REPORT

#conc_mngr_PSnodes.out
echo "<tr><td>Concurrent Manager Primary and Secondary Nodes</td><td>" >> $REPORT
#cat $POSTDIR/conc_mngr_PSnodes.out| sed 's/$/<br>/' >> $REPORT
echo "</td></tr>" >> $REPORT

#XDO_config_table.out
echo "<tr><td>XDO Config Table</td><td>" >> $REPORT
cat $POSTDIR/XDO_config_table.out| sed 's/$/<br>/' >> $REPORT
echo "</td></tr>" >> $REPORT

#site_name.out
echo "<tr><td>Site Name</td><td>" >> $REPORT
cat $POSTDIR/site_name.out| sed 's/$/<br>/' >> $REPORT
echo "</td></tr>" >> $REPORT

#patch_context_file.out
echo "<tr><td>Patch Context File</td><td>" >> $REPORT
cat $POSTDIR/patch_context_file.out| sed 's/$/<br>/' >> $REPORT
echo "</td></tr>" >> $REPORT

#vertex_setup_check.out
echo "<tr><td>Vertex Setup Check</td><td>" >> $REPORT
cat $POSTDIR/vertex_setup_check.out| sed 's/$/<br>/' >> $REPORT
echo "</td></tr>" >> $REPORT

#ITSS Portal Value
echo "<tr><td>ITSS Portal Value</td><td>" >> $REPORT
cat $POSTDIR/itss_portal.out | sed 's/$/<br>/'>> $REPORT
echo "</td></tr>" >> $REPORT
echo "</table>
</body>
</html>" >> $REPORT


#********* SUMMARY REPORT END *********#

#********* EMAIL REPORT *********#
#cat <<"EOF" - $REPORT   | /usr/sbin/sendmail -t
#To: XYZ@gmail.com
#Subject: Post Clone Report
#Content-Type: text/html
#EOF
./bin/sendmail.pl $INST "Post" $REPORT $PREDIR
