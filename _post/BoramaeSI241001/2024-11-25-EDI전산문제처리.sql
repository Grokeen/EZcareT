/*
2024-11-25 01560758    가영책임 문의, 이 환자는 산정특례 받지 않는데 ACPPRGHD에 존재, 신청 불가하여 0156075x 백업 처리
2024-11-27 00288645    이전 거에 산정특례번호 삽입 후, 이 신청서는 0028864x로 백업 처리
2024-12-03 01331474    (재확인)MDRC_ID가 안 묶여있어 ACPPRGCD.MDRC_ID 를 0 -> 48587858 변경
                            -> 이거 문제가 아닌거 같은데
           00328176    (재확인)MDRC_ID가 안 묶여있어 ACPPRGCD.MDRC_ID 를 0 -> 48580253 변경
           01486772    (재확인)6개월 전 미리 작성했기 때문에?
           01598621    성준책임 문의, 산정특례를 받지 않는데, 받는다 되어 있어 지금 정보는 ACPPRGCD,ACPPRGHD 0159862x 백업 처리
           00910538    (재확인)
           01708604    (재확인)왜 떴나
           01663579    가영책임 문의, 팝업 때문에 신청을 못한다. [기등록된 공단등록정보가 확인되지 않아 신청서를 작성할 수 없습니다. 원무 수납창구에 산정특례 공단정보 등록요청 후, 신청서를 작성하시기 바랍니다.]
                                    -> 진료 이수미 파트장님께 어떤 경우에 뜨는지 문의
                                    -> 스테이징에서 테스트했기 때문에 발생한 팝업, 실제로는 정상

2024-12-09 재등록 신청일 경우, 신청 결과에 산정특례 번호를 못 가져오는데, ASIS는 신청구분(신규/재등록)을 제대로 못 가져온다.
           반송이 돼도, 반송사유는 가져오는데, 산정득례 번호 , 9999999999는 안 가져온다.
           -> (신청서에 산정특례 번호를 넣어주는 건 안해줘도 되는데, 정리하려고 넣어놈)

           01557744    특례번호가 신청서 테이블(ACPPRGHD)에 없어, 넣어줌 NULL -> 2324122414
           01650594    특례번호가 신청서 테이블(ACPPRGHD)에 없어, 넣어줌 NULL -> 2324139443
           01593485    특례번호가 신청서 테이블(ACPPRGHD)에 없어, 넣어줌 NULL -> 0124271384
           01306542    특례번호가 신청서 테이블(ACPPRGHD)에 없어, 넣어줌 NULL -> 2324114045
                       인증정보 테이블(ACPPRGCD)에 인증정보가 없어 넣어줌(아직 X)

           01634499    특례번호가 신청서 테이블(ACPPRGHD)에 없어, 넣어줌 NULL -> 2324121047
           01289829    특례번호가 신청서 테이블(ACPPRGHD)에 없어, 넣어줌 NULL -> 9999999999(반송됐을 것으로 예상, 2024-09-04에 신청했었음)
                           - 반송사유는 들어와 있었음

           00563875    특례번호가 신청서 테이블(ACPPRGHD)에 없어, 넣어줌 NULL -> 2324111284
                          - ACPPRGHD.MDRC_ID 이전 산정특례 번호가 2324111284임, 재등록이어도 번호 값은 달라지던데, 수정한 거 같음
                       인증정보 테이블(ACPPRGCD)에 인증정보가 없어 넣어줌(아직 X)

           01623492    특례번호가 신청서 테이블(ACPPRGHD)에 없어, 넣어줌 NULL -> 2124061141
           01891858    특례번호가 신청서 테이블(ACPPRGHD)에 없어, 넣어줌 NULL -> 2324119997
           00938580    특례번호가 신청서 테이블(ACPPRGHD)에 없어, 넣어줌 NULL -> 2324116222
                       인증정보 테이블(ACPPRGCD)에 인증정보가 없어 넣어줌(아직 X)

           01275836    특례번호가 신청서 테이블(ACPPRGHD)에 없어, 넣어줌 NULL -> 2324122407
                       인증정보 테이블(ACPPRGCD)에 인증정보가 없어 넣어줌(아직 X)

           01631968    (재확인)현석 책임님이 데이터 수정한 거 같음
           01990548    특례번호가 신청서 테이블(ACPPRGHD)에 없어, 넣어줌 NULL -> 0124274295
           00814253    특례번호가 신청서 테이블(ACPPRGHD)에 없어, 넣어줌 NULL -> 0124312391
           01118768    진료기록기본 테이블(MRDDRECM)에 보면, MDRC_ID : 56865771은 ASIS 때 두가지가 있었던 거 같음. ACPPRGHD에 넣어줌
                           - SRIL_APLC_SNBK_CD_CNTE : 72
                           - SRIL_APLC_SNBK_MSG_CNTE : 신청접수구분 상이함
                           - SRIL_CFMT_NO : 9999999999

                       마지막으로 작성된 MDRC_ID : 57271181 신청서에 NULL -> 0124308322
                           - SRIL_APLC_SNBK_CD_CNTE : 11
                           - SRIL_APLC_SNBK_MSG_CNTE : 정상처리
                           - SRIL_CFMT_NO : 0124308322

                       인증정보 테이블(ACPPRGCD)에 인증정보가 없어 넣어줌(아직 X)


2024-12-10
           00506012    타병원환자라, 반송사유(72, 신청접수구분 상이함) / 사정특례번호, ACPPRGHD에 넣어줌
                           - SRIL_APLC_SNBK_CD_CNTE : 72
                           - SRIL_APLC_SNBK_MSG_CNTE : 신청접수구분 상이함
                           - SRIL_CFMT_NO : 9999999999

           01597899    MDRC_ID : 500273720인 신청서에
                           - SRIL_CFMT_NO : 0124304749
                           - SRIL_APLC_SNBK_CD_CNTE : 11
                           - SRIL_APLC_SNBK_MSG_CNTE : 정상처리
                           - SRPP_ACPT_DT : 2024-10-17
                           - APY_STR_DT : 2024-10-15
                           - APY_END_DT : 2029-10-14

                       인증정보 테이블(ACPPRGCD)에 인증정보가 없어 넣어줌(아직 X)

            00897673   MDRC_ID : 56964283 인 신청서에
                           - SRIL_CFMT_NO : 0124311576
                           - SRIL_APLC_SNBK_CD_CNTE : 11
                           - SRIL_APLC_SNBK_MSG_CNTE : 정상처리
                           - APY_STR_DT : 2024-06-03 -> 2024-11-21
                           - APY_END_DT : 2029-06-02 -> 2029-11-20  (이 분은 재등록인데, ASIS는 서식을 작성한 날짜?가 적용시작일자에 들어가지고, 결과를 자동 업데이트 해주나?)

                       인증정보 테이블(ACPPRGCD)에 인증정보가 없어 넣어줌(아직 X)

            01294166   MDRC_ID : 56766667 인 신청서에
                           - SRIL_CFMT_NO : 0124295468
                           - SRIL_APLC_SNBK_CD_CNTE : 11
                           - SRIL_APLC_SNBK_MSG_CNTE : 정상처리
                           - APY_STR_DT : 2024-04-16 -> 2024-10-31
                           - APY_END_DT : 2029-04-15 -> 2029-10-30

            01093820   MDRC_ID : 56837282 인 신청서에
                           - SRIL_CFMT_NO : 0124293846
                           - SRIL_APLC_SNBK_CD_CNTE : 11
                           - SRIL_APLC_SNBK_MSG_CNTE : 정상처리
                           - APY_STR_DT : 2024-05-02 -> 2024-10-29
                           - APY_END_DT : 2029-05-01 -> 2029-10-28

            00727135   MDRC_ID : 56815166 인 신청서에
                           - SRIL_CFMT_NO : 0124300543
                           - SRIL_APLC_SNBK_CD_CNTE : 11
                           - SRIL_APLC_SNBK_MSG_CNTE : 정상처리
                           - APY_STR_DT : 2024-04-26 -> 2024-11-05
                           - APY_END_DT : 2029-04-25 -> 2029-11-04

            01190916   MDRC_ID : 56936487 인 신청서에
                           - SRIL_CFMT_NO : 0124304887
                           - SRIL_APLC_SNBK_CD_CNTE : 11
                           - SRIL_APLC_SNBK_MSG_CNTE : 정상처리
                           - APY_STR_DT : 2024-05-28 -> 2024-11-21
                           - APY_END_DT : 2029-05-27 -> 2029-11-20

            01447198   MDRC_ID : 57118590 인 신청서에
                           - SRIL_CFMT_NO : 0124304751
                           - SRIL_APLC_SNBK_CD_CNTE : 11
                           - SRIL_APLC_SNBK_MSG_CNTE : 정상처리
                           - APY_STR_DT : 2024-07-10 -> 2024-11-21
                           - APY_END_DT : 2029-07-09 -> 2029-11-20

            00647288   MDRC_ID : 57057201 인 신청서에
                           - SRIL_CFMT_NO : 0124295471
                           - SRIL_APLC_SNBK_CD_CNTE : 11
                           - SRIL_APLC_SNBK_MSG_CNTE : 정상처리
                           - APY_STR_DT : 2024-06-26 -> 2024-10-30
                           - APY_END_DT : 2029-06-25 -> 2029-10-29

            01648964   MDRC_ID : 56752429 인 신청서에
                           - SRIL_CFMT_NO : 0124308318
                           - SRIL_APLC_SNBK_CD_CNTE : 11
                           - SRIL_APLC_SNBK_MSG_CNTE : 정상처리
                           - APY_STR_DT : 2024-04-12 -> 2024-11-21
                           - APY_END_DT : 2029-04-11 -> 2029-11-20

            00593571   MDRC_ID : 56964038 인 신청서에
                           - SRIL_CFMT_NO : 0124304742
                           - SRIL_APLC_SNBK_CD_CNTE : 11
                           - SRIL_APLC_SNBK_MSG_CNTE : 정상처리
                           - APY_STR_DT : 2024-06-03 -> 2024-11-21
                           - APY_END_DT : 2029-06-02 -> 2029-11-20

            00805377   신근식 환자 같은 경우, 전송 전부터 산정특례 번호에 11111111111이 들어와 있었음(암, 신청일자 : 2024-12-09). 결과 넣는 로직에 조건 추가해야 할듯.
                           - GCD 산정특례 번호 11111111111 -> NULL 변경(변경 후, 정상 업로드 확인)

            01233949   이경순 환자도 마찬가지 11111111111 -> NULL 변경(희귀, 신청일자 2024-12-06)
                           - 추가적으로 전송결과가 정상적으로 업로드는 된 거 같은데, 조회가 계속되는 환자들(00981251 ,01945937)이 있어 조회 조건 확인해야 함

            00981251    추가적으로 전송결과가 정상적으로 업로드는 된 거 같은데, 조회가 계속되는 환자들(00981251 , 01945937)이 있음
                        -> 결과 값(11, 정상처리)을 안 넣어줘서 발생한 듯
                           - SRIL_APLC_SNBK_CD_CNTE : 11
                           - SRIL_APLC_SNBK_MSG_CNTE : 정상처리
                           - SRPP_ACPT_DT : 2024-12-10
                        -> 위에 값을 넣어줬는데, 계속 조회된다. 확인해야 할 듯.

            01734417    이숙자 환자 산정특례번호 1111111111 -> NULL 로 변경

2024-12-11
            01302240    희귀난치는 개발자모드로도 적용전에 정보를 알 수가 없디. MDRC_ID : 500247843 인 신청서에
                           - SRIL_CFMT_NO : 9999999999
                           - SRIL_APLC_SNBK_CD_CNTE : 01 -> 01 코드 의미 : 송신
                           - SRIL_APLC_SNBK_MSG_CNTE : 재등록확인(김용록)
                           - SRPP_ACPT_DT : 2024-10-10

           01394138    MDRC_ID : 500248575 인 신청서에
                           - SRIL_CFMT_NO : 2324125795
                           - SRIL_APLC_SNBK_CD_CNTE : 11
                           - SRIL_APLC_SNBK_MSG_CNTE : 정상처리
                           - SRPP_ACPT_DT : 2024-10-10
                           - APY_STR_DT : 2024-11-04
                           - APY_END_DT : 2029-11-03

           00261317    희귀난치는 개발자모드로도 적용전에 정보를 알 수가 없디. MDRC_ID : 500225071 인 신청서에
                           - SRIL_CFMT_NO : 9999999999
                           - SRIL_APLC_SNBK_CD_CNTE : 01
                           - SRIL_APLC_SNBK_MSG_CNTE : 재등록확인(김용록)
                           - SRPP_ACPT_DT : 2024-10-04

           00135901    희귀난치는 개발자모드로도 적용전에 정보를 알 수가 없디. MDRC_ID : 500220341 인 신청서에
                           - SRIL_CFMT_NO : 9999999999
                           - SRIL_APLC_SNBK_CD_CNTE : 01
                           - SRIL_APLC_SNBK_MSG_CNTE : 재등록확인(김용록)
                           - SRPP_ACPT_DT : 2024-10-02

           00001961    희귀난치는 개발자모드로도 적용전에 정보를 알 수가 없다. MDRC_ID : 500238022 인 신청서에
                           - SRIL_CFMT_NO : 9999999999
                           - SRIL_APLC_SNBK_CD_CNTE : 01
                           - SRIL_APLC_SNBK_MSG_CNTE : 재등록확인(김용록)
                           - SRPP_ACPT_DT : 2024-10-07

           01250495    희귀난치는 개발자모드로도 적용전에 정보를 알 수가 없다. MDRC_ID : 500220341 인 신청서에
                           - SRIL_CFMT_NO : 9999999999
                           - SRIL_APLC_SNBK_CD_CNTE : 01
                           - SRIL_APLC_SNBK_MSG_CNTE : 재등록확인(김용록)
                           - SRPP_ACPT_DT : 2024-10-10

           00679398    희귀난치는 개발자모드로도 적용전에 정보를 알 수가 없다. MDRC_ID : 500236203 인 신청서에
                           - SRIL_CFMT_NO : 9999999999
                           - SRIL_APLC_SNBK_CD_CNTE : 01
                           - SRIL_APLC_SNBK_MSG_CNTE : 재등록확인(김용록)
                           - SRPP_ACPT_DT : 2024-10-07

           00340440    희귀난치는 개발자모드로도 적용전에 정보를 알 수가 없다. MDRC_ID : 500225064 인 신청서에
                           - SRIL_CFMT_NO : 9999999999
                           - SRIL_APLC_SNBK_CD_CNTE : 01
                           - SRIL_APLC_SNBK_MSG_CNTE : 재등록확인(김용록)
                           - SRPP_ACPT_DT : 2024-10-04

2024-12-12 재등록 시, 암 : 산정특례 번호를 주기 때문에 산정특례 번호, 11, 정상등록을 넣어주고
                    희귀난치 :                    9999999999   01(송신) , 재등록확인 처리


           01524330    (재확인)문광용 환자, 2024-12-12 오전에 전송해서 정상 등록됐는데, 왜 정보 업로드가 안되는지 확인 필요하다.
           00301929    (재확인)유양례 환자도 마찬가지, 반송인데, 업로드가 안된다.
           00624917    희귀난치는 개발자모드로도 적용전에 정보를 알 수가 없다. MDRC_ID : 500249291 인 신청서에
                           - SRIL_CFMT_NO : 9999999999
                           - SRIL_APLC_SNBK_CD_CNTE : 01
                           - SRIL_APLC_SNBK_MSG_CNTE : 재등록확인(김용록)
                           - SRPP_ACPT_DT : 2024-10-10

           00389860    희귀난치는 개발자모드로도 적용전에 정보를 알 수가 없다. MDRC_ID : 500236221 인 신청서에
                           - SRIL_CFMT_NO : 9999999999
                           - SRIL_APLC_SNBK_CD_CNTE : 01
                           - SRIL_APLC_SNBK_MSG_CNTE : 재등록확인(김용록)
                           - SRPP_ACPT_DT : 2024-10-07


                            아직
           01243889    희귀난치는 개발자모드로도 적용전에 정보를 알 수가 없다. MDRC_ID : 500240540 인 신청서에
                           - SRIL_CFMT_NO : 9999999999
                           - SRIL_APLC_SNBK_CD_CNTE : 01
                           - SRIL_APLC_SNBK_MSG_CNTE : 재등록확인(김용록)
                           - SRPP_ACPT_DT : 2024-10-07



           00639270    희귀난치는 개발자모드로도 적용전에 정보를 알 수가 없다. MDRC_ID : 500219087 인 신청서에
                           - SRIL_CFMT_NO : 9999999999
                           - SRIL_APLC_SNBK_CD_CNTE : 01
                           - SRIL_APLC_SNBK_MSG_CNTE : 재등록확인(김용록)
                           - SRPP_ACPT_DT : 2024-10-02


           00687919    희귀난치는 개발자모드로도 적용전에 정보를 알 수가 없다. MDRC_ID : 500219087 인 신청서에
                           - SRIL_CFMT_NO : 9999999999
                           - SRIL_APLC_SNBK_CD_CNTE : 01
                           - SRIL_APLC_SNBK_MSG_CNTE : 재등록확인(김용록)
                           - SRPP_ACPT_DT : 2024-10-02

           00553083    MDRC_ID : 500247364 인 신청서에
                           - SRIL_CFMT_NO : 2124066091
                           - SRIL_APLC_SNBK_CD_CNTE : 11
                           - SRIL_APLC_SNBK_MSG_CNTE : 정상처리
                           - SRPP_ACPT_DT : 2024-10-10
                           - APY_STR_DT : 2024-12-12
                           - APY_END_DT : 2029-12-11


2024-12-13
           00215620    MDRC_ID : 500232933 인 신청서에
                           - SRIL_CFMT_NO : 9999999999
                           - SRIL_APLC_SNBK_CD_CNTE : 01
                           - SRIL_APLC_SNBK_MSG_CNTE : 재등록확인(김용록)
                           - SRPP_ACPT_DT : 2024-10-07

           00018854    MDRC_ID : 500225024 인 신청서에
                           - SRIL_CFMT_NO : 9999999999
                           - SRIL_APLC_SNBK_CD_CNTE : 01
                           - SRIL_APLC_SNBK_MSG_CNTE : 재등록확인(김용록)
                           - SRPP_ACPT_DT : 2024-10-04

           00845854    MDRC_ID : 500249886 인 신청서에
                           - SRIL_CFMT_NO : 2324125782
                           - SRIL_APLC_SNBK_CD_CNTE : 11
                           - SRIL_APLC_SNBK_MSG_CNTE : 정상처리
                           - SRPP_ACPT_DT : 2024-10-10
                           - APY_STR_DT : 2024-12-06
                           - APY_END_DT : 2029-12-05

           00383118    MDRC_ID : 500240973 인 신청서에
                           - SRIL_CFMT_NO : 2324123749
                           - SRIL_APLC_SNBK_CD_CNTE : 11
                           - SRIL_APLC_SNBK_MSG_CNTE : 정상처리
                           - SRPP_ACPT_DT : 2024-10-08
                           - APY_STR_DT : 2024-12-08
                           - APY_END_DT : 2029-12-07

           00018854    MDRC_ID : 500226218 인 신청서에
                           - SRIL_CFMT_NO : 9999999999
                           - SRIL_APLC_SNBK_CD_CNTE : 01
                           - SRIL_APLC_SNBK_MSG_CNTE : 재등록확인(김용록)
                           - SRPP_ACPT_DT : 2024-10-04


           01572510    MDRC_ID : 500236133 인 신청서에
                           - SRIL_CFMT_NO : 9999999999
                           - SRIL_APLC_SNBK_CD_CNTE : 01
                           - SRIL_APLC_SNBK_MSG_CNTE : 재등록확인(김용록)
                           - SRPP_ACPT_DT : 2024-10-07

           01465873    MDRC_ID : 500215456 인 신청서에
                           - SRIL_CFMT_NO : 9999999999
                           - SRIL_APLC_SNBK_CD_CNTE : 01
                           - SRIL_APLC_SNBK_MSG_CNTE : 재등록확인(김용록)
                           - SRPP_ACPT_DT : 2024-10-01

           01304330    MDRC_ID : 500242509 인 신청서에
                           - SRIL_CFMT_NO : 2124065313
                           - SRIL_APLC_SNBK_CD_CNTE : 11
                           - SRIL_APLC_SNBK_MSG_CNTE : 정상처리
                           - SRPP_ACPT_DT : 2024-10-04
                           - APY_STR_DT : 2024-11-22
                           - APY_END_DT : 2029-11-21

           01243889    MDRC_ID : 500240540 인 신청서에
                           - SRIL_CFMT_NO : 9999999999
                           - SRIL_APLC_SNBK_CD_CNTE : 01
                           - SRIL_APLC_SNBK_MSG_CNTE : 재등록확인(김용록)
                           - SRPP_ACPT_DT : 2024-10-08

           00923877    MDRC_ID : 500233236 인 신청서에
                           - SRIL_CFMT_NO : 9999999999
                           - SRIL_APLC_SNBK_CD_CNTE : 01
                           - SRIL_APLC_SNBK_MSG_CNTE : 재등록확인(김용록)
                           - SRPP_ACPT_DT : 2024-10-07

           01123358    (재확인)정영남 환자 2024-12-12 업로드 완됨, 공단 확인해보니 정상 등록
                            - 특이사항 : 중복암 , V193(D329)
                       MDRC_ID : 500525816에
                           - SRIL_CFMT_NO : 0124368079
                           - SRIL_APLC_SNBK_CD_CNTE : 11
                           - SRIL_APLC_SNBK_MSG_CNTE : 정상처리
                           - SRPP_ACPT_DT : 2024-12-12
                           - APY_STR_DT : 2024-12-12
                           - APY_END_DT : 2029-12-11

           01123358    (재확인)정영남 환자 2024-12-12 업로드 완됨, 공단 확인해보니 정상 등록
                            - 특이사항 : 중복암 , V193(D329)
                       MDRC_ID : 500525816에
                           - SRIL_CFMT_NO : 0124368079
                           - SRIL_APLC_SNBK_CD_CNTE : 11
                           - SRIL_APLC_SNBK_MSG_CNTE : 정상처리
                           - SRPP_ACPT_DT : 2024-12-12
                           - APY_STR_DT : 2024-12-12
                           - APY_END_DT : 2029-12-11



2024-12-16
           00955554    2024-12-09 반송 환자, 재등록 확인
                       MDRC_ID : 500508370에
                           - SRIL_CFMT_NO : 0124366565
                           - SRIL_APLC_SNBK_CD_CNTE : 11
                           - SRIL_APLC_SNBK_MSG_CNTE : 정상처리
                           - APY_STR_DT : 2024-12-21
                           - APY_END_DT : 2029-12-20

           00955554    2024-12-09 재등록 확인
                       MDRC_ID : 500253503에
                           - SRIL_CFMT_NO : 2324128541
                           - SRIL_APLC_SNBK_CD_CNTE : 11
                           - SRIL_APLC_SNBK_MSG_CNTE : 정상처리
                           - APY_STR_DT : 2024-12-02
                           - APY_END_DT : 2029-12-01

           01628050    반송환자
                       MDRC_ID : 500516310에
                           - SRIL_APLC_SNBK_CD_CNTE : 72 -> 01
                           - SRIL_APLC_SNBK_MSG_CNTE : 의료급여 기등록건>자사로 문의   -> 재등록확인(김용록)

           01925431    최애란 환자같은 경우, 신청서가 삭제되었는지 제증면관리 화면에 조회 안된다.
                       MDRC_ID : 500277627 인 신청서에
                           - SRIL_CFMT_NO : 9999999999
                           - SRIL_APLC_SNBK_CD_CNTE : 01
                           - SRIL_APLC_SNBK_MSG_CNTE : 신청서삭제여부확인필요(김용록)

           00615264    500248776 신청서 , 산정특례 번호에 null -> 2324125788



*/


