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

#********* SUMMARY REPORT START *********#

echo '</table>
<h3> Below is the detailed summary: </h3>
<table style="width:100%">' >> $REPORT

#Instance Name
echo "<tr><td>Instance Name</td><td>" >> $REPORT
cat $PREDIR/instance_name.out| sed 's/$/<br>/'  >> $REPORT
echo "</td></tr>" >> $REPORT

#workflow_mailer_status.out
echo "<tr><td>Workflow Mailer Status</td><td>" >> $REPORT
cat $PREDIR/workflow_mailer_status.out| sed 's/$/<br>/'  >> $REPORT
echo "</td></tr>" >> $REPORT

#workflow_component_value.out
echo "<tr><td>Workflow Component Value</td><td>" >> $REPORT
cat $PREDIR/workflow_component_value.out| sed 's/$/<br>/'  >> $REPORT
echo "</td></tr>" >> $REPORT

#workflow_count.out
echo "<tr><td>Workflow Count</td><td>" >> $REPORT
cat $PREDIR/workflow_count.out| sed 's/$/<br>/'  >> $REPORT
echo "</td></tr>" >> $REPORT

#workflow_system_admin_value.out
echo "<tr><td>Workflow System Administrator Value '*'</td><td>" >> $REPORT
cat $PREDIR/workflow_system_admin_value.out| sed 's/$/<br>/'  >> $REPORT
echo "</td></tr>" >> $REPORT

#fnd_conc_req_value.out
echo "<tr><td>FND Concurrent Requests Value</td><td>" >> $REPORT
cat $PREDIR/fnd_conc_req_value.out| sed 's/$/<br>/'  >> $REPORT
#echo "<object data="$PREDIR/fnd_conc_req_value.out" type="text/plain"></object>" >> $REPORT
echo "</td></tr>" >> $REPORT

#spfile.out
echo "<tr><td>spfile</td><td>" >> $REPORT
cat $PREDIR/spfile.out| sed 's/$/<br>/'>> $REPORT
echo "</td></tr>" >> $REPORT

#archive.out
echo "<tr><td>Archive Destination</td><td>" >> $REPORT
cat $PREDIR/archive.out| sed 's/$/<br>/'>> $REPORT
echo "</td></tr>" >> $REPORT

#dba_services
echo "<tr><td>dba_services</td><td>" >> $REPORT
cat $PREDIR/dba_services.out| sed 's/$/<br>/'>> $REPORT
echo "</td></tr>" >> $REPORT

#srvctl status service
echo "<tr><td>srvctl status service</td><td>" >> $REPORT
cat $PREDIR/srvctl_status_service.out| sed 's/$/<br>/'>> $REPORT
echo "</td></tr>" >> $REPORT

#lsnrctl status
echo "<tr><td>lsnrctl status</td><td>" >> $REPORT
cat $PREDIR/lsnrctl.out| sed 's/$/<br>/'>> $REPORT
echo "</td></tr>" >> $REPORT

#Drop Extra Undo Tablespace
echo "<tr><td>Drop Extra Undo Tablespace</td><td>" >> $REPORT
cat $PREDIR/drop_undo_tblspce.out| sed 's/$/<br>/'>> $REPORT
echo "</td></tr>" >> $REPORT

#Undo Tablespace
echo "<tr><td>Undo Tablespace</td><td>" >> $REPORT
cat $PREDIR/undo.out| sed 's/$/<br>/'>> $REPORT
echo "</td></tr>" >> $REPORT

#redo_log_files.out
echo "<tr><td>Redo Log Files</td><td>" >> $REPORT
cat $PREDIR/redo_log_files.out| sed 's/$/<br>/'>> $REPORT
echo "</td></tr>" >> $REPORT

#control_file.out
echo "<tr><td>Control File</td><td>" >> $REPORT
cat $PREDIR/control_file.out| sed 's/$/<br>/'>> $REPORT
echo "</td></tr>" >> $REPORT

#open_links.out
echo "<tr><td>Open Links</td><td>" >> $REPORT
cat $PREDIR/open_links.out| sed 's/$/<br>/'>> $REPORT
echo "</td></tr>" >> $REPORT

#XXINT_MIGRATION_DIR.out
echo "<tr><td>XXINT_MIGRATION_DIR Path Value</td><td>" >> $REPORT
cat $PREDIR/XXINT_MIGRATION_DIR.out| sed 's/$/<br>/'>> $REPORT
echo "</td></tr>" >> $REPORT

#utl_file_dir
echo "<tr><td>utl_file_dir</td><td>" >> $REPORT
#cat $PREDIR/utl_file_dir.out| sed 's/$/<br>/'>> $REPORT
echo "</td></tr>" >> $REPORT

#APPLPTMP Value
echo "<tr><td>APPLPTMP Value</td><td>" >> $REPORT
cat $PREDIR/APPLPTMP.out| sed 's/$/<br>/' >> $REPORT
echo "</td></tr>" >> $REPORT

#libobk.so
echo "<tr><td>libobk.so </td><td>" >> $REPORT
cat $PREDIR/libobk.out| sed 's/$/<br>/' >> $REPORT
echo "</td></tr>" >> $REPORT

