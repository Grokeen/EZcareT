using System;
using System.Runtime.Serialization;
using HIS.Core.Common;
using HIS.Core.Global.DTO;
using HSF.TechSvc2010.Common;


namespace HIS.PA.AC.PE.PS.DTO
{
	/// <summary>
	/// name          :	SelSeriousIllnessApplicationFormEDIReg4_OUT DTO
	/// desc          :	#DTO클래스 개요
	/// author        :	songminsu
	/// create date   :	2016-04-15 오전 10:36:53
	/// update date   :	2016-04-15 오전 10:36:53	/// </summary>
	[Serializable]
	[DataContract]
	public class SelSeriousIllnessApplicationFormEDIReg4_OUT : HISDTOBase
	{

        private string c1;  //1.건강보험 증번호
        private string c2;  //2.가입자(세대주)성명
        private string c3;  //3.수진자성명 
        private string c4;  //4.수진자주민번호
        private string c5;  //5.휴대전화번호
        private string c6;  //6.자택전화번호
        private string c7;  //7.우편번호
        private string c8;  //8.주소(기본)
        private string c9;  //9.주소(상세)
        private string c10; //10.등록결과통보방법(1(SMS), 2(E-MAIL))
        private string c11; //11.이메일주소
        private string c12; //12.질환구분(2(희귀질환), 5(극희귀질환), 6(상세불명희귀질환), 7(중증치매), 8(중증난치), 9(기타염색체 이상질환))
        private string c13; //13.신청구분(N:신규등록, Y:재등록) 
        private string c14; //14.진료과목
        private string c15; //15.진료구분(1:입원, 2:외래)
        private string c16; //16.진단확진일자
        private string c17; //17.특정기호
        private string c18; //18.상병코드
        private string c19; //19.상병코드 중복연번
        private string c20; //20.최종확진방법_1번
        private string c21; //21.최종확진방법_1_1번
        private string c22; //22.최종확진방법_1_2번
        private string c23; //23.최종확진방법_1_3번
        private string c24; //24.최종확진방법_1_4번
        private string c25; //25.최종확진방법_1_5번
        private string c26; //26.최종확진방법_1_5번 내용
        private string c27; //27.최종확진방법_2번
        private string c28; //28.최종확진방법_3번
        private string c29; //29.최종확진방법_4번
        private string c30; //30.최종확진방법_5번
        private string c31; //31.최종확진방법_5번 내용
        private string c32; //32.최종확진방법_6번
        private string c33; //33.최종확진방법_6번 내용
        private string c34; //34.가족력 없음
        private string c35; //35.가족력 있음
        private string c36; //36.가족력_있음_1(조부)
        private string c37; //37.가족력_있음_2(조모)
        private string c38; //38.가족력_있음_3(외조부)
        private string c39; //39.가족력_있음_4(외조모)
        private string c40; //40.가족력_있음_5(부)
        private string c41; //41.가족력_있음_6(모)
        private string c42; //42.가족력_있음_7(동성형제)
        private string c43; //43.가족력_있음_8(이성형제)
        private string c44; //44.가족력_있음_9(자)
        private string c45; //45.가족력_있음_10(녀)
        private string c46; //46.요양기관명
        private string c47; //47.요양기관기호
        private string c48; //48.입력자 주민번호
        private string c49; //49.의사면허번호
        private string c50; //50.담당자의사성명
        private string c51; //51.전문의자격번호
        private string c52; //52.담당의사전문과목
        private string c53; //53.신청자성명
        private string c54; //54.수진자와의 관계
        private string c55; //55.발행일자
        private string c56; //56.신청일자

        private string pt_no;	// 환자번호
		private string meddept;	// 진료과
		private string sendyn;	// 송신여부
		private string senddate;	// 송신일자
		private string msg;	// Error Message 1.환자 Sign 존재여부
		private Decimal? doctor_note_id;	// 진료기록ID
		private string aidyn;	// 건강보험의료급여구분코드
		private string dup_cncr_yn;   // 중복암 접수구분 1,2,3,4

        /// <summary>
        /// name : 1.건강보험 증번호
        /// </summary>
        [DataMember]
        public string C1
        {
            get { return this.c1; }
            set { if (this.c1 != value) { this.c1 = value; base.OnPropertyChanged("C1", value); } }
        }

