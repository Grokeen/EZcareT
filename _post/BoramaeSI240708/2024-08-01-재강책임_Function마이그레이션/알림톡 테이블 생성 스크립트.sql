CREATE TABLE HTOK.AM2X_SUBMIT (
				MSG_ID NUMBER,
				SUBJECT VARCHAR2(40) NULL,
				MSG_TYPE NUMBER(2) NOT NULL,
				MSG_TYPE_SECOND NUMBER(2) DEFAULT 0 NOT NULL ,
				MSG_TYPE_THIRD NUMBER(2) DEFAULT 0 NOT NULL ,
				STATUS NUMBER(1) DEFAULT 0 NULL,
				SCHEDULE_TIME VARCHAR2(16) NOT NULL,
				SUBMIT_TIME VARCHAR2(16) NOT NULL,
				MESSAGE VARCHAR2(4000) NULL,
				CALLBACK_NUM VARCHAR2(20) NOT NULL,
				RCPT_DATA VARCHAR2(20) NOT NULL,
				FILE_COUNT NUMBER(1) DEFAULT 0 NULL,
				FILE_NAME1 VARCHAR2(128) NULL,
				FILE_NAME2 VARCHAR2(128) NULL,
				FILE_NAME3 VARCHAR2(128) NULL,
				CDR_ID VARCHAR2(20) NULL,
				RESULT NUMBER(5) NULL,
				RCS_RESULT NUMBER(5) NULL,
				KKO_RESULT NUMBER(5) NULL,
				RESULT_DESC VARCHAR2(200) NULL,
				DELIVER_TIME VARCHAR2(16) NULL,
				REPORT_RECV_TIME VARCHAR2(16) NULL,
				TELCOINFO VARCHAR2(4) NULL,
				FAIL_SEND VARCHAR2(1) DEFAULT 'N' NULL,
				K_TMPLCODE VARCHAR2(30) NULL,
				K_MESSAGE VARCHAR2(4000) NULL,
				K_BUTTON VARCHAR2(4000) NULL,
				K_ADFLAG VARCHAR2(1) DEFAULT 'N' NULL,
				K_SENDERKEY VARCHAR2(40) NULL,
				R_MESSAGEBASEID VARCHAR2(40) NULL,
				R_BODY VARCHAR2(4000) NULL,
				R_BUTTON VARCHAR2(4000) NULL,
				R_HEADER NUMBER(1) NULL,
				R_FOOTER VARCHAR2(20) NULL,
				R_COPYALLOWED VARCHAR2(1) DEFAULT 'N' NULL,
				R_QUERYID VARCHAR2(60) NULL,
				RESERVED01 VARCHAR2(50) NULL,
				RESERVED02 VARCHAR2(50) NULL,
				RESERVED03 VARCHAR2(50) NULL,
				KISA_ORIG_CODE VARCHAR2(9) NULL,
				R_AGENCYID VARCHAR2(60) NULL,
				R_AGENCYKEY VARCHAR2(256) NULL,
				R_BRANDKEY VARCHAR2(256) NULL,
				R_CDR_ID VARCHAR2(20) NULL,
		  		CONSTRAINT AM2X_SUBMIT_PK PRIMARY KEY (MSG_ID)
			);
            
