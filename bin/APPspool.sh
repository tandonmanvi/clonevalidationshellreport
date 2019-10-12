set lines 300 pages 7000
spool /ots/clone_patch/AUTO_TEST/validation/Inst_Details/$INSTNAME/pre/fnd_concurrent_queues.out
set lines 300 pages 6000
col NODE_NAME for a30
col NODE_NAME2 for a30
col CONCURRENT_QUEUE_NAME for a30
col TARGET_NODE for a30
Select control_code,target_node,node_name,node_name2,CONCURRENT_QUEUE_NAME from fnd_concurrent_queues;
spool off;

spool /ots/clone_patch/AUTO_TEST/validation/Inst_Details/$INSTNAME/pre/fnd_profile_option_values.out
set lines 300 pages 5500
select distinct profile_option_id, profile_option_value from fnd_profile_option_values where profile_option_value like '%http%';
spool off;

spool /ots/clone_patch/AUTO_TEST/validation/Inst_Details/$INSTNAME/pre/workflow_mailer_status.out
select fsc.COMPONENT_NAME,fsc.STARTUP_MODE,fsc.COMPONENT_STATUS from APPS.FND_CONCURRENT_QUEUES_VL fcq, apps.fnd_svc_components fsc where fsc.concurrent_queue_id = fcq.concurrent_queue_id(+) order by COMPONENT_STATUS , STARTUP_MODE , COMPONENT_NAME;
spool off;

spool /ots/clone_patch/AUTO_TEST/validation/Inst_Details/$INSTNAME/pre/workflow_component_value.out
col VALUE for a40
select p.parameter_name,v.parameter_value value
from apps.fnd_svc_comp_param_vals_v v,
apps.fnd_svc_comp_params_b p,
apps.fnd_svc_components c
where c.component_type = 'WF_MAILER'
and v.component_id = c.component_id
and v.parameter_id = p.parameter_id
and p.parameter_name in
('OUTBOUND_SERVER', 'INBOUND_SERVER','TEST_ADDRESS',
'ACCOUNT', 'FROM', 'NODENAME', 'REPLYTO')
order by p.parameter_name;
spool off;

spool /ots/clone_patch/AUTO_TEST/validation/Inst_Details/$INSTNAME/pre/workflow_count.out
select count(*) WF_NOTIFICATIONS from apps.wf_notifications;
spool off;

spool /ots/clone_patch/AUTO_TEST/validation/Inst_Details/$INSTNAME/pre/workflow_system_admin_value.out
select text from apps.wf_resources where name='WF_ADMIN_ROLE';
spool off;

spool /ots/clone_patch/AUTO_TEST/validation/Inst_Details/$INSTNAME/pre/fnd_conc_req_value.out
select count(*) FND_CONCURRENT_REQUESTS from applsys.fnd_concurrent_requests;
spool off;

spool /ots/clone_patch/AUTO_TEST/validation/Inst_Details/$INSTNAME/pre/fnd_logins.out
select count(*) FND_LOGINS from applsys.fnd_logins;
spool off;

spool /ots/clone_patch/AUTO_TEST/validation/Inst_Details/$INSTNAME/pre/global_name.out
col GLOBAL_NAME for a15
select PROPERTY_VALUE GLOBAL_NAME from database_properties where PROPERTY_NAME like '%GLOBAL%';
spool off;

spool /ots/clone_patch/AUTO_TEST/validation/Inst_Details/$INSTNAME/pre/email_status_0.out
select ( select count(*) from AP.AP_SUPPLIER_SITES_ALL  where email_address not like 'CLIMATE%')as AP_SUPPLIER_SITES_ALL, (select count(*) from APPLSYS.FND_USER where email_address not like 'CLIMATE%')as  FND_USER , (select count(*) from AR.HZ_CONTACT_POINTS  where email_address not like 'CLIMATE%') as HZ_CONTACT_POINTS, (select count(*) from AR.HZ_PARTIES where email_address not like 'CLIMATE%') as HZ_PARTIES , (select count(*) from apps.per_people_f where email_address not like 'CLIMATE%') as PER_PEOPLE_F , (select count(*) from apps.po_vendor_sites_all where email_address not like 'CLIMATE%') as PO_VENDOR_SITES_ALL, (select count(*) from apps.ap_supplier_sites_all where remittance_email not like 'CLIMATE%') as AP_SUPPLIER_SITES_ALL, (select count(*) from apps.IBY_EXTERNAL_PAYEES_ALL where REMIT_ADVICE_EMAIL not like 'CLIMATE%') as IBY_EXTERNAL_PAYEES_ALL , (select count(*) from apps.WF_LOCAL_USERS where email_address not like 'CLIMATE%') as WF_LOCAL_USERS from dual ;
spool off;

spool /ots/clone_patch/AUTO_TEST/validation/Inst_Details/$INSTNAME/pre/db_links.out
select 'To be verified in Flora' from dual;
col M2A_DBLINK for a20
col a2m_dblink for a20
select instance_id,m2a_dblink,a2m_dblink from apps.mrp_ap_apps_instances;
spool off;

spool /ots/clone_patch/AUTO_TEST/validation/Inst_Details/$INSTNAME/pre/msc_apps_instances.out
select 'To be verified in Frank' from dual;
col M2A_DBLINK for a50
col A2M_DBLINK for a50
select INSTANCE_ID, APPS_LRN, INSTANCE_CODE, M2A_DBLINK, A2M_DBLINK,-1,1,1 from apps.msc_apps_instances; 
spool off;

spool /ots/clone_patch/AUTO_TEST/validation/Inst_Details/$INSTNAME/pre/profile_option_prod.out
@/ots/scripts/clone_sanity/profile_option_prod.sql
spool off;

spool /ots/clone_patch/AUTO_TEST/validation/Inst_Details/$INSTNAME/pre/conc_manager_processes.out
@/ots/scripts/clone_sanity/manager_status.sql
spool off;

spool /ots/clone_patch/AUTO_TEST/validation/Inst_Details/$INSTNAME/pre/conc_mngr_PSnodes.out
@/ots/scripts/clone_sanity/manager_nodes.sql
spool off;

spool /ots/clone_patch/AUTO_TEST/validation/Inst_Details/$INSTNAME/pre/XDO_config_table.out
select VALUE from xdo_config_values where value like '%tmp%';
spool off;

spool /ots/clone_patch/AUTO_TEST/validation/Inst_Details/$INSTNAME/pre/site_name.out
select profile_option_value from fnd_profile_option_values where lower(profile_option_value) like '%clone%';
spool off;

spool /ots/clone_patch/AUTO_TEST/validation/Inst_Details/$INSTNAME/pre/patch_context_file.out
col NAME for a25 
col VERSION for a25 
col PATH for a130 
SELECT name,version,path from applsys.fnd_oam_context_files where name not in ('TEMPLATE','METADATA')and (status is null or status !='H') and EXTRACTVALUE(XMLType(TEXT),'//file_edition_type')='patch' and CTX_TYPE = 'A';
spool off;

spool /ots/clone_patch/AUTO_TEST/validation/Inst_Details/$INSTNAME/pre/vertex_setup_check.out
exec vertexoicquoexample('SALE',1) ;
spool off;

