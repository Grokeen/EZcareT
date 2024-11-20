SELECT APY_STR_DT,APY_END_DT,PCOR_ICD10_CD_CNTE , PCOR_ICD10_DUP_SEQ_CD, FSR_DTM, FSR_PRGM_NM, A.*
  FROM ACPPRGCD A  -- 중증진료확인증정보 (타병원 등록정보)
 WHERE PT_NO = '00057027'
;

SELECT APY_STR_DT,APY_END_DT, APLC_ICD10_CD_CNTE, APLC_ICD10_DUP_SEQ_CD, FSR_DTM, FSR_PRGM_NM, A.*
  FROM ACPPRGHD A -- 중증산정특례신청서정보 (본원등록정보)
 WHERE PT_NO = '00057027'
;
---------------

SELECT APY_STR_DT,APY_END_DT,PCOR_ICD10_CD_CNTE , PCOR_ICD10_DUP_SEQ_CD, FSR_DTM, FSR_PRGM_NM, A.*
  FROM ACPPRGCD A  -- 중증진료확인증정보 (타병원 등록정보)
 WHERE PT_NO = '01722860'
;

SELECT APY_STR_DT,APY_END_DT, APLC_ICD10_CD_CNTE, APLC_ICD10_DUP_SEQ_CD, FSR_DTM, FSR_PRGM_NM, A.*
  FROM ACPPRGHD A -- 중증산정특례신청서정보 (본원등록정보)
 WHERE PT_NO = '01722860'
;



---------------------------------------------------------------------------------------------------------



select * from MRDDRECM
where pt_no = '00725586'
  AND LST_YN = 'Y'
  AND REC_DTM > '2024-10-01'
  
  
---------------------------------------------------------------------------------------------------------