/*
중증신청서 EDI 전송 화면 관련 EQS
    1. 암 신청서 조회      : HIS.PA.AC.PI.PI.SelSeriousIllnessApplicationFormEDIReg1_0
    2. 희귀난치 신청서 조회 : HIS.PA.AC.PI.PI.SelSeriousIllnessApplicationFormEDIReg1_1
    3. 결핵 신청서 조회    : HIS.PA.AC.PI.PI.SelSeriousIllnessApplicationFormEDIReg1_2
    4. 잠복결핵 신청서 조회 : HIS.PA.AC.PI.PI.SelSeriousIllnessApplicationFormEDIReg1_3
    5. 화상 신청서 조회    : HIS.PA.AC.PI.PI.SelSeriousIllnessApplicationFormEDIReg1_4
    6. 전체 미전송 조회    : HIS.PA.AC.PI.PI.SelSeriousIllnessApplicationFormEDIReg_Statistics

    7. EDI 업로드 조회 버튼      : HIS.PA.GN.HA.SelSeriousIllnessApplicationFormEDIReg2
    8. EDI 업로드 업로드 버튼    : HIS.PA.AC.PI.PI.UpdSeriousIllnessApplicationFormEDIReg2

현재 찾은 문제
    환자들 MDRC_ID가 상이한 경우가 있음 -> EDI 업로드로 안됨 / 데이터를 직접 넣어줘야 함
                                   -> 마이그 문제일 수 도 있는데, 조회시 가져오는 쿼리 문제일 듯 싶

*/
EXEC :IN_PT_NO := '01966322';


