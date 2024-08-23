-- 그냥 유추하자
PROCEDURE pc_ap_HipssMobileAprv_Upd (  in_gubun          in  varchar2
		                                 , in_pt_no    		   in  varchar2     -- 환자 번호
		                                 , in_fstinst_dte    in  varchar2     -- 
		                                 , in_token_no_skp   in  varchar2     --
		                                 , in_wk_id          in  varchar2 )
; 



-- 시이바르 없는 거 아니야?
SELECT OWNER, OBJECT_NAME
FROM ALL_PROCEDURES
WHERE OBJECT_TYPE = 'PROCEDURE'
AND OBJECT_NAME = 'pc_ap_HipssMobileAprv_Upd';

-- ASIS 프로시저 검색하기(실패)
SELECT OBJECT_NAME
FROM pc_ap_HipssMobileAprv_Upd
WHERE OBJECT_TYPE = 'PROCEDURE';
