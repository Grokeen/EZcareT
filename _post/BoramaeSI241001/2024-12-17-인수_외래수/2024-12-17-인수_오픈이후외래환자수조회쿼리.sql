



SELECT *
  FROM EMBUMENT
 WHERE MENU_CD =
'AC_HIS.PA.AC.PE.CF.UI_/PSmsChrSnd.xaml';


select * from dba_all_source
where rownum < 10



;


select case grouping(pt_no) || grouping(pact_id) || grouping(med_dt) when '111' then ''
                                                                     when '000' then pt_no
        end      as pt_no
      ,case grouping(pt_no) || grouping(pact_id) || grouping(med_dt) when '111' then ''
                                                                     when '000' then pact_id
        end      as pact_id
      ,case grouping(pt_no) || grouping(pact_id) || grouping(med_dt) when '111' then '합계'
                                                                     when '000' then to_char(med_dt,'yyyy-mm-dd')
        end      as med_dt
      , case grouping(pt_no) || grouping(pact_id) || grouping(med_dt) when '111' then to_char(count(*))
                                                                      when '000' then to_char(count(*))

        end      as cnt

from acpprodm
where 1=1
  and MED_DT  between '20240907' and '20241217'
  and MED_YN = 'Y'
group by rollup(pt_no , pact_id, med_dt)

union

select '' as pt_no
      ,'' as pact_id
      ,'' as med_dt
      ,'' as cnt
from dual

;
select *
from acpprodm
where 1=1
  and pt_no = '00018854'
  and MED_DT  between '20240907' and '20241217'
  and MED_YN = 'Y'



