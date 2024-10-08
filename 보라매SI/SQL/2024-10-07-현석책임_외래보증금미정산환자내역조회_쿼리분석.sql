


SELECT K.BSC_ADDR||' '||K.DTL_ADDR||' ('||K.POST_NO||')'
           FROM PCTPCPTD K        -- 전남대 환자연락처정보테이블
               ,CCCCCSTE X
          WHERE -- K.PT_NO = A.PT_NO
 --           AND K.HSP_TP_CD = A.HSP_TP_CD
--            AND TRUNC(SYSDATE) BETWEEN K.AVL_STR_DT AND K.AVL_END_DT             -- 유효종료일자 AVL_END_DT
            --AND
            X.COMN_GRP_CD  = '23A'
            AND X.DTRL2_NM     = 'ADDR'
            AND X.COMN_CD      = K.CTAD_TP_CD
            AND ROWNUM = 1
;;

          ) PT_ADDR
;;

SELECT Z.TEL_NO
           FROM PCTPCPTD Z
          WHERE --Z.PT_NO = A.PT_NO
--            AND Z.HSP_TP_CD = A.HSP_TP_CD
             Z.CTAD_TP_CD = '00'
            AND ROWNUM = 1
