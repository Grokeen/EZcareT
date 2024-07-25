PROCEDURE pc_sw_sel_swsupamt_grplist (
    in_from_dte IN VARCHAR2,    -- 시작 날짜
    in_to_dte IN VARCHAR2,      -- 종료 날짜
    in_sup_grp IN VARCHAR2,     -- 지원 그룹
    in_sup_no IN VARCHAR2,      -- 지원 번호
    in_pt_no IN VARCHAR2,       -- 환자 번호
    out_cursor OUT SYS_REFCURSOR -- 반환할 데이터셋
) IS
    -- 선언
    wk_cursor SYS_REFCURSOR;
BEGIN
    BEGIN
        -- 본문
        OPEN wk_cursor FOR

            SELECT 
                -- d.orgn_nm AS orgn_nm
                t.csubcd_nm AS orgn_nm,
                a.sup_no AS sup_no,
                a.pt_no AS pt_no,
                c.pt_nm AS pt_nm,
                TO_CHAR(a.from_dte, 'yyyy-mm-dd') AS from_dte,
                TO_CHAR(a.to_dte, 'yyyy-mm-dd') AS to_dte,
                a.sup_amt AS sup_amt,
                a.use_amt AS use_amt,
                -- ft_get_dept_nm(b.dept_cd) AS dept_cd
                FTB_CCDEPART_NM(b.dept_cd, 'Y') AS dept_nm,
                ft_d_name(b.juc_dr) || '/' || ft_d_name(b.char_dr) AS dr,
                ft_d_name(b.consult_id) AS consult_id,
                TO_CHAR(a.pay_dte, 'yyyy-mm-dd') AS pay_dte
            FROM 
                swsupamt a
                JOIN swintakt b ON a.pt_no = b.pt_no
                   AND a.talk_dte = b.talk_dte
                   AND a.talk_seq = b.talk_seq
                JOIN appatbat c ON a.pt_no = c.pt_no
                LEFT JOIN cccodest t ON a.sup_grp = t.c_cd
                   AND t.ccd_typ = 'SW24'
            WHERE 
                a.pay_dte BETWEEN TO_DATE(in_from_dte, 'yyyy-mm-dd') AND TO_DATE(in_to_dte, 'yyyy-mm-dd')
                AND a.sup_grp = NVL(in_sup_grp, a.sup_grp)
                AND a.sup_no LIKE in_sup_no || '%'
                AND a.pt_no = b.pt_no
                AND a.talk_dte = b.talk_dte
                AND a.talk_seq = b.talk_seq
                AND a.pt_no = c.pt_no
                AND a.sup_grp(+) = t.c_cd
                AND t.ccd_typ(+) = 'SW24'
                AND a.pt_no = in_pt_no;

        out_cursor := wk_cursor;

        -- 예외 처리
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20553, 'pc_sw_sel_swsupamt_grplist' || ' err_cd = ' || SQLCODE || SQLERRM);
    END;
END pc_sw_sel_swsupamt_grplist;



/*
swsupamt 테이블의 면담 순번(a.talk_seq)
swintakt 테이블의 면담 순번(b.talk_seq)

cccodest 테이블의 공통 코드 유형(t.ccd_typ)이 'SW24'와 일치하는지 확인되며, 이 조건도 LEFT JOIN에 해당.


*/