/* 신상정보 확인 ################################################################################ */
select
      pt_nm
     , PLS_DECRYPT_B64_ID(pt_RRN, 800)     as "주번"
     , nvl( (select  NVL2(PT_NO , TO_CHAR(DTH_DTM,'YYYY-MM-DD') ||' 사망자' , 'N' )     AS "사망정보"
               from ACPPIDID /* 사망환자정보 테이블 */
              where pt_no = :in_pt_no)
           , 'N' ) as "사망여부"
     , a.*
from pctpcpam a     /* 환자기본 테이블 */
where pt_no = :in_pt_no;





/* 신청서 및 결과 확인 ################################################################################ */
select A.SRIL_CFMT_NO
      ,A.CFSC_CD
      ,a.aplc_icd10_cd_cnte
       ,a.mdrc_id  -- 55262939
      ,a.srpp_acpt_dt  -- 중증신청서접수일자
      ,A.SRIL_APLC_SNBK_CD_CNTE
      ,A.SRIL_APLC_SNBK_MSG_CNTE
      ,A.APY_STR_DT    -- 작용시작일자
      ,A.APY_END_DT    -- 적용종료일자

      -- PDF 생성해달라 하면 수정 후, 원복  -> PDF 생성은 중증신청서 관리 화면
--      ,A.CNCR_DGNS_CFMT_DT as "확진일자"
--      ,A.APFR_WRT_DT       as "발행일자"
--      ,A.APLC_DT           as "신청일자"
      ,a.*
  from acpprghd a /* 중증산정특례신청서정보 테이블 */
