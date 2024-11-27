PACKAGE      PKG_ACP_REPLACE_REVERSE IS

/***********************************************************************************
 *    서비스이름  : PKG_ACP_REPLACE_REVERSE
 *    최초 작성일 : 2024.11.08
 *    최초 작성자 : 김용록
 *    Description : 체크리스트+외래치환환자 패키지
 *                  1. 체크리스트 등록 (INSERT / UPDATE)
 *                  2. 예약검사있을시에 검사예약일자 업데이트
 *                  3. 만약 취소되지않은 입원오더가 있을경우 진료쪽에 D/C요청
 *                  4. 입원계산내역 취소 작업 / 입원 취소 작업 및 수납역치환
 *                     EXEC PKG_BIL_TOEMR2.PC_WK_APIPLIST_CANCLE(:PT_NO, :MED_DTE);
 *                     -> PKG_BIL_IPRSV.PC_AP_APIPLIST_DELETE
 *                     -> PKG_BIL_IPCAL_BATCH.SP_RE_REPLACE_ORDER
 *                  5. 외래수진 취소일자 NULL 처리
 *                  6. 체크리스트 완료처리
 *                     6시간 미만 외래치환은 원무에서 만 처리하고 있고, 해당 화면은 체크리스트에
 *                     치환으로 구분되어있는 환자분 조회하는 걸로 알고 있습니다.
 *                     PKG_BIL_PTINF.PC_AP_APREPLOPT_SELECT
 **********************************************************************************/
PROCEDURE PC_ACP_REPLACE_REVERSE_INSERT(	IN_PT_NO                IN   VARCHAR2   	--환자번호
                                       ,	IN_PACT_ID              IN   VARCHAR2 		--원무접수ID
                                       ,  HIS_STF_NO              IN   VARCHAR2                                                       
                                       ,  HIS_PRGM_NM             IN   VARCHAR2                                                     
                                       ,  HIS_IP_ADDR             IN   VARCHAR2);





procedure PC_ACP_REPLACE_REVERSE_UPADTE ( IN_PT_NO                IN 	VARCHAR2   		    --환자번호
								                       ,	IN_CTN_TGPT_INPT_DT     IN 	VARCHAR2          --주의대상환자입력일자
								                       ,	IN_DBPROC_TP		        IN	VARCHAR2          --프로시저 구분(A:기존 것에 추가 / M:기존 것을 수정)
								                       , 	IN_TITLE				        IN	VARCHAR2          --제목
								                       ,	IN_MSG					        IN	VARCHAR2          --메시지 
								                       ,  HIS_STF_NO              IN  VARCHAR2                                                       
                                       ,  HIS_PRGM_NM             IN  VARCHAR2                                                     
                                       ,  HIS_IP_ADDR             IN  VARCHAR2);




procedure PC_ACP_REPLACE_REVERSE_COMPLETE( IN_PT_NO                IN VARCHAR2   		    --환자번호
                                          ,IN_CTN_TGPT_INPT_DT     IN VARCHAR2          --주의대상환자입력일자
								                          ,IN_DBPROC_TP		         IN	VARCHAR2          --프로시저 구분(A:INSERT,B:UPDATE)
								                          ,IN_TITLE				         IN	VARCHAR2          --제목
								                          ,IN_MSG					         IN	VARCHAR2          --메시지 
								                          ,HIS_STF_NO              IN VARCHAR2                                                       
                                          ,HIS_PRGM_NM             IN VARCHAR2                                                     
                                          ,HIS_IP_ADDR             IN VARCHAR2);
END PKG_ACC_BATCH_AIM;
