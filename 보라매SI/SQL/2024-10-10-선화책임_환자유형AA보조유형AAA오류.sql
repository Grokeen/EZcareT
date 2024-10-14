--김선화 책임, 인터넷 예약시 환자유형 AA , 보조유형 AAA로 들어온 환자가 있습니다 로직 확인 부탁 바랍니다
SELECT A.PME_CLS_CD
      ,A.PSE_CLS_CD
      ,A.OTPT_RSV_TP_CD
      ,A.*
  FROM ACPPRODM   A
 WHERE A.PT_NO = '01579192'
   AND A.MED_DT ='20241010'
;  

---------------------------------------------
--이지케어텍 보라매 신동명 책임님, [2024-10-10 오후 12:54]
SELECT FSR_STF_NO,FSR_DTM,FSR_PRGM_NM,FSR_IP_ADDR,LSH_STF_NO,LSH_DTM,LSH_PRGM_NM,LSH_IP_ADDR
      ,A.PME_CLS_CD
      ,A.PSE_CLS_CD
      ,A.OTPT_RSV_TP_CD
      ,A.*
  FROM ACPPRODH A
 WHERE PT_NO = '01579192'
   AND RPY_PACT_ID = '0000138641'
 ORDER BY WK_DTM
;;
/*
최초에는 000으로 예약되었으나
진단 등록하면서 경증이라서 'AAA'로 친걸로 보입니다.
공통코드 보조유형이 AAA인건 있지만 부담율 정보에는 보조유형 AAA로 쓰는것이 없으니 진료쪽과 확인이 필요하긴 합니다
*/
SELECT *
  FROM CCCCCSTE
 WHERE COMN_GRP_CD = '357'
   AND  COMN_CD = 'AAA'
;;

SELECT *
  FROM AIMIRPRD
 WHERE PSE_CLS_CD = 'AAA'
;;

---------------------------------------------
/*
선화 김, [2024-10-10 오후 12:57]
네 부담율이 없는거 같아서요

선화 김, [2024-10-10 오후 12:57]
진료에서 아마 부담율까지 체크는 안할거같아요
 */