        /// <summary>
        /// name : 2.가입자(세대주)성명
        /// </summary>
        [DataMember]
        public string C2
        {
            get { return this.c2; }
            set { if (this.c2 != value) { this.c2 = value; base.OnPropertyChanged("C2", value); } }
        }

        /// <summary>
        /// name : 3.수진자성명
        /// </summary>
        [DataMember]
        public string C3
        {
            get { return this.c3; }
            set { if (this.c3 != value) { this.c3 = value; base.OnPropertyChanged("C3", value); } }
        }

        /// <summary>
        /// name : 4.수진자주민번호
        /// </summary>
        [DataMember]
        public string C4
        {
            get { return this.c4; }
            set { if (this.c4 != value) { this.c4 = value; base.OnPropertyChanged("C4", value); } }
        }

        /// <summary>
        /// name : 5.휴대전화번호
        /// </summary>
        [DataMember]
        public string C5
        {
            get { return this.c5; }
            set { if (this.c5 != value) { this.c5 = value; base.OnPropertyChanged("C5", value); } }
        }

        /// <summary>
        /// name : 6.자택전화번호
        /// </summary>
        [DataMember]
        public string C6
        {
            get { return this.c6; }
            set { if (this.c6 != value) { this.c6 = value; base.OnPropertyChanged("C6", value); } }
        }

        /// <summary>
        /// name : 7.우편번호
        /// </summary>
        [DataMember]
        public string C7
        {
            get { return this.c7; }
            set { if (this.c7 != value) { this.c7 = value; base.OnPropertyChanged("C7", value); } }
        }

        /// <summary>
        /// name : 8.주소(기본)
        /// </summary>
        [DataMember]
        public string C8
        {
            get { return this.c8; }
            set { if (this.c8 != value) { this.c8 = value; base.OnPropertyChanged("C8", value); } }
        }

        /// <summary>
        /// name : 9.주소(상세)
        /// </summary>
        [DataMember]
        public string C9
        {
            get { return this.c9; }
            set { if (this.c9 != value) { this.c9 = value; base.OnPropertyChanged("C9", value); } }
        }

        /// <summary>
        /// name : 10.등록결과통보방법
        /// </summary>
        [DataMember]
        public string C10
        {
            get { return this.c10; }
            set { if (this.c10 != value) { this.c10 = value; base.OnPropertyChanged("C10", value); } }
        }

        /// <summary>
        /// name : 11.이메일주소
        /// </summary>
        [DataMember]
        public string C11
        {
            get { return this.c11; }
            set { if (this.c11 != value) { this.c11 = value; base.OnPropertyChanged("C11", value); } }
        }

        /// <summary>
        /// name : 12.질환구분
        /// </summary>
        [DataMember]
        public string C12
        {
            get { return this.c12; }
            set { if (this.c12 != value) { this.c12 = value; base.OnPropertyChanged("C12", value); } }
        }

        /// <summary>
        /// name : 13.신청구분
        /// </summary>
        [DataMember]
        public string C13
        {
            get { return this.c13; }
            set { if (this.c13 != value) { this.c13 = value; base.OnPropertyChanged("C13", value); } }
        }

        /// <summary>
        /// name : 14.진료과목
        /// </summary>
        [DataMember]
        public string C14
        {
            get { return this.c14; }
            set { if (this.c14 != value) { this.c14 = value; base.OnPropertyChanged("C14", value); } }
        }

        /// <summary>
        /// name : 15.진료구분
        /// </summary>
        [DataMember]
        public string C15
        {
            get { return this.c15; }
            set { if (this.c15 != value) { this.c15 = value; base.OnPropertyChanged("C15", value); } }
        }

        /// <summary>
        /// name : 16.진단확진일자
        /// </summary>
        [DataMember]
        public string C16
        {
            get { return this.c16; }
            set { if (this.c16 != value) { this.c16 = value; base.OnPropertyChanged("C16", value); } }
        }

        /// <summary>
        /// name : 17.특정기호
        /// </summary>
        [DataMember]
        public string C17
        {
            get { return this.c17; }
            set { if (this.c17 != value) { this.c17 = value; base.OnPropertyChanged("C17", value); } }
        }

