--주전역설정정보: 환경설정 기본값.
select *
from CNLCRMGD
where mscr_tp_cd = 'AC';    --원무 환경설정 구분코드: AC

--사용자주전역설정정보: 사용자가 직접 설정한, 원무 환경설정 정보.
select *
from CNLCRUGD
where mscr_tp_cd = 'AC'
   and item_cd like '%PA%'

   and substr(lsh_ip_addr,11,3) between 110 and 117
   and to_char(lsh_dtm , 'yyyymmdd') > 20240906
   order by lsh_ip_addr   , usr_stf_no , item_cd
;

--개인설정항목코드정보: 이 코드가 뭐하는 놈인가...
select *
from CNLCRCDD
where mscr_tp_cd = 'AC';


