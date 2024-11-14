----스테이징으로 로그인해서 사용할것
declare
    v_pt_no             varchar2(8) := '00163947';
    check_appatbat      varchar2(1) := 'N';
    v_pact_tp_cd        varchar2(1) := 'A';
begin
    --운영기 데이터를 이관한다.
    begin
        --환자기본정보
        begin
            select  'Y'
              into  check_appatbat
              from  PCTPCPAM
             where  pt_no  =  v_pt_no
               and  rownum = 1;
        exception
           when others then
                check_appatbat := 'N';
        end;

        if  check_appatbat = 'N'  then
            insert into PCTPCPAM value (select * from PCTPCPAM@DL_PROD_MIG where pt_no = v_pt_no);
            insert into PCTPCPTD value (select * from PCTPCPTD@DL_PROD_MIG where pt_no = v_pt_no);
        end if;

        --환자보험정보
        delete ACPPRPID where pt_no = v_pt_no;
        insert into ACPPRPID value (select * from ACPPRPID@DL_PROD_MIG where pt_no = v_pt_no);

        --환자처방통합정보
--        delete MOOORPTD where pt_no = v_pt_no;
--        insert into MOOORPTD value (select * from MOOORPTD@DL_PROD_MIG where pt_no = v_pt_no);

        --검사
        delete MOOOREXM where pt_no = v_pt_no;
        insert into MOOOREXM value (select * from MOOOREXM@DL_PROD_MIG where pt_no = v_pt_no);