        /// <summary>
        /// name : 18.상병코드
        /// </summary>
        [DataMember]
        public string C18
        {
            get { return this.c18; }
            set { if (this.c18 != value) { this.c18 = value; base.OnPropertyChanged("C18", value); } }
        }

        /// <summary>
        /// name : 19.상병코드 중복연번
        /// </summary>
        [DataMember]
        public string C19
        {
            get { return this.c19; }
            set { if (this.c19 != value) { this.c19 = value; base.OnPropertyChanged("C19", value); } }
        }

        /// <summary>
        /// name : 20.최종확진방법_1번
        /// </summary>
        [DataMember]
        public string C20
        {
            get { return this.c20; }
            set { if (this.c20 != value) { this.c20 = value; base.OnPropertyChanged("C20", value); } }
        }

        /// <summary>
        /// name : 21.최종확진방법_1_1번
        /// </summary>
        [DataMember]
        public string C21
        {
            get { return this.c21; }
            set { if (this.c21 != value) { this.c21 = value; base.OnPropertyChanged("C21", value); } }
        }

        /// <summary>
        /// name : 22.최종확진방법_1_2번
        /// </summary>
        [DataMember]
        public string C22
        {
            get { return this.c22; }
            set { if (this.c22 != value) { this.c22 = value; base.OnPropertyChanged("C22", value); } }
        }

        /// <summary>
        /// name : 23.최종확진방법_1_3번
        /// </summary>
        [DataMember]
        public string C23
        {
            get { return this.c23; }
            set { if (this.c23 != value) { this.c23 = value; base.OnPropertyChanged("C23", value); } }
        }

        /// <summary>
        /// name : 24.최종확진방법_1_4번
        /// </summary>
        [DataMember]
        public string C24
        {
            get { return this.c24; }
            set { if (this.c24 != value) { this.c24 = value; base.OnPropertyChanged("C24", value); } }
        }

        /// <summary>
        /// name : 25.최종확진방법_1_5번
        /// </summary>
        [DataMember]
        public string C25
        {
            get { return this.c25; }
            set { if (this.c25 != value) { this.c25 = value; base.OnPropertyChanged("C24", value); } }
        }

        /// <summary>
        /// name : 26.최종확진방법_1_5번 내용
        /// </summary>
        [DataMember]
        public string C26
        {
            get { return this.c26; }
            set { if (this.c26 != value) { this.c26 = value; base.OnPropertyChanged("C26", value); } }
        }

        /// <summary>
        /// name : 27.최종확진방법_2번
        /// </summary>
        [DataMember]
        public string C27
        {
            get { return this.c27; }
            set { if (this.c27 != value) { this.c27 = value; base.OnPropertyChanged("C27", value); } }
        }

        /// <summary>
        /// name : 28.최종확진방법_3번
        /// </summary>
        [DataMember]
        public string C28
        {
            get { return this.c28; }
            set { if (this.c28 != value) { this.c28 = value; base.OnPropertyChanged("C28", value); } }
        }

        /// <summary>
        /// name : 29.최종확진방법_4번
        /// </summary>
        [DataMember]
        public string C29
        {
            get { return this.c29; }
            set { if (this.c29 != value) { this.c29 = value; base.OnPropertyChanged("C29", value); } }
        }

        /// <summary>
        /// name : 30.최종확진방법_5번
        /// </summary>
        [DataMember]
        public string C30
        {
            get { return this.c30; }
            set { if (this.c30 != value) { this.c30 = value; base.OnPropertyChanged("C30", value); } }
        }

        /// <summary>
        /// name : 31.최종확진방법_5번 내용
        /// </summary>
        [DataMember]
        public string C31
        {
            get { return this.c31; }
            set { if (this.c31 != value) { this.c31 = value; base.OnPropertyChanged("C31", value); } }
        }

        /// <summary>
        /// name : 32.최종확진방법_6번
        /// </summary>
        [DataMember]
        public string C32
        {
            get { return this.c32; }
            set { if (this.c32 != value) { this.c32 = value; base.OnPropertyChanged("C32", value); } }
        }

        /// <summary>
        /// name : 33.최종확진방법_6번 내용
        /// </summary>
        [DataMember]
        public string C33
        {
            get { return this.c33; }
            set { if (this.c33 != value) { this.c33 = value; base.OnPropertyChanged("C33", value); } }
        }

