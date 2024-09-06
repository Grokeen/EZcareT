select rsv_info
          into v_rtn_val
          
          from (
                select '(' || x.med_dept || ') ' || to_char(x.med_dtm, 'yyyy-mm-dd hh24:mi')   rsv_info
                  from apoprsvt x
                 where x.pt_no      = in_pt_no
                   and x.med_dte    = v_rsv_dte
                   and regexp_replace(x.med_dept , '^(PC)|^(BC)|^(RC)', '') 
                    != regexp_replace(in_med_dept, '^(PC)|^(BC)|^(RC)', '')
                   and x.cncl_dte   is null
                   and nvl(x.medrcp_yn,'N') != '1'
                   and nvl(x.rsv_typ  ,'1') in ( '0'       -- 건증
                                               , '1'       -- 창구
                                               , '2'       -- 진료과
                                               , '3'       -- 진료협력센터
                                               , '4'       -- 전화재진
                                               , '5'       -- 전화신환
                                               , '6'       -- 전화초진
                                               , '7'       -- 인터넷
                                               , 'C'       -- 의학연구
                                               , 'E'       -- 가정간호
                                               , 'G'       -- 휴일,일과후(진찰료50%)
                                               , 'H'       -- 보호자내원
                                               , 'J'       -- FAX예약
                                               )
                   and x.med_dept           in ( 'TS'      -- 흉부외과
                                               , 'RCTS'    -- 흉부외과(폐센터)
                                               , 'PCTS'    -- 흉부외과(암센터)
                                               , 'GS'      -- 외과
                                               , 'PCGS'    -- 외과(암센터)
                                               , 'BCGS'    -- 외과(유방전문센터)
                                               , 'PCIMH'   -- 혈액종양내과(암센터)
                                               , 'PCCO'    -- 암센터외래
                                               , 'RC'      -- 폐센터
                                               , 'TR'      -- 방사선종양학과
                                               , 'IMG'     -- 소화기내과
                                               , 'IMH'     -- 혈액종양내과
                                               )
                 order by
                       case when regexp_replace(x.med_dept , '^(PC)|^(BC)|^(RC)', '') = 'GS' then 1
                            when regexp_replace(x.med_dept , '^(PC)|^(BC)|^(RC)', '') = 'TS' then 2
                                                                                             else 3
                       end
                     , x.med_dtm  
               )
         where rownum = 1      
        ;