




-- PtContactOrganizationMng


SELECT *
  FROM EMBUMENT
 WHERE --MENU_NM LIKE '%진단검%'
   menu_cd like '%PtContactOrganizationMng%'
;



/* ----------------------------------------------------------- */
/* ----------------------------------------------------------- */
/* ----------------------------------------------------------- */
/**/select *   /* TOBE에 사용빈도 확인 */                       /**/
/**/  from dba_source                                        /**/
/**/ where owner like 'X___'                                 /**/
/**/   and upper(text) like '%' ||:COLUMNNAME  ||'%'         /**/
/**/;                                                        /**/
/* ----------------------------------------------------------- */
/* ----------------------------------------------------------- */
/* ----------------------------------------------------------- */
/**/EXEC :COMMENTCONTANT := '';                              /**/
/**/EXEC :COLUMNNAME := 'PA_RMK_CNTE';                              /**/
/* ----------------------------------------------------------- */
/* ----------------------------------------------------------- */
/* ----------------------------------------------------------- */
/**/select     /*테이블 컬럼 사용 빈도 확인*/                    /**/
/**/   A.OWNER,                                              /**/
/**/   A.TABLE_NAME,                                         /**/
/**/   A.COLUMN_NAME,                                        /**/
/**/   A.COMMENTS,                                           /**/
/**/   B.DATA_TYPE ,                                         /**/
/**/   B.DATA_LENGTH                                         /**/
/**/from                                                     /**/
/**/   dba_col_comments A,                                   /**/
/**/   dba_tab_columns B                                     /**/
/**/where                                                    /**/
/**/   A.comments like '%'|| :COMMENTCONTANT ||'%'           /**/
/**/   AND A.column_name like '%'|| :COLUMNNAME ||'%'        /**/
/**/   AND A.TABLE_NAME like '%'|| :TABLENAME ||'%'          /**/
/**/   AND A.OWNER = B.OWNER                                 /**/
/**/   AND A.TABLE_NAME = B.TABLE_NAME                       /**/
/**/   AND A.COLUMN_NAME = B.COLUMN_NAME                     /**/
/**/;                                                        /**/
/* ----------------------------------------------------------- */
/* ----------------------------------------------------------- */
/* ----------------------------------------------------------- */
/**/EXEC :COMMENTCONTANT := '';                              /**/
/**/EXEC :COLUMNNAME := 'TEXT';                              /**/
/**/EXEC :TABLENAME := 'DBA_SOURCE';                              /**/
/* ----------------------------------------------------------- */
/* ----------------------------------------------------------- */
/* ----------------------------------------------------------- */


                                       select owner, DBA_NAME,count(*) as cnt  from
                                      (
SELECT
         OWNER
         ,NAME AS DBA_NAME
         ,TYPE
         ,LINE
         ,TEXT
      FROM
         DBA_SOURCE
      WHERE UPPER(TEXT) LIKE '%J002%') a group by           owner, DBA_NAME

;
SELECT
         NULL AS OWNER
         ,QUERYID AS DBA_NAME
         ,QUERYTEXT AS TEXT
      FROM FXQUERYSTORE
where upper(querytext) like '%J002%';


-----------------------------------------------------------------------------------



select * from ACPPROOE where  corg_cd = 'j001';


select *from ACPPRODM where CORG_CD = 'J001';