        /// <summary>
        /// name : 34.가족력 없음
        /// </summary>
        [DataMember]
        public string C34
        {
            get { return this.c34; }
            set { if (this.c34 != value) { this.c34 = value; base.OnPropertyChanged("C34", value); } }
        }

        /// <summary>
        /// name : 35.가족력 있음
        /// </summary>
        [DataMember]
        public string C35
        {
            get { return this.c35; }
            set { if (this.c35 != value) { this.c35 = value; base.OnPropertyChanged("C35", value); } }
        }

        /// <summary>
        /// name : 36.가족력_있음_1(조부)
        /// </summary>
        [DataMember]
        public string C36
        {
            get { return this.c36; }
            set { if (this.c36 != value) { this.c36 = value; base.OnPropertyChanged("C36", value); } }
        }

        /// <summary>
        /// name : 37.가족력_있음_2(조모)
        /// </summary>
        [DataMember]
        public string C37
        {
            get { return this.c37; }
            set { if (this.c37 != value) { this.c37 = value; base.OnPropertyChanged("C37", value); } }
        }

        /// <summary>
        /// name : 38.가족력_있음_3(외조부)
        /// </summary>
        [DataMember]
        public string C38
        {
            get { return this.c38; }
            set { if (this.c38 != value) { this.c38 = value; base.OnPropertyChanged("C38", value); } }
        }

        /// <summary>
        /// name : 39.가족력_있음_4(외조모)
        /// </summary>
        [DataMember]
        public string C39
        {
            get { return this.c39; }
            set { if (this.c39 != value) { this.c39 = value; base.OnPropertyChanged("C39", value); } }
        }

        /// <summary>
        /// name : 40.가족력_있음_5(부)
        /// </summary>
        [DataMember]
        public string C40
        {
            get { return this.c40; }
            set { if (this.c40 != value) { this.c40 = value; base.OnPropertyChanged("C40", value); } }
        }

        /// <summary>
        /// name : 41.가족력_있음_6(모)
        /// </summary>
        [DataMember]
        public string C41
        {
            get { return this.c41; }
            set { if (this.c41 != value) { this.c41 = value; base.OnPropertyChanged("C41", value); } }
        }

        /// <summary>
        /// name : 42.가족력_있음_7(동성형제)
        /// </summary>
        [DataMember]
        public string C42
        {
            get { return this.c42; }
            set { if (this.c42 != value) { this.c42 = value; base.OnPropertyChanged("C42", value); } }
        }

        /// <summary>
        /// name : 43.가족력_있음_8(이성형제)
        /// </summary>
        [DataMember]
        public string C43
        {
            get { return this.c43; }
            set { if (this.c43 != value) { this.c43 = value; base.OnPropertyChanged("C43", value); } }
        }

        /// <summary>
        /// name : 44.가족력_있음_9(자)
        /// </summary>
        [DataMember]
        public string C44
        {
            get { return this.c44; }
            set { if (this.c44 != value) { this.c44 = value; base.OnPropertyChanged("C44", value); } }
        }

        /// <summary>
        /// name : 45.가족력_있음_10(녀)
        /// </summary>
        [DataMember]
        public string C45
        {
            get { return this.c45; }
            set { if (this.c45 != value) { this.c45 = value; base.OnPropertyChanged("C45", value); } }
        }

        /// <summary>
        /// name : 46.요양기관명
        /// </summary>
        [DataMember]
        public string C46
        {
            get { return this.c46; }
            set { if (this.c46 != value) { this.c46 = value; base.OnPropertyChanged("C46", value); } }
        }

        /// <summary>
        /// name : 47.요양기관기호
        /// </summary>
        [DataMember]
        public string C47
        {
            get { return this.c47; }
            set { if (this.c47 != value) { this.c47 = value; base.OnPropertyChanged("C47", value); } }
        }

        /// <summary>
        /// name : 48.입력자 주민번호
        /// </summary>
        [DataMember]
        public string C48
        {
            get { return this.c48; }
            set { if (this.c48 != value) { this.c48 = value; base.OnPropertyChanged("C48", value); } }
        }

        /// <summary>
        /// name : 49.의사면허번호
        /// </summary>
        [DataMember]
        public string C49
        {
            get { return this.c49; }
            set { if (this.c49 != value) { this.c49 = value; base.OnPropertyChanged("C49", value); } }
        }