where pt_no = :IN_PT_NO
ORDER BY APLC_DT DESC;

/*
   HIRA_MED_SBJT_CD
*/

/* 히스토리 테이블, 신청서 및 결과 기록 변경 내역 확인 ################################################################################ */
--select
--       A.SRIL_APLC_CNCL_DTM          AS CANCLE_DTM
--      ,A.SRIL_CFMT_NO
--      ,A.CFSC_CD
--      ,a.aplc_icd10_cd_cnte
--       ,a.mdrc_id  -- 55262939
--      ,a.srpp_acpt_dt  -- 중증신청서접수일자
--      ,A.SRIL_APLC_SNBK_CD_CNTE
--      ,A.SRIL_APLC_SNBK_MSG_CNTE
--      ,A.APY_STR_DT    -- 작용시작일자
--      ,A.APY_END_DT    -- 적용종료일자
--      ,a.*
--  from acpprghh a /* 중증산정특례신청서정보 테이블 */
--where pt_no = :IN_PT_NO
--ORDER BY APLC_DT DESC;




/* 현재 받고있는 산정특례 확인 ################################################################################ */
select
       A.SRIL_CFMT_NO
      ,a.apy_str_dt
      ,a.apy_end_dt
      ,a.sril_cdoc_aplc_tp_cd
      ,a.pcor_icd10_cd_cnte
      ,a.mdrc_id   -- 55262939
      ,a.*
