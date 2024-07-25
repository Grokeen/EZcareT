PROCEDURE pc_sw_sel_swsupamt_ptlist (
    in_from_dte IN VARCHAR2,    -- 시작 날짜
    in_to_dte IN VARCHAR2,      -- 종료 날짜
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
                c.pt_nm AS pt_nm,
                a.pt_no AS pt_no,
                -- ft_sd_diss6(a.pt_no, to_char(b.acpt_dte,'yyyy-mm-dd'),b.pt_sect,b.dept_cd) AS diss
                (SELECT a.dz_cls_cd || '  ' || a.clnc_diag_nm
                 FROM mojsangt a, medvocabulary b
                 WHERE a.pt_no = in_pt_no
                   AND a.a_acpt_dte BETWEEN TO_DATE(in_from_dte, 'yyyy-mm-dd')
                                        AND TO_DATE(in_to_dte, 'yyyy-mm-dd') + 0.99999
                   AND NVL(mn_dz_yn, 'N') = 'Y'
                   AND NVL(del_yn, 'N') = 'N'
                   AND a.clnc_diag_cd = b.vocabulary_id
                   AND ROWNUM = 1) AS diss,
                -- FT_SR_DISS(a.pt_no)
                -- ft_get_dept_nm(b.dept_cd) AS dept_cd
                FTB_CCDEPART_NM(b.dept_cd, 'Y'),
                ft_d_name(b.juc_dr) || '/' || ft_d_name(b.char_dr) AS dr,
                ft_d_name(b.consult_id) AS consult_id,
                TO_CHAR(a.from_dte, 'yyyy-mm-dd') AS from_dte,
                TO_CHAR(a.to_dte, 'yyyy-mm-dd') AS to_dte,
                -- d.orgn_nm AS orgn_nm  
                a.sup_no AS orgn_nm,
                a.sup_amt AS sup_amt,
                a.use_amt AS use_amt,
                TO_CHAR(a.pay_dte, 'yyyy-mm-dd') AS pay_dte,
                a.bigo AS bigo
            FROM swsupamt a
            JOIN swintakt b ON a.pt_no = b.pt_no
                AND a.talk_dte = b.talk_dte
                AND a.talk_seq = b.talk_seq
            JOIN appatbat c ON a.pt_no = c.pt_no
            WHERE a.pay_dte BETWEEN TO_DATE(in_from_dte, 'yyyy-mm-dd')
                                AND TO_DATE(in_to_dte, 'yyyy-mm-dd')
                AND a.pt_no = in_pt_no;

        out_cursor := wk_cursor;

        -- 예외 처리
    EXCEPTION
        WHEN OTHERS THEN
            out_cursor := NULL;
    END;
END pc_sw_sel_swsupamt_ptlist;



/*

- 기타
pt_no : 환자 번호
a_acpt_dte : 접수 날짜
dz_cls_cd : 질병 분류 코드
clnc_diag_nm : 임상 진단명
mn_dz_yn : 주요 질병 여부 (Y/N)
del_yn : 삭제 여부 (Y/N)
clnc_diag_cd : 임상 진단 코드


*/