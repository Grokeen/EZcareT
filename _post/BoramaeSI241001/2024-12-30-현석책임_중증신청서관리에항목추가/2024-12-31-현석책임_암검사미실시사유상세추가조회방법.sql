
                               

select * from MRFMFORM
where mdfm_nm like '%산정특례%'
  and mdfm_fom_seq = '2'        ;

2002627	2
;

select *
from MRDDRECM
where mdfm_id = '2002627'
  and mdfm_fom_seq = '2'

;
SELECT *
 FROM MRFMFCID
WHERE 1=1
 AND MDFM_ID = '2002627'
 AND MDFM_FOM_SEQ = '2'
 AND MDFM_ELMT_ID IN ('8056', '8055')

 ;