        /// <summary>
        /// name : 50.담당자의사성명
        /// </summary>
        [DataMember]
        public string C50
        {
            get { return this.c50; }
            set { if (this.c50 != value) { this.c50 = value; base.OnPropertyChanged("C50", value); } }
        }

        /// <summary>
        /// name : 51.전문의자격번호
        /// </summary>
        [DataMember]
        public string C51
        {
            get { return this.c51; }
            set { if (this.c51 != value) { this.c51 = value; base.OnPropertyChanged("C51", value); } }
        }

        /// <summary>
        /// name : 52.담당의사전문과목
        /// </summary>
        [DataMember]
        public string C52
        {
            get { return this.c52; }
            set { if (this.c52 != value) { this.c52 = value; base.OnPropertyChanged("C52", value); } }
        }

        /// <summary>
        /// name : 53.신청자성명
        /// </summary>
        [DataMember]
        public string C53
        {
            get { return this.c53; }
            set { if (this.c53 != value) { this.c53 = value; base.OnPropertyChanged("C53", value); } }
        }

        /// <summary>
        /// name : 54.수진자와의 관계
        /// </summary>
        [DataMember]
        public string C54
        {
            get { return this.c54; }
            set { if (this.c54 != value) { this.c54 = value; base.OnPropertyChanged("C54", value); } }
        }

        /// <summary>
        /// name : 55.발행일자
        /// </summary>
        [DataMember]
        public string C55
        {
            get { return this.c55; }
            set { if (this.c55 != value) { this.c55 = value; base.OnPropertyChanged("C55", value); } }
        }

        /// <summary>
        /// name : 56.신청일자
        /// </summary>
        [DataMember]
        public string C56
        {
            get { return this.c56; }
            set { if (this.c56 != value) { this.c56 = value; base.OnPropertyChanged("C56", value); } }
        }

        /// <summary>
        /// name : 환자번호
        /// </summary>
        [DataMember]
		public string PT_NO
		{
			get { return this.pt_no; }
			set { if (this.pt_no != value) { this.pt_no = value; base.OnPropertyChanged("PT_NO", value); } }
		}

		/// <summary>
		/// name : 진료과
		/// </summary>
		[DataMember]
		public string MEDDEPT
		{
			get { return this.meddept; }
			set { if (this.meddept != value) { this.meddept = value; base.OnPropertyChanged("MEDDEPT", value); } }
		}

		/// <summary>
		/// name : 송신여부
		/// </summary>
		[DataMember]
		public string SENDYN
		{
			get { return this.sendyn; }
			set { if (this.sendyn != value) { this.sendyn = value; base.OnPropertyChanged("SENDYN", value); } }
		}

		/// <summary>
		/// name : 송신일자
		/// </summary>
		[DataMember]
		public string SENDDATE
		{
			get { return this.senddate; }
			set { if (this.senddate != value) { this.senddate = value; base.OnPropertyChanged("SENDDATE", value); } }
		}

		/// <summary>
		/// name : Error Message 1.환자 Sign 존재여부
		/// </summary>
		[DataMember]
		public string MSG
		{
			get { return this.msg; }
			set { if (this.msg != value) { this.msg = value; base.OnPropertyChanged("MSG", value); } }
		}

        /// <summary>
        /// name : 진료기록ID
        /// </summary>
        [DataMember]
        public Decimal? DOCTOR_NOTE_ID
        {
            get { return this.doctor_note_id; }
            set { if (this.doctor_note_id != value) { this.doctor_note_id = value; base.OnPropertyChanged("DOCTOR_NOTE_ID", value); } }
        }

        /// <summary>
        /// name : 건강보험의료급여구분코드
        /// </summary>
        [DataMember]
        public string AIDYN
        {
            get { return this.aidyn; }
            set { if (this.aidyn != value) { this.aidyn = value; base.OnPropertyChanged("AIDYN", value); } }
        }

        /// <summary>
        /// name : 중복암 접수구분
        /// </summary>
        [DataMember]
        public string DUP_CNCR_YN
        {
            get { return this.dup_cncr_yn; }
            set { if (this.dup_cncr_yn != value) { this.dup_cncr_yn = value; base.OnPropertyChanged("DUP_CNCR_YN", value); } }
        }

        

    }
}

