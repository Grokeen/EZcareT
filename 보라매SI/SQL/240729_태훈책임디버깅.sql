SELECT
*
FROM PCTPCPAM
 WHERE PT_NM LIKE '%테스트%'
 AND ROWNUM < 10;





    SELECT *
    	FROM PCTPCPAM  /*환자기본*/
    WHERE PT_NO ='04890237'
    ;;

    SELECT *
    	FROM PCTPCPTD /*환자연락처정보*/
    WHERE PT_NO ='04890237'
    ;;

    SELECT *
    	FROM ACPPRPID  /*환자보험정보*/
    WHERE PT_NO ='04890237'
    ;;