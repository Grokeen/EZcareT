SELECT *
  FROM ALL_SOURCE
;
        SELECT
         '외래예약메모' AS FINDING_NAME
         ,'ACPPERMH' AS FIND_TABLE_NAME
         ,OWNER
         ,NAME AS DBA_NAME
         ,TYPE
         ,LINE
         ,TEXT
      FROM
         DBA_SOURCE
      WHERE UPPER(TEXT) LIKE '%ACPPERMH%';



-- EQS 에서 PBAM과 PRQS를 같이 사용하는 SQL ID 찾는 쿼리
SELECT *
  FROM FXQUERYSTORE
 WHERE 1=1
--   AND UPPER(QUERYID) LIKE UPPER('%' || '.PA.' || '%')
   AND UPPER(QUERYTEXT) LIKE UPPER('%' || 'AIMIPBAM' || '%')
   AND UPPER(QUERYTEXT) LIKE UPPER('%' || 'AIMIPRQS' || '%')
   AND UPPER(QUERYID) NOT LIKE UPPER('B_' || '%')
   AND UPPER(QUERYID) NOT LIKE UPPER('%' || '.GN.' || '%')
--   AND UPPER(CREATEUSERID) LIKE 'PARKDAYEON'
 ORDER BY 1, CREATEDATE DESC
;


SELECT
         'ACPPRODM' AS FIND_TABLE_NAME
         ,OWNER
         ,NAME AS DBA_NAME
         ,TYPE
         ,LINE
         ,TO_CLOB(TEXT) AS TEXT/*VARCHAR2	4000*/
      FROM
         DBA_SOURCE
      WHERE UPPER(TEXT) LIKE '%ACPPRODM%'

      UNION ALL

      SELECT
         'ACPPRODH' AS FIND_TABLE_NAME
         ,NULL AS OWNER
         ,QUERYID AS DBA_NAME
         ,'EQS' AS TYPE
         ,NULL AS LINE
         ,QUERYTEXT AS TEXT /*CLOB	4000*/
      FROM FXQUERYSTORE
      WHERE UPPER(QUERYTEXT) LIKE '%ACPPRODH%'


 ;;;

/* ----------------------------------------------------------- */
/* ----------------------------------------------------------- */
/* ----------------------------------------------------------- */

          SELECT
   FINDING_NAME
   ,FIND_TABLE_NAME
   ,FIND_COLUMN_NAME
   ,FIND_COLUMN_COMMENT
   ,OWNER
   ,DBA_NAME
   ,TYPE
   ,COUNT(*)
