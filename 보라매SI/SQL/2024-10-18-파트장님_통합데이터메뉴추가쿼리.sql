
--HIS.MC.CM.CO.CR.SaveIntgRsltMgmt.InsertTreeViewList

SELECT *  FROM MOOPTMMD
WHERE ROWNUM < 100
  AND MENU_NM LIKE '%경영정보%'
ORDER BY LSH_DTM DESC;
;

SELECT * FROM MOOPTQMD WHERE ROWNUM <10;




INSERT /* HIS.MC.CM.CO.CR.SaveIntgRsltMgmt.InsertTreeViewList */
      INTO MOOPTMMD
         (
           GRP_CD               /*그룹코드*/
         , MENU_CD              /*메뉴코드*/
         , MENU_NM              /*메뉴명*/
         , CTG_LVL_TP_CD        /*분류레벨구분코드*/
         , UPR_MENU_CD          /*상위메뉴코드*/
         , FLDR_YN              /*폴더여부*/
         , FSR_DTM              /*최초등록일시*/
         , FSR_STF_NO           /*최초등록직원번호*/
         , FSR_PRGM_NM          /*최초등록프로그램명*/
         , FSR_IP_ADDR          /*최초등록IP주소*/
         , LSH_DTM              /*최종변경일시*/
         , LSH_STF_NO           /*최종변경직원번호*/
         , LSH_PRGM_NM          /*최종변경프로그램명*/
         , LSH_IP_ADDR          /*최종변경IP주소*/
         )
    VALUES
         (
           :GRP_CD
       , (SELECT :UPR_MENU_CD || '-' || NVL(TO_CHAR(MAX(TO_NUMBER(nvl(REPLACE(MENU_CD, UPR_MENU_CD || '-', ''), 0))) + 1),1)
	           FROM MOOPTMMD				--입력될 MENU_CD를 상위메뉴로 변경하고 최초폴더생성시 값이 없어서 NVL처리 후 최대값을 가져와서 1씩 추가하는 방식
	          WHERE GRP_CD = :GRP_CD
	            AND UPR_MENU_CD = :UPR_MENU_CD  --TEST555-5
	            AND CTG_LVL_TP_CD != 1)		--최상위 폴더일때 제외해야함
         , :MENU_NM
         , :CTG_LVL_TP_CD
         , :UPR_MENU_CD
         , :FLDR_YN
         , :HIS_LSH_DTM
         , :HIS_STF_NO
         , :HIS_PRGM_NM
         , :HIS_IP_ADDR
         , :HIS_LSH_DTM
         , :HIS_STF_NO
         , :HIS_PRGM_NM
         , :HIS_IP_ADDR
         )
