select xbil.FT_ACP_INSURANCE( '01389734'
                                       , 'AA'
                                       , TRUNC(SYSDATE))
                                       from dual;


 select count(*) from (                                                                                                                                  ;
select *
from ACPPEKST
where pt_no = '01389734'
)

;
select *
from all_source
where 1=1
and text like '%9801>키오스크 수납 불가합니다 창구에서 수납해주세요.%'
