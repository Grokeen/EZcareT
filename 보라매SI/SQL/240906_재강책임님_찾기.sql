SELECT *
  FROM ALL_SOURCE
;

SELECT OWNER
   , DBA_NAME
         ,TYPE
         ,LINE
         ,COUNT(*) CNT            FROM (
        SELECT
         OWNER
         ,NAME AS DBA_NAME
         ,TYPE
         ,LINE
         ,TEXT
      FROM
         ALL_SOURCE
         --DBA_SOURCE
      WHERE UPPER(TEXT) LIKE '%APIPRSVT%'
         AND UPPER(TEXT) LIKE '%RMK%'

      UNION ALL

        SELECT
         OWNER
         ,NAME AS DBA_NAME
         ,TYPE
         ,LINE
         ,TEXT
      FROM
         --ALL_SOURCE
         DBA_SOURCE
      WHERE UPPER(TEXT) LIKE '%APOPRSVT%'
         AND UPPER(TEXT) LIKE '%TEL_TALK%'   )
         GROUP BY
         OWNER
   , DBA_NAME
         ,TYPE
         ,LINE
