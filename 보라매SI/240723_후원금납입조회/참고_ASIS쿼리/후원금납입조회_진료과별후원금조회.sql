PROCEDURE pc_sw_sel_swsupamt_deptlist (
    in_from_dte IN VARCHAR2,    -- 시작 날짜
    in_to_dte IN VARCHAR2,      -- 종료 날짜
    in_dept_cd IN VARCHAR2,     -- 부서 코드
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
                -- ft_get_dept_nm(b.clinic_cd) AS clinic_cd
                b.clinic_cd,
                -- ft_get_dept_nm(b.dept_cd) AS dept_cd
                FTB_CCDEPART_NM(b.dept_cd, 'Y'),
                ft_d_name(b.juc_dr) || '/' || ft_d_name(b.char_dr) AS dr,
                a.pt_no AS pt_no,
                c.pt_nm AS pt_nm,
                -- d.orgn_nm AS orgn_nm
                t.csubcd_nm AS orgn_nm,
                a.sup_no AS sup_no,
                TO_CHAR(a.from_dte, 'yyyy-mm-dd') AS from_dte,
                TO_CHAR(a.to_dte, 'yyyy-mm-dd') AS to_dte,
                a.sup_amt AS sup_amt,
                a.use_amt AS use_amt,
                ft_d_name(b.consult_id) AS consult_id,
                TO_CHAR(a.pay_dte, 'yyyy-mm-dd') AS pay_dte
            FROM swsupamt a
            JOIN swintakt b ON a.pt_no = b.pt_no
                AND a.talk_dte = b.talk_dte
                AND a.talk_seq = b.talk_seq
            JOIN appatbat c ON a.pt_no = c.pt_no
            LEFT JOIN cccodest t ON a.sup_grp = t.c_cd
                AND t.ccd_typ = 'SW24'
            WHERE a.pay_dte BETWEEN TO_DATE(in_from_dte, 'yyyy-mm-dd')
                AND TO_DATE(in_to_dte, 'yyyy-mm-dd')
                AND b.clinic_cd LIKE in_dept_cd || '%'
                AND a.pt_no = in_pt_no;

        out_cursor := wk_cursor;

        -- 예외 처리
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20553, 'pc_sw_sel_swsupamt_deptlist' || ' err_cd = ' || SQLCODE || SQLERRM);
    END;
END pc_sw_sel_swsupamt_deptlist;
