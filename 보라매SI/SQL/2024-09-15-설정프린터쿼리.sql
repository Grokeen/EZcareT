--주전역설정정보: 환경설정 기본값.
select *
from CNLCRMGD
where mscr_tp_cd = 'AC';    --원무 환경설정 구분코드: AC

--사용자주전역설정정보: 사용자가 직접 설정한, 원무 환경설정 정보.
select
   '2층 원무 ' || decode(substr(a.lsh_ip_addr,11,3),110,'8',111,'7',112,'6',113,'5',114,'4',115,'3',116,'2',117,'1')  as seat
   ,b.item_nm
   ,a.*
from CNLCRUGD a
   ,CNLCRCDD b
where a.item_cd = b.item_cd
   and a.mscr_tp_cd = 'AC'
   and b.item_cd like '%PA%'
   and substr(a.lsh_ip_addr,11,3) between 110 and 117
   and to_char(a.lsh_dtm , 'yyyymmdd') > 20240906
   order by a.lsh_ip_addr desc   , a.usr_stf_no , a.item_cd
;





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
      WHERE UPPER(TEXT) LIKE '%CNLCRUGD%'
         or UPPER(TEXT) LIKE '%CNLCRCDD%'
      ) a group by           owner, DBA_NAME

;



select DBA_NAME,count(*) as cnt from (
SELECT
         QUERYID AS DBA_NAME
         ,QUERYTEXT AS TEXT
      FROM FXQUERYSTORE
      WHERE (UPPER(querytext) LIKE '%CNLCRUGD%'
         or UPPER(querytext) LIKE '%CNLCRCDD%')
         and  
) group by DBA_NAME