from acpprgcd a     /* 중증진료확인증정보 테이블 */
where pt_no = :IN_PT_NO
ORDER BY A.APY_STR_DT DESC;


/* 산정특례가 어떻게 적용됐었는지 기록 확인 ################################################################################ */
--SELECT
--      A.PT_NO
--     ,A.PCOR_ICD10_CD_CNTE
--    -- ,A.PCOR_ICD10_CD_DUP_SEQ_CD
--     ,A.LSH_DTM
--     ,A.LSH_PRGM_NM
--     ,A.*
--FROM ACPPRGCH A      /* 중증진료확인증정보 히스토리 테이블 */
--where pt_no = :IN_PT_NO
--ORDER BY A.LSH_DTM DESC;



/* 진료 기록과 비교 확인( 1.타병원 환자인지 / 2. ) ################################################################################ */
SELECT m.PT_NO
      ,M.REC_DTM
      ,PACT_DTM
      ,MDFM_CLS_CD
--      -,COUNT(MDRC_ID)
      ,m.*
  FROM MRDDRECM m  /* 진료기록기본 테이블 */
      ,pctpcpam p
 WHERE 1=1
   and m.pt_no = p.pt_no(+)
   and m.PT_NO = :IN_PT_NO
   AND m.MDFM_CLS_CD = 'D009'
   AND m.MDRC_WRT_STS_CD > 10
   AND m.MDRC_DC_TP_CD = 'C'  -- 진료기록중단구분코드
   AND m.LST_YN = 'Y'         -- 서명
   AND m.REC_DTM > '20180101'
   AND M.MDRC_FOM_SEQ = (SELECT MAX(M.MDRC_FOM_SEQ) OVER (PARTITION BY MDRC_ID ORDER BY M.MDRC_FOM_SEQ)
                           FROM DUAL)
