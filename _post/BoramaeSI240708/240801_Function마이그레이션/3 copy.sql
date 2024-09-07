select to_char(x.MED_RSV_DTM, 'yyyy-mm-dd hh24:mi')                                 -- MED_DTM(진료일시) -> MED_RSV_DTM(진료예약일시)
          into v_rtn_val


          from ACPPRODM x                                                           -- APOPRSVT -> ACPPRODM



         where x.PT_NO      = in_pt_no
           and x.MED_DT    > in_req_dte
           and regexp_replace(x.MED_DEPT_CD , '^(PC)|^(BC)|^(RC)', '')                   -- MED_DEPT(진료과) -> MED_DEPT_CD(진료부서코드)
             = regexp_replace(in_med_dept, '^(PC)|^(BC)|^(RC)', '')
           and x.APCN_DTM   is null                                                      -- CNCL_DTE(취소일자) -> APCN_DTM(접수취소일시)
           and nvl(x.MEF_RPY_CLS_CD,'N') != '1'                                          -- MEDRCP_YN(진찰료수납여부) -> MEF_RPY_CLS_CD(진찰료수납유형코드)
           and nvl(x.OTPT_RSV_TP_CD  ,'1') in (                                          -- RSV_TYP(예약구분) -> OTPT_RSV_TP_CD(외래예약구분코드) 
                                         '0'            -- 건증
                                       , '1'            -- 창구
                                       , '2'            -- 진료과
                                       , '3'            -- 진료협력센터
                                       , '4'            -- 전화재진
                                       , '5'            -- 전화신환
                                       , '6'            -- 전화초진
                                       , '7'            -- 인터넷
                                       , 'C'            -- 의학연구
                                       , 'E'            -- 가정간호
                                       , 'G'            -- 휴일,일과후(진찰료50%)
                                       , 'H'            -- 보호자내원
                                       , 'J'            -- FAX예약
                                       )
        ;