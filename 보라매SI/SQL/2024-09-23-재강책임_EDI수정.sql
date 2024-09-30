


select
NVL
( DECODE
    ( SUBSTR ( XBIL.FT_TELNO_ADJUST ( F.SMS_TEL_NO ) , 1 , 3 ) , '010' , DECODE
        ( SUBSTR ( XBIL.FT_TELNO_ADJUST ( F.OHS_TEL_NO ) , 1 , 3 ) , '010' , ''
            , '011' , ''
            , '016' , ''
            , '017' , ''
            , '018' , ''
            , '019' , ''
            , XBIL.FT_TELNO_ADJUST ( F.OHS_TEL_NO ) ) , '011' , DECODE
        ( SUBSTR ( XBIL.FT_TELNO_ADJUST ( F.OHS_TEL_NO ) , 1 , 3 ) , '010' , ''
            , '011' , ''
            , '016' , ''
            , '017' , ''
            , '018' , ''
            , '019' , ''
            , XBIL.FT_TELNO_ADJUST ( F.OHS_TEL_NO ) ) , '016' , DECODE
        ( SUBSTR ( XBIL.FT_TELNO_ADJUST ( F.OHS_TEL_NO ) , 1 , 3 ) , '010' , ''
            , '011' , ''
            , '016' , ''
            , '017' , ''
            , '018' , ''
            , '019' , ''
            , XBIL.FT_TELNO_ADJUST ( F.OHS_TEL_NO ) ) , '017' , DECODE
        ( SUBSTR ( XBIL.FT_TELNO_ADJUST ( F.OHS_TEL_NO ) , 1 , 3 ) , '010' , ''
            , '011' , ''
            , '016' , ''
            , '017' , ''
            , '018' , ''
            , '019' , ''
            , XBIL.FT_TELNO_ADJUST ( F.OHS_TEL_NO ) ) , '018' , DECODE
        ( SUBSTR ( XBIL.FT_TELNO_ADJUST ( F.OHS_TEL_NO ) , 1 , 3 ) , '010' , ''
            , '011' , ''
            , '016' , ''
            , '017' , ''
            , '018' , ''
            , '019' , ''
            , XBIL.FT_TELNO_ADJUST ( F.OHS_TEL_NO ) ) , '019' , DECODE
        ( SUBSTR ( XBIL.FT_TELNO_ADJUST ( F.OHS_TEL_NO ) , 1 , 3 ) , '010' , ''
            , '011' , ''
            , '016' , ''
            , '017' , ''
            , '018' , ''
            , '019' , ''
            , XBIL.FT_TELNO_ADJUST ( F.OHS_TEL_NO ) ) , XBIL.FT_TELNO_ADJUST ( F.MTEL_NO ) ) , NVL ( XBIL.FT_TELNO_ADJUST ( A.HMPS_TEL_NO ) , XBIL.FT_TELNO_ADJUST ( F.MTEL_NO ) ) )
C6   


from 
ACPPRGHD a       

,XBIL.PCTPCPAV f