ORDER BY M.REC_DTM DESC
;

-- 진료쪽 산정특례 신청 팝업 프로시저
-- PKG_MOO_SRILRRNSCFSCINFASK.FT_MOO_GETSPECIALCASESTATUS


/* #############################################################################################################################
############################################################################################################################# */



/* ASIS 확진방법 체크 후, 내용 못 불러온 경우 ################################################################################ */
exec :aplc_icd10_cd_cnte := 'C61';      -- 상병 코드

select A.SRIL_CFMT_NO
      ,A.CFSC_CD
      ,a.aplc_icd10_cd_cnte
      ,DECODE ( A.TH11_CNCR_LST_DGNS_YN , 'Y' , XMED.FT_MRD_GET_ELMT_SEQ_INFO('MDFM_ELMT_ID', a.MDRC_ID, a.MDRC_FOM_SEQ, '2038') , '' )  as "암_최종확진6내용"
       ,a.mdrc_id  -- 55262939
      ,a.srpp_acpt_dt  -- 중증신청서접수일자
      ,A.SRIL_APLC_SNBK_CD_CNTE
      ,A.SRIL_APLC_SNBK_MSG_CNTE
      ,A.APY_STR_DT    -- 작용시작일자
      ,A.APY_END_DT    -- 적용종료일자
      ,a.*
  from acpprghd a /* 중증산정특례신청서정보 테이블 */