FROM (
   SELECT
      '외래예약메모' AS FINDING_NAME
      ,FIND_TABLE_NAME
      ,'PA_RMK_CNTE' AS FIND_COLUMN_NAME
      ,'원무비고내용' AS FIND_COLUMN_COMMENT
      ,OWNER
      ,DBA_NAME
      ,TYPE
      ,LINE
   FROM(
      SELECT
         'ACPPERMH' AS FIND_TABLE_NAME
         ,OWNER
         ,NAME AS DBA_NAME
         ,TYPE
         ,LINE
         ,TEXT
      FROM
         DBA_SOURCE
      WHERE UPPER(TEXT) LIKE '%ACPPERMH%'

      UNION ALL

      SELECT
         'ACPPERMM' AS FIND_TABLE_NAME
         ,OWNER
         ,NAME AS DBA_NAME
         ,TYPE
         ,LINE
         ,TEXT
      FROM
         DBA_SOURCE
      WHERE UPPER(TEXT) LIKE '%ACPPERMM%'

      UNION ALL

      SELECT
         'ACPPERNH' AS FIND_TABLE_NAME
         ,OWNER
         ,NAME AS DBA_NAME
         ,TYPE
         ,LINE
         ,TEXT
      FROM
         DBA_SOURCE
      WHERE UPPER(TEXT) LIKE '%ACPPERNH%'

      UNION ALL

      SELECT
         'ACPPRARD' AS FIND_TABLE_NAME
         ,OWNER
         ,NAME AS DBA_NAME
         ,TYPE
         ,LINE
         ,TEXT
      FROM
         DBA_SOURCE
      WHERE UPPER(TEXT) LIKE '%ACPPRARD%'

      UNION ALL

      SELECT
         'ACPPRODH' AS FIND_TABLE_NAME
         ,OWNER
         ,NAME AS DBA_NAME
         ,TYPE
         ,LINE
         ,TEXT
      FROM
         DBA_SOURCE
      WHERE UPPER(TEXT) LIKE '%ACPPRODH%'

      UNION ALL

      SELECT
         'ACPPRODM' AS FIND_TABLE_NAME
         ,OWNER
         ,NAME AS DBA_NAME
         ,TYPE
         ,LINE
         ,TEXT
      FROM
         DBA_SOURCE
      WHERE UPPER(TEXT) LIKE '%ACPPRODM%'

      UNION ALL

      SELECT
         'ACPPERMH' AS FIND_TABLE_NAME
         ,NULL AS OWNER
         ,QUERYID AS DBA_NAME
         ,'EQS' AS TYPE
         ,NULL AS LINE
         ,QUERYTEXT AS TEXT
      FROM FXQUERYSTORE
      WHERE UPPER(QUERYTEXT) LIKE '%ACPPERMH%'

      UNION ALL

      SELECT
         'ACPPERMM' AS FIND_TABLE_NAME
         ,NULL AS OWNER
         ,QUERYID AS DBA_NAME
         ,'EQS' AS TYPE
         ,NULL AS LINE
         ,QUERYTEXT AS TEXT
      FROM FXQUERYSTORE
      WHERE UPPER(QUERYTEXT) LIKE '%ACPPERMM%'

      UNION ALL

      SELECT
         'ACPPERNH' AS FIND_TABLE_NAME
         ,NULL AS OWNER
         ,QUERYID AS DBA_NAME
         ,'EQS' AS TYPE
         ,NULL AS LINE
         ,QUERYTEXT AS TEXT
      FROM FXQUERYSTORE
      WHERE UPPER(QUERYTEXT) LIKE '%ACPPERNH%'

      UNION ALL

      SELECT
         'ACPPRARD' AS FIND_TABLE_NAME
         ,NULL AS OWNER
         ,QUERYID AS DBA_NAME
         ,'EQS' AS TYPE
         ,NULL AS LINE
         ,QUERYTEXT AS TEXT
      FROM FXQUERYSTORE
      WHERE UPPER(QUERYTEXT) LIKE '%ACPPRARD%'

      UNION ALL

      SELECT
         'ACPPRODH' AS FIND_TABLE_NAME
         ,NULL AS OWNER
         ,QUERYID AS DBA_NAME
         ,'EQS' AS TYPE
         ,NULL AS LINE
         ,QUERYTEXT AS TEXT
      FROM FXQUERYSTORE
      WHERE UPPER(QUERYTEXT) LIKE '%ACPPRODH%'

      UNION ALL

      SELECT
         'ACPPRODM' AS FIND_TABLE_NAME
         ,NULL AS OWNER
         ,QUERYID AS DBA_NAME
         ,'EQS' AS TYPE
         ,NULL AS LINE
         ,QUERYTEXT AS TEXT
      FROM FXQUERYSTORE
      WHERE UPPER(QUERYTEXT) LIKE '%ACPPRODM%'

      UNION ALL

      SELECT
         'MOMNMHPM' AS FIND_TABLE_NAME
         ,NULL AS OWNER
         ,QUERYID AS DBA_NAME
         ,'EQS' AS TYPE
         ,NULL AS LINE
         ,QUERYTEXT AS TEXT
      FROM FXQUERYSTORE
      WHERE UPPER(QUERYTEXT) LIKE '%MOMNMHPM%'

      UNION ALL

      SELECT
         'MOMNMHPM' AS FIND_TABLE_NAME
         ,OWNER
         ,NAME AS DBA_NAME
         ,TYPE
         ,LINE
         ,TEXT
      FROM
         DBA_SOURCE
      WHERE UPPER(TEXT) LIKE '%MOMNMHPM%')
   WHERE UPPER(TEXT) LIKE '%PA_RMK_CNTE%'


   UNION ALL


   SELECT
      '예약변경메모' AS FINDING_NAME
      ,FIND_TABLE_NAME
      ,'TEL_RSV_RSN_RM' AS FIND_COLUMN_NAME
      ,'전화예약사유비고' AS FIND_COLUMN_COMMENT
      ,OWNER
      ,DBA_NAME
      ,TYPE
      ,LINE
   FROM (
      SELECT
         'ACPPRODH' AS FIND_TABLE_NAME
         ,OWNER
         ,NAME AS DBA_NAME
         ,TYPE
         ,LINE
         ,TEXT
      FROM
         DBA_SOURCE
      WHERE UPPER(TEXT) LIKE '%ACPPRODH%'

      UNION ALL

      SELECT
         'ACPPRODM' AS FIND_TABLE_NAME
         ,OWNER
         ,NAME AS DBA_NAME
         ,TYPE
         ,LINE
         ,TEXT
      FROM
         DBA_SOURCE
      WHERE UPPER(TEXT) LIKE '%ACPPRODM%'

      UNION ALL

      SELECT
         'ACPPRODH' AS FIND_TABLE_NAME
         ,NULL AS OWNER
         ,QUERYID AS DBA_NAME
         ,'EQS' AS TYPE
         ,NULL AS LINE
         ,QUERYTEXT AS TEXT
      FROM FXQUERYSTORE
      WHERE UPPER(QUERYTEXT) LIKE '%ACPPRODH%'

      UNION ALL

      SELECT
         'ACPPRODM' AS FIND_TABLE_NAME
         ,NULL AS OWNER
         ,QUERYID AS DBA_NAME
         ,'EQS' AS TYPE
         ,NULL AS LINE
         ,QUERYTEXT AS TEXT
      FROM FXQUERYSTORE
      WHERE UPPER(QUERYTEXT) LIKE '%ACPPRODM%')

   WHERE UPPER(TEXT) LIKE '%TEL_RSV_RSN_RMK%')
