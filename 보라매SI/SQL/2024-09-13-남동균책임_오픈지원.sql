--01558124
select *
from acpprodm
where pt_no = '01558124'
and med_Dt = '20231212'
;
select XBIL.FT_ACP_NRSEX_YN(MIF_CD,ORD_CD) a
,XBIL.FT_ACP_RSEX_YN(MIF_CD,ORD_CD) b
,a.*
from mooorexm a
where rpy_pact_id = 'MO01558124202312120000THIME001996'
;
select *
from xbil.acorderv
where pt_no = '01558124'
and orddate = '20231212'
;
select *
from MSGCRRVD
where pt_no = '01558124'
and ord_Dt = '20231212'
;