--        --투약처방
--        delete MSDDGBAM where pt_no = v_pt_no;
--        insert into MSDDGBAM value (select * from MSDDGBAM@DL_PROD_MIG where pt_no = v_pt_no);

        --약
        delete MOOORDRM where pt_no = v_pt_no;
        insert into MOOORDRM value (select * from MOOORDRM@DL_PROD_MIG where pt_no = v_pt_no);

        --약 반납
        delete MSDDGRED where pt_no = v_pt_no;
        insert into MSDDGRED value (select * from MSDDGRED@DL_PROD_MIG where pt_no = v_pt_no);

        --주사
        delete MOOORIJD where pt_no = v_pt_no;
        insert into MOOORIJD value (select * from MOOORIJD@DL_PROD_MIG where pt_no = v_pt_no);

        --처치
        delete MOOORFED where pt_no = v_pt_no;
        insert into MOOORFED value (select * from MOOORFED@DL_PROD_MIG where pt_no = v_pt_no);

        --재활
        delete MSTRHSUD where pt_no = v_pt_no;
        insert into MSTRHSUD value (select * from MSTRHSUD@DL_PROD_MIG where pt_no = v_pt_no);

        --환자처치
        delete MOOORFED where pt_no = v_pt_no;
        insert into MOOORFED value (select * from MOOORFED@DL_PROD_MIG where pt_no = v_pt_no);

        --방사선
        delete MSTROORD where pt_no = v_pt_no;
        insert into MSTROORD value (select * from MSTROORD@DL_PROD_MIG where pt_no = v_pt_no);

        --수혈
        delete MOOORTFM where pt_no = v_pt_no;
        insert into MOOORTFM value (select * from MOOORTFM@DL_PROD_MIG where pt_no = v_pt_no);

        --2차오더
        delete MSERMAMD where pt_no = v_pt_no;
        insert into MSERMAMD value (select * from MSERMAMD@DL_PROD_MIG where pt_no = v_pt_no);

        --원무처방
        delete ACPPEIOE where pt_no = v_pt_no;
        insert into ACPPEIOE value (select * from ACPPEIOE@DL_PROD_MIG where pt_no = v_pt_no);

        if  v_pact_tp_cd in ('O','A') then

            --외래접수
            delete ACPPRODM where pt_no = v_pt_no;
            insert into ACPPRODM value (select * from ACPPRODM@DL_PROD_MIG where pt_no = v_pt_no);

            --외래예약유형상세
            delete ACPPRORE where pt_no = v_pt_no;
            insert into ACPPRORE value (select * from ACPPRORE@DL_PROD_MIG where pt_no = v_pt_no);

            --외래계약기관상세
            delete ACPPROOE where pt_no = v_pt_no;
            insert into ACPPROOE value (select * from ACPPROOE@DL_PROD_MIG where pt_no = v_pt_no);

            --외래계산상세
            delete ACPPEOCE where pt_no = v_pt_no;
            insert into ACPPEOCE value (select * from ACPPEOCE@DL_PROD_MIG where pt_no = v_pt_no);

            --외래수납정보
            delete ACPPEOPD where pt_no = v_pt_no;
            insert into ACPPEOPD value (select * from ACPPEOPD@DL_PROD_MIG where pt_no = v_pt_no);

            --보증금
            delete ACPPEDPD where pt_no = v_pt_no;
            insert into ACPPEDPD value (select * from ACPPEDPD@DL_PROD_MIG where pt_no = v_pt_no);

        elsif v_pact_tp_cd in ('E','A') then
        

            --응급접수
            delete ACPPRETM where pt_no = v_pt_no;
            insert into ACPPRETM value (select * from ACPPRETM@DL_PROD_MIG where pt_no = v_pt_no);

            --외래예약유형상세
            delete ACPPRORE where pt_no = v_pt_no;
            insert into ACPPRORE value (select * from ACPPRORE@DL_PROD_MIG where pt_no = v_pt_no);

            --외래계약기관상세
            delete ACPPROOE where pt_no = v_pt_no;
            insert into ACPPROOE value (select * from ACPPROOE@DL_PROD_MIG where pt_no = v_pt_no);

            --외래계산상세
            delete ACPPEOCE where pt_no = v_pt_no;
            insert into ACPPEOCE value (select * from ACPPEOCE@DL_PROD_MIG where pt_no = v_pt_no);

            --외래수납정보
            delete ACPPEOPD where pt_no = v_pt_no;
            insert into ACPPEOPD value (select * from ACPPEOPD@DL_PROD_MIG where pt_no = v_pt_no);

            --보증금
            delete ACPPEDPD where pt_no = v_pt_no;
            insert into ACPPEDPD value (select * from ACPPEDPD@DL_PROD_MIG where pt_no = v_pt_no);

        elsif v_pact_tp_cd in ('I','A') then

            --입원예약정보
            delete ACPPRARD where pt_no = v_pt_no;
            insert into ACPPRARD value (select * from ACPPRARD@DL_PROD_MIG where pt_no = v_pt_no);

            --입원접수
            delete ACPPRAAM where pt_no = v_pt_no;
            insert into ACPPRAAM value (select * from ACPPRAAM@DL_PROD_MIG where pt_no = v_pt_no);

            --전과전동
            delete ACPPRTSD where pt_no = v_pt_no;
            insert into ACPPRTSD value (select * from ACPPRTSD@DL_PROD_MIG where pt_no = v_pt_no);

            --입원환자유형상세
            delete ACPPRIRE where pt_no = v_pt_no;
            insert into ACPPRIRE value (select * from ACPPRIRE@DL_PROD_MIG where pt_no = v_pt_no);

            --재원계약기관등록정보
            delete ACPPRIOD where pt_no = v_pt_no;
            insert into ACPPRIOD value (select * from ACPPRIOD@DL_PROD_MIG where pt_no = v_pt_no);

            --입원계산상대
            delete ACPPEACD where pt_no = v_pt_no;
            insert into ACPPEACD value (select * from ACPPEACD@DL_PROD_MIG where pt_no = v_pt_no);

            --입원계약기관상세
            delete ACPPRIOE where pt_no = v_pt_no;
            insert into ACPPRIOE value (select * from ACPPRIOE@DL_PROD_MIG where pt_no = v_pt_no);

            --입원계산상세
            delete ACPPEICE where pt_no = v_pt_no;
            insert into ACPPEICE value (select * from ACPPEICE@DL_PROD_MIG where pt_no = v_pt_no);

            --입원수납정보
            delete ACPPEIPD where pt_no = v_pt_no;
            insert into ACPPEIPD value (select * from ACPPEIPD@DL_PROD_MIG where pt_no = v_pt_no);

            --보증금
            delete ACPPEDPD where pt_no = v_pt_no;
            insert into ACPPEDPD value (select * from ACPPEDPD@DL_PROD_MIG where pt_no = v_pt_no);

        end if;

    end;
end;

