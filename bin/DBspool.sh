set lines 300 pages 6000
spool /ots/clone_patch/AUTO_TEST/validation/Inst_Details/$INSTNAME/pre/instance_name.out
select name from v$database;
spool off;

spool /ots/clone_patch/AUTO_TEST/validation/Inst_Details/$INSTNAME/pre/dba_db_links.out
set lines 300
set pages 5000
col DB_LINK for a30
col HOST for a60
col OWNER for a20
col USERNAME for a20
select * from dba_db_links;
spool off;

spool /ots/clone_patch/AUTO_TEST/validation/Inst_Details/$INSTNAME/pre/dba_directories.out
set pages 900
set lines 300
col OWNER for a45
col DIRECTORY_NAME for a45
col DIRECTORY_PATH for a45
col ORIGIN_CON_ID for a10
select * from DBA_DIRECTORIES ;
spool off;

spool /ots/clone_patch/AUTO_TEST/validation/Inst_Details/$INSTNAME/pre/dba_services.out
select SERVICE_ID,NAME from dba_services;
spool off;

spool /ots/clone_patch/AUTO_TEST/validation/Inst_Details/$INSTNAME/pre/block_change_tracking.out
select * from v$block_change_tracking;
spool off;

spool /ots/clone_patch/AUTO_TEST/validation/Inst_Details/$INSTNAME/pre/archive.out
archive log list
spool off;

spool /ots/clone_patch/AUTO_TEST/validation/Inst_Details/$INSTNAME/pre/utl_file_dir.out
sho parameter utl;
spool off;

spool /ots/clone_patch/AUTO_TEST/validation/Inst_Details/$INSTNAME/pre/spfile.out
sho parameter pfile;
spool off;

spool /ots/clone_patch/AUTO_TEST/validation/Inst_Details/$INSTNAME/pre/undo.out
sho parameter undo;
spool off;

spool /ots/clone_patch/AUTO_TEST/validation/Inst_Details/$INSTNAME/pre/drop_undo_tblspce.out
select 'drop tablespace '|| tb_drop || ' including contents and datafiles;' from (select tablespace_name tb_drop from DBA_TABLESPACES where CONTENTS='UNDO' MINUS select value tb_drop from SYS.GV_$PARAMETER where name = 'undo_tablespace');
spool off;

spool /ots/clone_patch/AUTO_TEST/validation/Inst_Details/$INSTNAME/pre/invalid_count.out
select count(*) from dba_objects where status='INVALID';
spool off;

spool /ots/clone_patch/AUTO_TEST/validation/Inst_Details/$INSTNAME/pre/redo_log_files.out
set lines 500
col MEMBER for a40 
Select * from v$logfile ;
spool off;

spool /ots/clone_patch/AUTO_TEST/validation/Inst_Details/$INSTNAME/pre/control_file.out
select name from v$controlfile ;
spool off;

spool /ots/clone_patch/AUTO_TEST/validation/Inst_Details/$INSTNAME/pre/open_links.out
col NAME for a25
col VALUE for a25
select name,value from v$parameter2 where name in ('open_links','audit_sys_operations','audit_trail','java_jit_enabled');
spool off;

spool /ots/clone_patch/AUTO_TEST/validation/Inst_Details/$INSTNAME/pre/XXINT_MIGRATION_DIR.out
Select directory_path from all_directories where directory_name ='XXINT_MIGRATION_DIR';
spool off;

