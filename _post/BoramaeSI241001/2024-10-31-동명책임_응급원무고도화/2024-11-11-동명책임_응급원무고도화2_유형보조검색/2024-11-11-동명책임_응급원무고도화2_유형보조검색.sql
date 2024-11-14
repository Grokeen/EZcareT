
;;
 ;;
EXEC :IN_CONDITION := '';  -- 유형보조 항목
EXEC :IN_CONDITION1 :='357';  -- 357 : 유형보조



;;;
 SELECT /* HIS.PA.CORE.SelectMCCodeCommonCode */
        A.COMN_CD    CDCODE
      , A.COMN_CD_NM CDVALUE
      , A.*
   FROM CCCCCSTE A
  WHERE A.COMN_GRP_CD =  :IN_CONDITION1
    --AND COMN_CD     =  :IN_CONDITION
    AND A.USE_YN      =  'Y'
    --AND A.COMN_CD_NM LIKE '%외국%';;


;;;


SELECT /* HIS.PA.CORE.SelectMCCodeUNION */
       A.POB_NO   CDCODE
     , A.POB_NM   || ' ' || A.POB_TP_CD     CDVALUE
     ,A.POB_NO
     ,A.*
  FROM ACPPRCOD A
-- WHERE POB_NO    = :IN_CONDITION
  WHERE A.POB_NM LIKE '%자상위%';
  --WHERE ROWNUM < 10;



;;;;;




 SELECT /*+ HIS.PA.CORE.SELECTMCCODECOMMONCODE */
        COMN_CD    CDCODE
      , COMN_CD_NM CDVALUE
   FROM CCCCCSTE
  WHERE COMN_GRP_CD =  :IN_CONDITION1
    AND COMN_CD     =  :IN_CONDITION
    AND USE_YN      =  'Y'

    <ISEQUAL PREPEND="AND" PROPERTY="IN_SORT" COMPAREVALUE="1">
        COMN_CD LIKE '%' || :IN_CONDITION ||'%'
    </ISEQUAL>
    <ISEQUAL PREPEND="AND" PROPERTY="IN_SORT" COMPAREVALUE="2">
        COMN_CD_NM LIKE '%' || :IN_CONDITION ||'%'
    </ISEQUAL>



;;;
<IsNotEmpty Property="IN_PT_NO">
        <IsNotNull Property="IN_PT_NO" >
           ANd M.PT_NO  = :IN_PT_NO
        </IsNotNull>
    </IsNotEmpty>
    ;;;


EXEC :IN_CODE := '';

SELECT /*+ HIS.PA.CORE.SelectCommonCodePopupTYPECD */
       DISTINCT
       A.COMN_CD                        CDCODE
     , A.COMN_CD_NM                     CDVALUE
     , A.COMN_CD_EXPL || ' ' || NVL(A.DTRL1_NM,'*')              REMARK
     ,B.PSE_GRP_CD
  FROM CCCCCSTE A
     , ( SELECT DISTINCT PSE_GRP_CD, PSE_CLS_CD
           FROM AIMIRPRD
          WHERE PSE_GRP_CD IS NOT NULL
       ) B
 WHERE A.COMN_GRP_CD = '357'
   AND B.PSE_CLS_CD = A.COMN_CD
   AND B.PSE_GRP_CD = NVL(:IN_CODE,B.PSE_GRP_CD)

   <IsNotEmpty Property="IN_SEARCH_CODE">
        <IsNotNull Property="IN_SEARCH_CODE" >
             <ISEQUAL PREPEND="AND" PROPERTY="IN_SORT" COMPAREVALUE="1">
                  AND A.COMN_CD LIKE '%' || :IN_SEARCH_CODE ||'%'
             </ISEQUAL>
             <ISEQUAL PREPEND="AND" PROPERTY="IN_SORT" COMPAREVALUE="2">
                  AND A.COMN_CD_NM LIKE '%' || :IN_SEARCH_CODE ||'%'
             </ISEQUAL>
         </IsNotNull>
   </IsNotEmpty>
 ORDER BY 1,2,3



  ;;;;

EXEC  :IN_CONDITION := '중증';
EXEC :IN_SORT :='2';

SELECT /*+ HIS.PA.CORE.SelectCommonCodePopupTYPECD */
       DISTINCT
       A.COMN_CD                        CDCODE
     , A.COMN_CD_NM                     CDVALUE
     , A.COMN_CD_EXPL || ' ' || NVL(A.DTRL1_NM,'*')              REMARK
  FROM CCCCCSTE A
     , ( SELECT DISTINCT PSE_GRP_CD, PSE_CLS_CD
           FROM AIMIRPRD
          WHERE PSE_GRP_CD IS NOT NULL
       ) B
 WHERE A.COMN_GRP_CD = '357'
   AND B.PSE_CLS_CD = A.COMN_CD
   AND B.PSE_GRP_CD = NVL(:IN_CODE,B.PSE_GRP_CD)

--   <IsNotEmpty Property="IN_CONDITION">
--        <IsNotNull Property="IN_CONDITION" >
--             <ISEQUAL PREPEND="AND" PROPERTY="IN_SORT" COMPAREVALUE="1">
                --  AND A.COMN_CD LIKE '%' || :IN_CONDITION ||'%'
--             </ISEQUAL>
--             <ISEQUAL PREPEND="AND" PROPERTY="IN_SORT" COMPAREVALUE="2">
                  AND A.COMN_CD_NM LIKE '%' || :IN_CONDITION ||'%'
--             </ISEQUAL>
--         </IsNotNull>
--   </IsNotEmpty>
   AND :IN_SORT = :IN_SORT
 ORDER BY 1,2,3
