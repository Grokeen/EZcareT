



SELECT
          OWNER
         ,NAME AS DBA_NAME
         ,TYPE
         ,LINE
         ,TEXT

      FROM
         DBA_SOURCE
      WHERE UPPER(TEXT) LIKE '%aimipbam%'
       and OWNER = 'XBIL'



;

SELECT

         QUERYID AS DBA_NAME
         ,QUERYTEXT AS TEXT
      FROM FXQUERYSTORE
      WHERE UPPER(QUERYTEXT) LIKE '%AIMIPBAM%'
      AND UPPER(QUERYTEXT) LIKE '%결핵%'
         AND UPPER(QUERYID) NOT LIKE 'B_%'
        ;
