


select
*
from XBIL.TEMPSRIL2@DL_STGMIG
where
    pt_no = 'ERROR'
;;

-- 주민번호로 못 찾아서 환자번호가 ERROR로 나오는데
-- 하나씩 조회해서
-- 어떤 환자인지 찾아서 알려주면, 돌려서 업데이트 쳐주신다