


select SPCT_QF_NO from
--PDESMSAM
ACPPRGHD where
 --hlth_ins_etps_nm = '이상형'
 rownum <10
 and pt_no = '00953094'

;;

select * from PDESMSAM where rownum < 10
and kor_nm = '이상형'

