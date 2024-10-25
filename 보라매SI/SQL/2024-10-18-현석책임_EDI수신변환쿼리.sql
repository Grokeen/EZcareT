

exec :intext := '81106957975최재혁              97012011676180824010995202409049999123111-정상처리                                                                                         A1501';

select length(:intext) from dual;



select
   substr(replace(:intext,' ',''),0,11)  as no
   ,substr(replace(:intext,' ',''),12,3)  as nm
   ,substr(replace(:intext,' ',''),15,13) as rrn
   ,substr(replace(:intext,' ',''),28,28) as idk
   ,substr(replace(:intext,' ',''),57,4) as res
   ,substr(replace(:intext,' ',''),-5,5) as rea_no
	 ,length(replace(:intext,' ','')) as len                         
from dual;
