/* ASIS ���� */
Select
csubcd_nm
,cncl_dte
,case when a.cncl_dte is not null and a.cncl_cd in ('07' ,'08','09' ) then 'N' ||  ' ('|| c.csubcd_nm  ||')'    /* ���ο���  */
			            when a.cncl_dte is null  then   'Y' end aprv_yn
from  aphipassmt a, cccodest c
where rownum <100;

/* ���ڵ��?�� ��� ��¥�� ���� �� ���� */
SELECT cncl_cd   /*��һ���*/    FROM APHIPASSMT WHERE
cncl_cd in ('07' ,'08','09' ) AND ROWNUM <100
                      

EXEC :IN_FROM_DATE := '2023-03-01';
EXEC :IN_TO_DATE := '2024-07-10' ;

/* 11��  :
��û����(dmd_no),
ȯ�ڹ�ȣ(dmd_acpt_no),

ȯ�ڸ�,
�ֹι�ȣ,

���ο���(dmd_pact_tp_cd) ,
ȯ�ڱ���(DMD_TP_CD),

��������(ù ����),
��������(������ ����),

ī��ȸ��,
ī�� ������,
ī���ȣ*/

-- <sql id="HIS.PA.AC.PE.PS.HIPASSMOBILEAPPROVALMNG">
EXEC :IN_FROM_DATE := '2023-03-01';
EXEC :IN_TO_DATE := '2024-07-10' ;

SELECT /*HIS.PA.AC.PE.PS.HIPASSMOBILEAPPROVALMNG*/

       TO_CHAR(A.APLC_DT,'YYYY-MM-DD')                AS APLC_DT  /* ��û���� */
     , A.PT_NO                                        PT_NO       /* ȯ�ڹ�ȣ */
	   , B.PT_NM                                        PT_NM       /* ȯ�ڸ� */
     , PLS_DECRYPT_B64_ID(A.APCT_RRN, 800)            AS APCT_RRN /* �ֹι�ȣ */

     ,DECODE(CNCL_DT,NULL,'Y','N' )                   SMSS_PSB_YN /* ���ο��� */

     , B.PME_CLS_CD                                   PME_CLS_CD  /* ȯ�ڱ��� */
     , TO_CHAR(A.APY_STR_DT, 'YYYY-MM-DD')            APY_STR_DT  /* �������� */
     , A.APY_END_DT                                   APY_END_DT  /* �������� */
     , A.CARD_CMP_NM                                  CARD_CMP_NM /* ī�� ȸ�� */
     , A.APCT_NM                                      APCT_NM     /* ī�� ������ */
	   , PLS_DECRYPT_B64_ID(A.CARD_NO, 100)             AS CARD_NO  /* ī���ȣ */

  FROM ACPETHCD A
     , PCTPCPAM B
 WHERE A.PT_NO = B.PT_NO
   AND A.APLC_DT BETWEEN TO_DATE(:IN_FROM_DATE,'YYYY-MM-DD')
                     AND TO_DATE(:IN_TO_DATE,'YYYY-MM-DD')
;
-- </sql>

-- ASIS �ڵ�
case when a.cncl_dte is not null and a.cncl_cd in ('07' ,'08','09' ) then 'N' ||  ' ('|| c.csubcd_nm  ||')'
     when a.cncl_dte is null  then 'Y' end aprv_yn
/* A.��� ���ڰ� NULL�� �ƴϰ�, A.��� �ڵ尡 07 08 09�� -> 'N' + C.�����ڵ�
   A.��� ���ڰ� NULL�� �ƴϸ� -> 'Y' */;


select *
from ACPETHCD

where
 rownum <100;

APLC_CCRC_YN NOT IN('Y')