WHERE OWNER LIKE 'X___'
GROUP BY
   FINDING_NAME
   ,FIND_TABLE_NAME
   ,FIND_COLUMN_NAME
   ,FIND_COLUMN_COMMENT
   ,OWNER
   ,DBA_NAME
   ,TYPE
;

/* ----------------------------------------------------------- */
/* ----------------------------------------------------------- */
/* ----------------------------------------------------------- */



;
select
   A.OWNER,
   A.TABLE_NAME,
   A.COLUMN_NAME,
   A.COMMENTS,
   B.DATA_TYPE ,
   B.DATA_LENGTH
from dba_col_comments A, dba_tab_columns B
 where A.COLUMN_NAME like '%TEL_RSV_RSN_RMK%'
     AND A.OWNER = B.OWNER
   AND A.TABLE_NAME = B.TABLE_NAME
   AND A.COLUMN_NAME = B.COLUMN_NAME

;
SELECT * FROM DBA_COL_COMMENTS WHERE COLUMN_NAME LIKE '%TEL_RSV_RSN_RMK%' AND OWNER LIKE 'H%';
SELECT * FROM DBA_TAB_COLUMNS WHERE COLUMN_NAME LIKE '%PA_RMK_CNTE%' AND OWNER LIKE 'H%';

;;

/**/EXEC :COMMENTCONTANT := '';
/**/EXEC :COLUMNNAME := 'PA_RMK_CNTE';