CREATE TABLE HTOK.AM2X_SUBMIT_LOG (
				MSG_ID NUMBER NOT NULL,
				SUBJECT VARCHAR2(40) NULL,
				MSG_TYPE NUMBER(2) NOT NULL,
				MSG_TYPE_SECOND NUMBER(2) DEFAULT 0 NOT NULL ,
				MSG_TYPE_THIRD NUMBER(2) DEFAULT 0 NOT NULL ,
				STATUS NUMBER(1) DEFAULT 0 NULL,
				SCHEDULE_TIME VARCHAR2(16) NOT NULL,
				SUBMIT_TIME VARCHAR2(16) NOT NULL,
				MESSAGE VARCHAR2(4000) NULL,
				CALLBACK_NUM VARCHAR2(20) NOT NULL,
				RCPT_DATA VARCHAR2(20) NOT NULL,
				FILE_COUNT NUMBER(1) DEFAULT 0 NULL,
				FILE_NAME1 VARCHAR2(128) NULL,
				FILE_NAME2 VARCHAR2(128) NULL,
				FILE_NAME3 VARCHAR2(128) NULL,
				CDR_ID VARCHAR2(20) NULL,
				RESULT NUMBER(5) NULL,
				RCS_RESULT NUMBER(5) NULL,
				KKO_RESULT NUMBER(5) NULL,
				RESULT_DESC VARCHAR2(200) NULL,
				DELIVER_TIME VARCHAR2(16) NULL,
				REPORT_RECV_TIME VARCHAR2(16) NULL,
				TELCOINFO VARCHAR2(4) NULL,
				FAIL_SEND VARCHAR2(1) DEFAULT 'N' NULL,
				K_TMPLCODE VARCHAR2(30) NULL,
				K_MESSAGE VARCHAR2(4000) NULL,
				K_BUTTON VARCHAR2(4000) NULL,
				K_ADFLAG VARCHAR2(1) DEFAULT 'N' NULL,
				K_SENDERKEY VARCHAR2(40) NULL,
				R_MESSAGEBASEID VARCHAR2(40) NULL,
				R_BODY VARCHAR2(4000) NULL,
				R_BUTTON VARCHAR2(4000) NULL,
				R_HEADER NUMBER(1) NULL,
				R_FOOTER VARCHAR2(20) NULL,
				R_COPYALLOWED VARCHAR2(1) DEFAULT 'N' NULL,
				R_QUERYID VARCHAR2(60) NULL,
				RESERVED01 VARCHAR2(50) NULL,
				RESERVED02 VARCHAR2(50) NULL,
				RESERVED03 VARCHAR2(50) NULL,
				KISA_ORIG_CODE VARCHAR2(9) NULL,
				R_AGENCYID VARCHAR(60) NULL,
				R_AGENCYKEY VARCHAR(256) NULL,
				R_BRANDKEY VARCHAR(256) NULL,
				R_CDR_ID VARCHAR2(20) NULL
			);
            
			


-- INDEX			

CREATE INDEX IDX_AM2X_SUBMIT_1 ON HTOK.AM2X_SUBMIT(STATUS, MSG_TYPE, MSG_TYPE_SECOND, MSG_TYPE_THIRD);
CREATE INDEX IDX_AM2X_SUBMIT_2 ON HTOK.AM2X_SUBMIT(FAIL_SEND, SCHEDULE_TIME);
CREATE SEQUENCE AM2X_SUBMIT_SEQ START WITH 1 MAXVALUE 99999999999999999999 MINVALUE 1 CYCLE CACHE 20 NOORDER

CREATE INDEX IDX_AM2X_SUBMIT_LOG_1 ON HTOK.AM2X_SUBMIT_LOG(MSG_ID);
CREATE INDEX IDX_AM2X_SUBMIT_LOG_2 ON HTOK.AM2X_SUBMIT_LOG(MSG_TYPE, STATUS, SCHEDULE_TIME);
CREATE INDEX IDX_AM2X_SUBMIT_LOG_3 ON HTOK.AM2X_SUBMIT_LOG(REPORT_RECV_TIME, RESULT, RCS_RESULT, KKO_RESULT);
CREATE INDEX IDX_AM2X_SUBMIT_LOG_4 ON HTOK.AM2X_SUBMIT_LOG(RESERVED01, RESERVED02, RESERVED03);
CREATE INDEX IDX_AM2X_SUBMIT_LOG_5 ON HTOK.AM2X_SUBMIT_LOG(RESERVED03, SCHEDULE_TIME, RESERVED02);
CREATE INDEX IDX_AM2X_SUBMIT_LOG_6 ON HTOK.AM2X_SUBMIT_LOG(MSG_TYPE, SCHEDULE_TIME);

                

-- SYNONYM
CREATE PUBLIC SYNONYM AM2X_SUBMIT FOR HTOK.AM2X_SUBMIT; 
CREATE PUBLIC SYNONYM AM2X_SUBMIT_LOG FOR HTOK.AM2X_SUBMIT_LOG;  

--AUTHORITY                                        
GRANT SELECT,INSERT,UPDATE,DELETE ON HTOK.AM2X_SUBMIT     TO XBIL, XMED, XSUP, XGAB, XCOM;
GRANT SELECT,INSERT,UPDATE,DELETE ON HTOK.AM2X_SUBMIT_LOG TO XBIL, XMED, XSUP, XGAB, XCOM;