where 1=1
  and replace(aplc_icd10_cd_cnte,'.','') = :aplc_icd10_cd_cnte
  and SRIL_CFMT_NO is not null
  and SRIL_APLC_SNBK_CD_CNTE = '11'
  and DECODE ( A.TH11_CNCR_LST_DGNS_YN , 'Y' , XMED.FT_MRD_GET_ELMT_SEQ_INFO('MDFM_ELMT_ID', a.MDRC_ID, a.MDRC_FOM_SEQ, '2038') , '' ) is not null
ORDER BY APLC_DT DESC;





/* 진료 쪽에서 신청서 확인할 때, 본다는 쿼리(민우 책임님)  ################################################################################ */
exec :in_pt_no := '01191274'

SELECT *
 FROM MRDDRlfe
WHERE 1=1
 AND ROWNUM < 1000
-- and mdrc_id ='500273454'
 and mdrc_id IN ('56600089','56589836')
;

SELECT *
  FROM MRDDRECM   /* 진료기록기본 테이블 */
 WHERE 1=1
 AND pt_no= :in_pt_no
 AND LST_YN = 'Y'
 AND MDRC_WRT_STS_CD > 10
;

SELECT *
  FROM MRFMFORM
 WHERE 1=1
 AND MDFM_nm like '%산정특례%'
 AND LST_YN = 'Y'
;

