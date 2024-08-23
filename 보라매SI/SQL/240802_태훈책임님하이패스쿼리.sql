--하이패스 등록 취소사유코드: ASIS 데이터 이관
---tobe
select *
from cccccltc   --공통그룹코드명세
where comn_grp_cd = '996';

select *
from cccccste   --공통그룹코드 상세
where comn_grp_cd = '996';

--asis 그룹코드 조회 - 개발기, 스테이징에선 아래와 같이 DBLink(@....) 붙여야 함. 운영기 조회시엔 빼도 됨.
select *
from asis_hcom.cccodest@dl_prod_mig
where ccd_typ = '996';