#Block Change Tracking
echo "<tr><td>Block Change Tracking</td><td>" >> $REPORT
cat $PREDIR/block_change_tracking.out| sed 's/$/<br>/' >> $REPORT
echo "</td></tr>" >> $REPORT

#Invalid Count
echo "<tr><td>Invalid Count</td><td>" >> $REPORT
cat $PREDIR/invalid_count.out| sed 's/$/<br>/' >> $REPORT
echo "</td></tr>" >> $REPORT

#opatch lsinv
echo "<tr><td>opatch lsinv</td><td>" >> $REPORT
cat $PREDIR/opatch.out| sed 's/$/<br>/' >> $REPORT
echo "</td></tr>" >> $REPORT

#dba_db_links
echo "<tr><td>dba_db_links</td><td>" >> $REPORT
cat $PREDIR/dba_db_links.out| sed 's/$/<br>/' >> $REPORT
echo "</td></tr>" >> $REPORT

#fnd_concurrent_queues
echo "<tr><td>fnd_concurrent_queues</td><td>" >> $REPORT
#cat $PREDIR/fnd_concurrent_queues.out| sed 's/$/<br>/' >> $REPORT
echo "</td></tr>" >> $REPORT

#fnd_profile_option_values
echo "<tr><td>fnd_profile_option_values</td><td>" >> $REPORT
#cat $PREDIR/fnd_profile_option_values.out| sed 's/$/<br>/'>> $REPORT
echo "</td></tr>" >> $REPORT

#dba_directories
echo "<tr><td>dba_directories</td><td>" >> $REPORT
#cat $PREDIR/dba_directories.out| sed 's/$/<br>/'>> $REPORT
echo "</td></tr>" >> $REPORT

#RMAN Validation
echo "<tr><td>RMAN Validation</td><td>" >> $REPORT
cat $PREDIR/rman_validation.out|sed 's/$/<br>/'>> $REPORT
echo "</td></tr>" >> $REPORT

#adop -status
echo "<tr><td>adop -status</td><td>" >> $REPORT
cat $PREDIR/adop_status.out | sed 's/$/<br>/' >> $REPORT
echo "</td></tr>" >> $REPORT

#fnd_logins.out
echo "<tr><td>FND Logins</td><td>" >> $REPORT
cat $PREDIR/fnd_logins.out| sed 's/$/<br>/' >> $REPORT
echo "</td></tr>" >> $REPORT

#global_name.out
echo "<tr><td>Global Name</td><td>" >> $REPORT
cat $PREDIR/global_name.out| sed 's/$/<br>/' >> $REPORT
echo "</td></tr>" >> $REPORT

#email_status_0.out
echo "<tr><td>All Email Status Should Be 0</td><td>" >> $REPORT
cat $PREDIR/email_status_0.out| sed 's/$/<br>/' >> $REPORT
echo "</td></tr>" >> $REPORT

#db_links.out
echo "<tr><td>DB Links</td><td>" >> $REPORT
cat $PREDIR/db_links.out| sed 's/$/<br>/' >> $REPORT
echo "</td></tr>" >> $REPORT

#profile_option_prod.out
echo "<tr><td>Profile Options Having Production Entries</td><td>" >> $REPORT
cat $PREDIR/profile_option_prod.out| sed 's/$/<br>/' >> $REPORT
echo "</td></tr>" >> $REPORT

#conc_manager_processes.out
echo "<tr><td>Concurrent Manager Processes</td><td>" >> $REPORT
#cat $PREDIR/conc_manager_processes.out| sed 's/$/<br>/' >> $REPORT
echo "</td></tr>" >> $REPORT

#conc_mngr_PSnodes.out
echo "<tr><td>Concurrent Manager Primary and Secondary Nodes</td><td>" >> $REPORT
#cat $PREDIR/conc_mngr_PSnodes.out| sed 's/$/<br>/' >> $REPORT
echo "</td></tr>" >> $REPORT

#XDO_config_table.out
echo "<tr><td>XDO Config Table</td><td>" >> $REPORT
cat $PREDIR/XDO_config_table.out| sed 's/$/<br>/' >> $REPORT
echo "</td></tr>" >> $REPORT

#site_name.out
echo "<tr><td>Site Name</td><td>" >> $REPORT
cat $PREDIR/site_name.out| sed 's/$/<br>/' >> $REPORT
echo "</td></tr>" >> $REPORT

#patch_context_file.out
echo "<tr><td>Patch Context File</td><td>" >> $REPORT
cat $PREDIR/patch_context_file.out| sed 's/$/<br>/' >> $REPORT
echo "</td></tr>" >> $REPORT

#vertex_setup_check.out
echo "<tr><td>Vertex Setup Check</td><td>" >> $REPORT
cat $PREDIR/vertex_setup_check.out| sed 's/$/<br>/' >> $REPORT
echo "</td></tr>" >> $REPORT

#ITSS Portal Value
echo "<tr><td>ITSS Portal Value</td><td>" >> $REPORT
cat $PREDIR/itss_portal.out | sed 's/$/<br>/'>> $REPORT
echo "</td></tr>" >> $REPORT
echo "</table>
</body>
</html>" >> $REPORT


#********* SUMMARY REPORT END *********#

#********* EMAIL REPORT *********#

./bin/sendmail.pl $INST "Pre" $REPORT $PREDIR

