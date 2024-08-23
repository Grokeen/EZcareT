using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Collections.ObjectModel;
using DH.Entity;
using DH.Lib;
using System.ComponentModel;
using System.Collections;
using System.Windows.Threading;
using System.Dynamic;
using System.Threading.Tasks;
using System.Threading;
using System.Data;
using System.IO;
using System.Diagnostics;
using System.Deployment.Application;
using System.Xml.Serialization;

namespace DH.View
{

    /// <summary>
    /// DBHelper.xaml에 대한 상호 작용 논리
    /// </summary>
    public partial class DBHelper : UCBase
    {
        public bool IsSelectWithStart = false;

        private ObservableCollection<TableInfo> ocTableInfo = new ObservableCollection<TableInfo>();
        private ObservableCollection<TableInfo> ocFavTableInfo = new ObservableCollection<TableInfo>();
        private ObservableCollection<ColInfo> ocColInfo = new ObservableCollection<ColInfo>();
        private ObservableCollection<RefObj> ocRefObj = new ObservableCollection<RefObj>();
        private ObservableCollection<IndexInfo> ocIndexInfo = new ObservableCollection<IndexInfo>();
        private ObservableCollection<TableAddInfo> ocTableAddInfo = new ObservableCollection<TableAddInfo>();
        private ObservableCollection<CCCCCSTE> ocCommonCodeInfo = new ObservableCollection<CCCCCSTE>();

        public DBHelper()
        {
            InitializeComponent();
        }


        private void BtnSelect_Click(object sender, RoutedEventArgs e)
        {
            this.chkOwnerFilter.IsChecked = false;
            this.chkOwnerFilter_Click(null, null);

            Task task = Task.Factory.StartNew(() =>
            {
                this.Dispatcher.Invoke(() => { GetTableList(); });
            });

        }


        private void cbOwner_Click(object sender, RoutedEventArgs e)
        {
            if (this.tabMain.SelectedIndex == 0)
                CollectionViewSource.GetDefaultView(dgdObjList.ItemsSource).Refresh();
            else if (this.tabMain.SelectedIndex == 1)
                CollectionViewSource.GetDefaultView(dgdFavObjList.ItemsSource).Refresh();
        }


        private void SetButtonToolTip(string txt)
        {
            ToolTip t = new ToolTip();
            t.Content = $"다음 Owner의 테이블은 조회하지 않습니다.(Setting에서 설정)\n\n{txt}";
            t.Background = Brushes.Beige;
            t.Foreground = Brushes.DarkGreen;
            t.FontSize = 14;

            this.BtnSelect.ToolTip = t;
            ToolTipService.SetInitialShowDelay(this.BtnSelect, 10);
        }

        public void GetTableList()
        {
            //if (ocTableInfo.Count > 0) return;

            this.ProgressOn();

            this.ClearSort(dgdObjList);

            ocTableInfo.Clear();

            var p = DBSvc.CreateEntity<TableInfo>();
            //p.OWNER = Application.Current.Properties["ServiceName"].ToString();
            p.QueryId = "DH.SELECT.TABLEINFO.S01";
            //p.KEYWORD = txtKeyword.Text.Trim(); // like 검색
            p.EX_OWNER = this.GetExcludeOwner(); //제외할 Owner리스트
            this.SetButtonToolTip(p.EX_OWNER);

            DBSvc.Param.Add(p);
            DBSvc.Result.Add(ocTableInfo);

            try
            {

                this.Dispatcher.Invoke(DispatcherPriority.Send, (ThreadStart)delegate ()
                {
                    this.dgdObjList.Dispatcher.BeginInvoke(DispatcherPriority.Input, (Action)delegate ()
                    {
                        DBSvc.Select();


                        List<CheckBoxItem> items = new List<CheckBoxItem>();

                        foreach (var item in ocTableInfo.OrderBy(o => o.OWNER).Select(d => d.OWNER).Distinct())
                        {
                            items.Add(new CheckBoxItem() { Name = item, IsChecked = false });
                        }

                        cblOwner.ItemsSource = items;
                    });
                });

            }
            catch (Exception ex)
            {
                this.OwnerWindow.ShowMsgBox(ex.Message, 3000);
            }
            if (ocTableInfo.Count > 0)
            {
                dgdObjList.SelectedIndex = 0;
            }

            this.ProgressOff();


        }

        CollectionView view;
        CollectionView view2;
        CollectionView view_col;
        CollectionView view_obj;
        private void UserControl_Loaded(object sender, RoutedEventArgs e)
        {
            //this.GridRowCommonCodeGrid.Height = new GridLength(0);


            dgdObjList.ItemsSource = ocTableInfo;
            view = (CollectionView)CollectionViewSource.GetDefaultView(dgdObjList.ItemsSource);
            view.Filter = UserFilter;

            dgdFavObjList.ItemsSource = ocFavTableInfo;
            view2 = (CollectionView)CollectionViewSource.GetDefaultView(dgdFavObjList.ItemsSource);
            view2.Filter = UserFilter;

            dgdColInfo.ItemsSource = ocColInfo;
            view_col = (CollectionView)CollectionViewSource.GetDefaultView(dgdColInfo.ItemsSource);
            view_col.Filter = UserFilter_Col;


            dgdRefObjList.ItemsSource = ocRefObj;
            view_obj = (CollectionView)CollectionViewSource.GetDefaultView(dgdRefObjList.ItemsSource);
            view_obj.Filter = UserFilter_Obj;

            dgdIndexInfo.ItemsSource = ocIndexInfo;
            dgdTableAddInfo.ItemsSource = ocTableAddInfo;
            dgdCommonCodeInfo.ItemsSource = ocCommonCodeInfo; //공통코드

            txtKeyword.Focus();

            if (this.IsSelectWithStart)
            {
                if (this.OwnerWindow.IsSettingCompleted == false) return;

                //if (Application.Current.Properties["ServiceName"] != null)
                this.BtnSelect_Click(null, null);

                this.IsSelectWithStart = false;
            }


            this.Loaded -= UserControl_Loaded;

            this.cboAndOr.SelectionChanged -= cboAndOr_SelectionChanged;
            this.cboAndOr.SelectionChanged += cboAndOr_SelectionChanged;

            this.cboAndOrCol.SelectionChanged -= cboAndOr_SelectionChanged;
            this.cboAndOrCol.SelectionChanged += cboAndOr_SelectionChanged;

            this.cboAndOrObj.SelectionChanged -= cboAndOr_SelectionChanged;
            this.cboAndOrObj.SelectionChanged += cboAndOr_SelectionChanged;
        }

        private void txtKeyword_TextChanged(object sender, TextChangedEventArgs e)
        {
            if (this.chkRealTime.IsChecked == true)
            {
                if (this.tabMain.SelectedIndex == 0)
                    CollectionViewSource.GetDefaultView(dgdObjList.ItemsSource).Refresh();
                else if (this.tabMain.SelectedIndex == 1)
                    CollectionViewSource.GetDefaultView(dgdFavObjList.ItemsSource).Refresh();
            }
        }
        private void txtKeywordCol_TextChanged(object sender, TextChangedEventArgs e)
        {
            if (this.chkRealTime.IsChecked == true)
                CollectionViewSource.GetDefaultView(dgdColInfo.ItemsSource).Refresh();
        }
        private void txtKeywordObj_TextChanged(object sender, TextChangedEventArgs e)
        {
            if (this.chkRealTime.IsChecked == true)
                CollectionViewSource.GetDefaultView(dgdRefObjList.ItemsSource).Refresh();
        }


        private void txtKeyword_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.Key == Key.Enter)
            {
                if (this.tabMain.SelectedIndex == 0)
                    CollectionViewSource.GetDefaultView(dgdObjList.ItemsSource).Refresh();
                else if (this.tabMain.SelectedIndex == 1)
                    CollectionViewSource.GetDefaultView(dgdFavObjList.ItemsSource).Refresh();
            }
        }

        private void txtKeywordCol_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.Key == Key.Enter)
            {
                CollectionViewSource.GetDefaultView(dgdColInfo.ItemsSource).Refresh();
            }
        }

        private void txtKeywordObj_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.Key == Key.Enter)
            {
                CollectionViewSource.GetDefaultView(dgdRefObjList.ItemsSource).Refresh();
            }
        }

        private bool UserFilter(object item)
        {
            bool result = false;
            string[] arrKeyword;
            if (this.chkOwnerFilter.IsChecked == true)
            {
                string owner_list = this.GetSelectedOnwer();
                if (owner_list != "ALL" && owner_list != "")
                {
                    arrKeyword = owner_list.Split(',');
                    foreach (var str in arrKeyword)
                    {
                        if (string.IsNullOrEmpty(str)) continue;

                        result = ((item as TableInfo).OWNER == str);

                        if (result) break;
                    }
                }
                if (result == false) return false;
            }

            if (String.IsNullOrEmpty(txtKeyword.Text)) return true;

            arrKeyword = txtKeyword.Text.Split(',');
            result = false;
            foreach (var str in arrKeyword)
            {
                if (string.IsNullOrEmpty(str)) continue;

                result = (((item as TableInfo).OWNER.IndexOf(str, StringComparison.OrdinalIgnoreCase) >= 0)
                    || ((item as TableInfo).TABLE_NAME.IndexOf(str, StringComparison.OrdinalIgnoreCase) >= 0)
                    || ((item as TableInfo).TABLE_COMMENTS.IndexOf(str, StringComparison.OrdinalIgnoreCase) >= 0));


                if (this.cboAndOr.SelectedValue.ToString() == "AND")
                {
                    if (result == false) return false; //&& 조건으로 모두 충족해야 true 리턴함.
                }
                else
                {
                    if (result == true) return true; //|| 조건으로 하나만 충족해야 true 리턴함.
                }
            }
            return result;



        }

        private string GetSelectedOnwer()
        {
            string owner_list = "";
            int cnt = 0;
            foreach (CheckBoxItem item in this.cblOwner.Items)
            {
                if (item.IsChecked)
                {
                    cnt++;
                    owner_list += "," + item.Name;
                }
            }

            if (cnt == this.cblOwner.Items.Count)
                return "ALL";

            if (owner_list != "")
            {
                owner_list = owner_list.Substring(1);
            }


            return owner_list;

        }

        private bool UserFilter_Col(object item)
        {
            if (String.IsNullOrEmpty(txtKeywordCol.Text))
                return true;
            else
            {
                string[] arrKeyword = txtKeywordCol.Text.Split(',');
                bool result = false;
                foreach (var str in arrKeyword)
                {
                    if (string.IsNullOrEmpty(str)) continue;

                    result = (((item as ColInfo).COL_NAME.IndexOf(str, StringComparison.OrdinalIgnoreCase) >= 0) || (this.NVL((item as ColInfo).COMMENTS, "").IndexOf(str, StringComparison.OrdinalIgnoreCase) >= 0));

                    if (this.cboAndOrCol.SelectedValue.ToString() == "AND")
                    {
                        if (result == false) return false; //&& 조건으로 모두 충족해야 true 리턴함.
                    }
                    else
                    {
                        if (result == true) return true; //|| 조건으로 하나만 충족해야 true 리턴함.
                    }
                }
                return result;


            }
        }

        private bool UserFilter_Obj(object item)
        {
            if (String.IsNullOrEmpty(txtKeywordObj.Text))
                return true;
            else
            {
                string[] arrKeyword = txtKeywordObj.Text.Split(',');
                bool result = false;
                foreach (var str in arrKeyword)
                {
                    if (string.IsNullOrEmpty(str)) continue;

                    result = (((item as RefObj).OWNER.IndexOf(str, StringComparison.OrdinalIgnoreCase) >= 0)
                    || ((item as RefObj).OBJ_NAME.IndexOf(str, StringComparison.OrdinalIgnoreCase) >= 0)
                    || ((item as RefObj).OBJ_TYPE.IndexOf(str, StringComparison.OrdinalIgnoreCase) >= 0));

                    if (this.cboAndOrObj.SelectedValue.ToString() == "AND")
                    {
                        if (result == false) return false; //&& 조건으로 모두 충족해야 true 리턴함.
                    }
                    else
                    {
                        if (result == true) return true; //|| 조건으로 하나만 충족해야 true 리턴함.
                    }
                }
                return result;
            }
        }


        bool IsASyncGetTableDetail = true;
        private void dgdObjList_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (IsASyncGetTableDetail)
            {
                this.Dispatcher.Invoke(DispatcherPriority.Send, (ThreadStart)delegate ()
                {
                    this.dgdColInfo.Dispatcher.BeginInvoke(DispatcherPriority.Input, (Action)delegate ()
                    {

                        this.ClearSort(dgdColInfo);
                        this.ClearSort(dgdIndexInfo);
                        this.ClearSort(dgdRefObjList);
                        this.ClearSort(dgdTableAddInfo);


                        this.GetTableInfo();

                        //this.GetRefObjList();

                        //this.GetIndexInfo();

                        //this.GetTableAddInfo();
                        this.ProgressOff();
                    });
                });
            }
            else
            {
                //Create문 생성시는 동기호출함. 

                this.ClearSort(dgdColInfo);
                this.ClearSort(dgdIndexInfo);
                this.ClearSort(dgdRefObjList);
                this.ClearSort(dgdTableAddInfo);

                this.GetTableInfo();

                this.ProgressOff();
            }
        }


        private void GetTableInfo()
        {
            txtKeywordCol.Text = "";

            ocColInfo.Clear();
            ocRefObj.Clear();
            ocIndexInfo.Clear();
            ocTableAddInfo.Clear();

            TableInfo item = null;

            if (this.tabMain.SelectedIndex == 0)
                item = dgdObjList.SelectedItem as TableInfo;
            else if (this.tabMain.SelectedIndex == 1)
                item = dgdFavObjList.SelectedItem as TableInfo;

            if (item == null) return;

            // 컬럼정보
            var p1 = DBSvc.CreateEntity<ColInfo>();
            p1.OWNER = item.OWNER; // cboDB.Text;
            p1.QueryId = "DH.SELECT.COLINFO.S01";
            p1.TABLE_NAME = item.TABLE_NAME;

            DBSvc.Param.Add(p1);
            DBSvc.Result.Add(ocColInfo);

            // RefObj
            var p2 = DBSvc.CreateEntity<RefObj>();
            p2.QueryId = "DH.SELECT.REFOBJ.S01";
            p2.TABLE_NAME = item.TABLE_NAME;

            DBSvc.Param.Add(p2);
            DBSvc.Result.Add(ocRefObj);

            // Index
            var p3 = DBSvc.CreateEntity<IndexInfo>();
            p3.QueryId = "DH.SELECT.INDEXINFO.S01";
            p3.OWNER = item.OWNER;
            p3.TABLE_NAME = item.TABLE_NAME;

            DBSvc.Param.Add(p3);
            DBSvc.Result.Add(ocIndexInfo);

            // 추가정보
            var p4 = DBSvc.CreateEntity<TableAddInfo>();
            p4.QueryId = "DH.SELECT.TABLEADDINFO.S01";
            p4.TABLE_NAME = item.TABLE_NAME;

            DBSvc.Param.Add(p4);
            DBSvc.Result.Add(ocTableAddInfo);

            DBSvc.Select();


        }

        //private void GetRefObjList()
        //{
        //    ocRefObj.Clear();

        //    var item = dgdObjList.SelectedItem as TableInfo;

        //    if (item == null) return;

        //    var p2 = DBSvc.CreateEntity<RefObj>();
        //    p2.QueryId = "DH.SELECT.REFOBJ.S01";
        //    p2.TABLE_NAME = item.TABLE_NAME;

        //    DBSvc.Param.Add(p2);
        //    DBSvc.Result.Add(ocRefObj);

        //    DBSvc.Select();
        //}
        //private void GetIndexInfo()
        //{
        //    ocIndexInfo.Clear();

        //    var item = dgdObjList.SelectedItem as TableInfo;

        //    if (item == null) return;

        //    var p3 = DBSvc.CreateEntity<IndexInfo>();
        //    p3.QueryId = "DH.SELECT.INDEXINFO.S01";
        //    p3.TABLE_NAME = item.TABLE_NAME;

        //    DBSvc.Param.Add(p3);
        //    DBSvc.Result.Add(ocIndexInfo);

        //    DBSvc.Select();
        //}
        //private void GetTableAddInfo()
        //{
        //    ocTableAddInfo.Clear();

        //    var item = dgdObjList.SelectedItem as TableInfo;

        //    if (item == null) return;

        //    var p4 = DBSvc.CreateEntity<TableAddInfo>();
        //    p4.QueryId = "DH.SELECT.TABLEADDINFO.S01";
        //    p4.TABLE_NAME = item.TABLE_NAME;

        //    DBSvc.Param.Add(p4);
        //    DBSvc.Result.Add(ocTableAddInfo);

        //    DBSvc.Select();
        //}



        private void GetCommonCodeInfo(string comn_grp_cd)
        {
            ocCommonCodeInfo.Clear();

            var p4 = DBSvc.CreateEntity<CCCCCSTE>();
            p4.QueryId = "DH.SELECT.CCCCCSTE.S01";
            p4.TABLE_NM = "CCCCCSTE";
            p4.COMN_GRP_CD = comn_grp_cd;

            DBSvc.Param.Add(p4);
            DBSvc.Result.Add(ocCommonCodeInfo);

            DBSvc.Select();

            //if(ocCommonCodeInfo.Count > 0)
            //    this.GridRowCommonCodeGrid.Height = new GridLength(223); //공통코드 그리드 높이
        }



















        private const string TAB = "    ";
        private string BR = Environment.NewLine;
        private string SUMMARY = string.Format("{0}{0}/// <summary>{1}{0}{0}/// #TITLE#{1}{0}{0}/// </summary>", TAB, Environment.NewLine);
        //private string 

        private void DTO_Property_Click(object sender, RoutedEventArgs e)
        {
            this.MakeDTOProperty("");

        }

        private void DTO_InProperty_Click(object sender, RoutedEventArgs e)
        {
            this.MakeDTOProperty("in_");
        }

        private void MakeDTOProperty(string prefix)
        {
            IList items = dgdColInfo.SelectedItems;


            string txt = "";
            string datatype;
            string blank;
            foreach (ColInfo item in items)
            {
                blank = GetBlank(prefix + item.COL_NAME);
                datatype = GetDataType(item);

                if (item.COMMENTS == null) item.COMMENTS = "";

                txt += string.Format(@"{1}{1}private {2} {3};{0}", BR, TAB, datatype, (prefix + item.COL_NAME).ToLower());
                txt += SUMMARY.Replace("#TITLE#", item.COMMENTS.Trim());
                txt += string.Format(@"{0}{1}{1}[DataMember]{0}", BR, TAB);
                txt += string.Format(@"{1}{1}public {2} {3}{0}", BR, TAB, datatype, (prefix + item.COL_NAME).ToUpper());
                txt += string.Format(@"{1}{1}{{ {0}", BR, TAB);
                txt += string.Format(@"{1}{1}{1}get {{ return this.{2}; }}{0}", BR, TAB, (prefix + item.COL_NAME).ToLower());
                txt += string.Format(@"{1}{1}{1}set {{ if (this.{2} != value) {{ this.{2} = value; OnPropertyChanged(""{3}"", value); }} }}{0}", BR, TAB, (prefix + item.COL_NAME).ToLower(), (prefix + item.COL_NAME).ToUpper());
                txt += string.Format(@"{1}{1}}} {0}{0}", BR, TAB);
            }
            //\{0\}

            //Clipboard.SetData(DataFormats.Text, txt);
            //this.OwnerWindow.ShowMsgBox("클립보드에 복사했습니다.");

            this.OpenCodeWIndow(txt);
        }

        private string GetDataType(ColInfo item)
        {
            //if (item.DATATYPE == "DATE" || item.DATATYPE.IndexOf("TIMESTAMP") > 0) return "DateTime";
            //else if (item.DATATYPE.IndexOf("NUMBER") > 0) return "decimal";

            if (item.DATATYPE.IndexOf("NUMBER") > -1) return "string";
            else
            {
                return "string";
            }

        }



        private string GetBlank(string txt)
        {
            return GetBlank(txt, 50);
        }
        private string GetBlank(string txt, int len)
        {
            int blank_cnt = len - txt.Length;

            if (blank_cnt < 1) return "";

            string blank = "";
            for (int i = 0; i < blank_cnt; i++)
            {
                blank += " ";
            }
            return blank;
        }
        private void DataSet_SetColumn_Click(object sender, RoutedEventArgs e)
        {
            IList items = dgdColInfo.SelectedItems;

            if (items == null) return;

            string txt = "\t\t\t" + "ds.AddRow();" + Environment.NewLine;
            string blank;
            foreach (ColInfo item in items)
            {
                blank = GetBlank(item.COL_NAME);

                txt += string.Format(@"{0}{1}{1}{1}ds.SetColumn(0, ""{2}""{3}, VALUE ); ", Environment.NewLine, "\t", item.COL_NAME, blank);
            }

            //Clipboard.SetData(DataFormats.Text, txt);

            //this.OwnerWindow.ShowMsgBox("클립보드에 복사했습니다.");

            this.OpenCodeWIndow(txt);

        }
        private void DataSet_ColInfo_Click(object sender, RoutedEventArgs e)
        {
            IList items = dgdColInfo.SelectedItems;

            if (items == null) return;

            string txt = "";
            string blank;
            foreach (ColInfo item in items)
            {
                blank = GetBlank(item.COL_NAME);

                txt += string.Format(@"{0}{0}{0}{0}{0}<colinfo id=""{1}""{2} size=""256"" summ=""default"" type=""STRING""/>{3}", "\t", item.COL_NAME, blank, Environment.NewLine);
            }
            this.OpenCodeWIndow(txt);

        }

        private void Grid_HeadBody_Click(object sender, RoutedEventArgs e)
        {
            IList items = dgdColInfo.SelectedItems;

            if (items == null) return;

            string col = "\t\t\t\t\t" + "<columns>";
            string head = "\t\t\t\t\t" + "<head>";
            string body = "\t\t\t\t\t" + "<body>";

            int idx = 0;
            foreach (ColInfo item in items)
            {
                col += string.Format(@"{0}{1}{1}{1}{1}{1}{1}<col width=""100""/>"
                                     , Environment.NewLine
                                     , "\t");

                head += string.Format(@"{0}{1}{1}{1}{1}{1}{1}<cell col=""{2}"" color=""user8"" display=""text"" text=""{3}""/>"
                                     , Environment.NewLine
                                     , "\t"
                                     , idx
                                     , item.COMMENTS);

                body += string.Format(@"{0}{1}{1}{1}{1}{1}{1}<cell align=""center"" col=""{2}"" colid=""{3}"" display=""text""/>"
                                     , Environment.NewLine
                                     , "\t"
                                     , idx
                                     , item.COL_NAME);

                idx++;
            }

            col += Environment.NewLine + "\t\t\t\t\t" + "</columns>";
            head += Environment.NewLine + "\t\t\t\t\t" + "</head>";
            body += Environment.NewLine + "\t\t\t\t\t" + "</body>";

            this.OpenCodeWIndow(col + Environment.NewLine + head + Environment.NewLine + body);

        }

        private void Grid_C_Property_Click(object sender, RoutedEventArgs e)
        {
            IList items = dgdColInfo.SelectedItems;
            TableInfo table_info = dgdObjList.SelectedItem as TableInfo;

            string txt = "";
            string rmap = "<resultMaps>";
            rmap += string.Format(@"{1}  <resultMap id=""rm{0}"" class=""DH.Entity.{0}"">", table_info.TABLE_NAME, Environment.NewLine);

            string type = "";
            foreach (ColInfo item in items)
            {
                if (item.DATATYPE.IndexOf("NUMBER") > -1)
                {
                    type = "int";
                }
                else if (item.DATATYPE.IndexOf("DATE") > -1)
                {
                    type = "DateTime";
                }
                else
                {
                    type = "string";
                }

                txt += string.Format(@"{0}public {1} {2} {3}", Environment.NewLine, type, item.COL_NAME, "{ get; set; }");
                rmap += string.Format(@"{0}    <result property=""{1}"" column=""{1}"" />", Environment.NewLine, item.COL_NAME);
            }

            rmap += Environment.NewLine + "  </resultMap>";
            rmap += Environment.NewLine + "</resultMaps>";


            this.OpenCodeWIndow(txt + Environment.NewLine + Environment.NewLine + rmap);

        }

        private void Qeury_Insert_Click(object sender, RoutedEventArgs e)
        {
            IList items = dgdColInfo.SelectedItems;
            TableInfo table_info = dgdObjList.SelectedItem as TableInfo;

            if (items == null || table_info == null) return;

            string txt = "INSERT /* HIS.EQSID */" + Environment.NewLine;
            txt += "  INTO " + table_info.TABLE_NAME + Environment.NewLine;
            txt += "     (" + Environment.NewLine;



            string col = "";
            string val = "";

            int idx = 0;
            foreach (ColInfo item in items)
            {
                idx++;

                col += "     ";
                val += "     ";
                if (idx == 1)
                {
                    col += "  ";
                    val += "  ";
                }
                else
                {
                    col += ", ";
                    val += ", ";
                }


                col += item.COL_NAME + GetBlank(item.COL_NAME) + " /*" + item.COMMENTS + "*/" + Environment.NewLine;

                val += this.GetInParameter(item) + Environment.NewLine;

            }

            txt += col;
            txt += "     )" + Environment.NewLine;
            txt += "VALUES" + Environment.NewLine;
            txt += "     (" + Environment.NewLine;
            txt += val;
            txt += "     )" + Environment.NewLine;


            this.OpenCodeWIndow(txt);
        }

        private string GetInParameter(ColInfo item)
        {
            string in_col_name = ":IN_" + item.COL_NAME;

            if (item.COL_NAME.EndsWith("HSP_TP_CD")) in_col_name = ":HIS_HSP_TP_CD";
            else if (item.COL_NAME.EndsWith("STF_NO")) in_col_name = ":HIS_STF_NO";
            else if (item.COL_NAME.EndsWith("PRGM_NM")) in_col_name = ":HIS_PRGM_NM";
            else if (item.COL_NAME.EndsWith("IP_ADDR")) in_col_name = ":HIS_IP_ADDR";
            else if (item.COL_NAME.EndsWith("DT") || item.COL_NAME.EndsWith("DTM")) in_col_name = "SYSDATE";

            return in_col_name;
        }

        private void Qeury_Select_Click(object sender, RoutedEventArgs e)
        {
            MenuItem mi = (MenuItem)sender;
            string alias = "";

            TextBox tb = this.FindChild<TextBox>(mi, "tbSelectAlias");
            if (tb != null)
            {
                alias = tb.Text.Trim();
            }

            IList items = dgdColInfo.SelectedItems;
            TableInfo table_info = dgdObjList.SelectedItem as TableInfo;

            if (items == null || table_info == null) return;

            string txt = "SELECT /* HIS.EQSID */" + Environment.NewLine;
            int idx = 0;



            foreach (ColInfo item in items)
            {
                idx++;

                txt += "     ";
                if (idx == 1)
                {
                    txt += "  ";
                }
                else
                {
                    txt += ", ";
                }

                string col_name = this.CheckCol(item, alias);

                txt += col_name + GetBlank(col_name) + item.COL_NAME + GetBlank(item.COL_NAME, 30) + " /*" + item.COMMENTS + "*/" + Environment.NewLine;
            }
            txt += "  FROM " + table_info.TABLE_NAME + " " + alias + Environment.NewLine;
            txt += " WHERE " + GetPkCol(alias);

            this.OpenCodeWIndow(txt);


        }


        private string CheckCol(ColInfo item, string alias)
        {
            if (!string.IsNullOrEmpty(alias)) alias += ".";


            if (item.DATATYPE.IndexOf("NUMBER") > -1) return $"TO_CHAR({alias}{item.COL_NAME})";
            else if (item.DATATYPE.IndexOf("DATE") > -1)
            {
                if (item.COL_NAME.EndsWith("DTM"))
                    return $"TO_CHAR({alias}{item.COL_NAME}, 'YYYY-MM-DD HH24:MI:SS')";
                else
                    return $"TO_CHAR({alias}{item.COL_NAME}, 'YYYY-MM-DD')";
            }

            return alias + item.COL_NAME;

        }

        private void Qeury_Update_Click(object sender, RoutedEventArgs e)
        {
            IList items = dgdColInfo.SelectedItems;
            TableInfo table_info = dgdObjList.SelectedItem as TableInfo;

            if (items == null || table_info == null) return;

            string txt = "UPDATE /* HIS.EQSID */" + Environment.NewLine;
            txt += "       " + table_info.TABLE_NAME + Environment.NewLine;

            int idx = 0;
            foreach (ColInfo item in items)
            {
                idx++;

                if (idx == 1)
                {
                    txt += "   ";
                    txt += "SET ";
                }
                else
                {
                    txt += "     ";
                    txt += ", ";
                }
                string in_col_name = this.GetInParameter(item);
                txt += item.COL_NAME + GetBlank(item.COL_NAME) + " = " + in_col_name + GetBlank(in_col_name) + " /*" + item.COMMENTS + "*/" + Environment.NewLine;
            }
            txt += " WHERE " + GetPkCol();

            this.OpenCodeWIndow(txt);

        }


        private void Qeury_Merge_Click(object sender, RoutedEventArgs e)
        {
            IList items = dgdColInfo.SelectedItems;
            TableInfo table_info = dgdObjList.SelectedItem as TableInfo;

            if (items == null || table_info == null) return;

            string txt = "MERGE /* HIS.EQSID */ " + Environment.NewLine;
            txt += " INTO " + table_info.TABLE_NAME + Environment.NewLine;
            txt += "USING DUAL" + Environment.NewLine;
            txt += "ON (" + Environment.NewLine;
            txt += "       " + GetPkCol() + Environment.NewLine;
            txt += "   ) " + Environment.NewLine;
            txt += "WHEN MATCHED THEN" + Environment.NewLine;
            txt += "UPDATE" + Environment.NewLine;

            int idx = 0;
            foreach (ColInfo item in items)
            {
                //PK는 업데이트문에서 제외
                if (this.IsPkCol(item.COL_NAME)) continue;

                idx++;

                if (idx == 1)
                {
                    txt += "   ";
                    txt += "SET ";
                }
                else
                {
                    txt += "     ";
                    txt += ", ";
                }

                string in_col_name = this.GetInParameter(item);

                txt += item.COL_NAME + GetBlank(item.COL_NAME) + " = " + in_col_name + GetBlank(in_col_name) + " /*" + item.COMMENTS + "*/" + Environment.NewLine;
            }

            txt += "WHEN NOT MATCHED THEN" + Environment.NewLine;
            txt += "INSERT" + Environment.NewLine;
            txt += "     (" + Environment.NewLine;



            string col = "";
            string val = "";

            idx = 0;
            foreach (ColInfo item in items)
            {
                idx++;

                col += "     ";
                val += "     ";
                if (idx == 1)
                {
                    col += "  ";
                    val += "  ";
                }
                else
                {
                    col += ", ";
                    val += ", ";
                }
                col += item.COL_NAME + GetBlank(item.COL_NAME) + " /*" + item.COMMENTS + "*/" + Environment.NewLine;

                string in_col_name = this.GetInParameter(item);

                val += in_col_name + Environment.NewLine;

            }

            txt += col;
            txt += "     )" + Environment.NewLine;
            txt += "VALUES" + Environment.NewLine;
            txt += "     (" + Environment.NewLine;
            txt += val;
            txt += "     )" + Environment.NewLine;



            this.OpenCodeWIndow(txt);
        }

        private void Qeury_Delete_Click(object sender, RoutedEventArgs e)
        {
            IList items = dgdColInfo.SelectedItems;
            TableInfo table_info = dgdObjList.SelectedItem as TableInfo;

            if (items == null || table_info == null) return;

            string txt = "DELETE /* HIS.EQSID */" + Environment.NewLine;
            txt += "       FROM " + table_info.TABLE_NAME + Environment.NewLine;
            txt += " WHERE " + GetPkCol();

            this.OpenCodeWIndow(txt);

        }



        private string GetPkCol()
        {
            return this.GetPkCol("");
        }


        private string GetPkCol(string table_alias)
        {
            string where = "";
            try
            {
                if (string.IsNullOrEmpty(table_alias) == false) table_alias += ".";

                foreach (IndexInfo item in dgdIndexInfo.Items)
                {
                    if (item.INDEX_NAME.IndexOf("PK") > -1)
                    {
                        if (where.Length > 0)
                        {
                            where += "   AND ";
                        }

                        //string data_type = this.GetColDataType(item.COL_NAME);
                        string in_col_name = ":IN_" + item.COL_NAME;

                        if (item.COL_NAME.EndsWith("HSP_TP_CD")) in_col_name = ":HIS_HSP_TP_CD";
                        else if (item.COL_NAME.EndsWith("STF_NO")) in_col_name = ":HIS_STF_NO";


                        if (item.COL_NAME.EndsWith("DTM"))
                        {
                            where += table_alias + item.COL_NAME + this.GetBlank(item.COL_NAME, 30) + " = TO_DATE(" + in_col_name + ", 'YYYY-MM-DD HH24:MI:SS')" + Environment.NewLine;
                        }
                        else if (item.COL_NAME.EndsWith("DT"))
                        {
                            where += table_alias + item.COL_NAME + this.GetBlank(item.COL_NAME, 30) + " = TO_DATE(" + in_col_name + ", 'YYYY-MM-DD')" + Environment.NewLine;
                        }
                        else
                        {
                            where += table_alias + item.COL_NAME + this.GetBlank(item.COL_NAME, 30) + " = " + in_col_name + Environment.NewLine;
                        }

                    }
                }

            }
            catch
            {
            }
            return where;

        }



        private bool IsPkCol(string col_name)
        {
            var index_col = ocIndexInfo.Where(d => d.COL_NAME == col_name).FirstOrDefault();
            if (index_col == null) return false;

            if (index_col.INDEX_NAME.IndexOf("PK") > -1)
            {
                return true;
            }

            return false;

        }


        private string GetColDataType(string col_name)
        {
            foreach (ColInfo item in dgdColInfo.Items)
            {
                if (item.COL_NAME == col_name)
                {
                    return item.DATATYPE;
                }
            }
            return "";
        }

        private string GetPkColSetVar()
        {
            string exec = "";
            string value = "";

            foreach (IndexInfo item in dgdIndexInfo.Items)
            {
                if (item.INDEX_NAME.IndexOf("PK") > -1)
                {
                    value = "";
                    if (item.COL_NAME.IndexOf("HSP_") > -1)
                        value = "01";

                    exec += "EXEC :IN_" + item.COL_NAME + " := '" + value + "';" + Environment.NewLine;
                }
            }

            return exec;

        }



        private void button1_Click(object sender, RoutedEventArgs e)
        {
            dynamic d = new TestDynaminObject();
            d.Test = "";


            var x = new TestDynaminObject() as IDictionary<string, Object>;
            x.Add("NewProp", string.Empty);

        }

        //public void SetDB(string username)
        //{
        //    this.cboDB.Text = username;
        //}

        private void UCBase_GotFocus(object sender, RoutedEventArgs e)
        {
            //GetTableList();
        }



        public string GetCommonGroupCode(string col_name)
        {
            var setting_item = this.OwnerWindow.OcBasicSetting.Where(d => d.CODE == "MetaConnectionString").FirstOrDefault();
            if (setting_item == null)
            {
                this.OwnerWindow.ShowMsgBox("META# ConnectionString이 셋팅되지 않았습니다. Setting 탭에서 설정해주세요.", 3000);
                return "";
            }

            if (string.IsNullOrEmpty(setting_item.VALUE)) return "";

            string metaConnectionString = setting_item.VALUE;
            string query = string.Format(
                @"SELECT CD_VAL COMN_GRP_CD
                    FROM STD_CODE
                   WHERE CD_ENG_NM = '{0}' ", col_name);

            try
            {
                DataSet ds = DBSvc.ExecuteQuery(metaConnectionString, query);
                if (ds != null)
                {
                    DataTable dt = ds.Tables[0];

                    if (dt.Rows.Count == 0)
                        return "";
                    else
                        return dt.Rows[0]["COMN_GRP_CD"].ToString();
                }

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString());
            }

            return "";
        }

        private void DgdColInfo_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            this.ocCommonCodeInfo.Clear();
            //공통코드 그리드 숨김
            //this.GridRowCommonCodeGrid.Height = new GridLength(0);

            var item = dgdColInfo.SelectedItem as ColInfo;
            if (item == null)
            {
                return;
            }
            string comn_grp_cd = this.GetCommonGroupCode(item.COL_NAME);

            if (!string.IsNullOrEmpty(comn_grp_cd))
            {
                this.GetCommonCodeInfo(comn_grp_cd);
            }
        }

        private void BtnMakeQuery_Click(object sender, RoutedEventArgs e)
        {
            MakeQuery(false);
        }
        private void BtnMakeQuery2_Click(object sender, RoutedEventArgs e)
        {
            MakeQuery(true);
        }

        private void MakeQuery(bool isIncludeParamValue)
        {
            //MessageBox.Show("X");

            var item = dgdObjList.SelectedItem as TableInfo;

            if (item == null) return;


            string query = MakeQueryBasic();

            //MessageBox.Show("[쿼리 복사됨]" + Environment.NewLine + Environment.NewLine + query);

            if (isIncludeParamValue)
            {
                string exec = this.GetPkColSetVar();
                string where = this.GetPkCol("A");
                query = exec + Environment.NewLine + Environment.NewLine + query + string.Format("   AND {0}", where);

            }
            query += "   ;";

            try
            {
                Clipboard.SetDataObject(query);
                //Clipboard.SetText(query, TextDataFormat.UnicodeText);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private string MakeQueryBasic()
        {
            var item = dgdObjList.SelectedItem as TableInfo;
            string table_comment = "";
            if (string.IsNullOrEmpty(item.TABLE_COMMENTS) == false) table_comment = " -- " + item.TABLE_COMMENTS;
            string query = string.Format("SELECT A.*{0}  FROM {1} A{2}{0} WHERE 1=1{0}   AND ROWNUM < 100{0}", Environment.NewLine, item.TABLE_NAME, table_comment);

            //MessageBox.Show("[쿼리 복사됨]" + Environment.NewLine + Environment.NewLine + query);

            return query;
        }

        private void dgdObjList_CopyingRowClipboardContent(object sender, DataGridRowClipboardEventArgs e)
        {
            var item = e.ClipboardRowContent[dgdObjList.CurrentCell.Column.DisplayIndex];
            e.ClipboardRowContent.Clear();
            e.ClipboardRowContent.Add(item);
        }

        private void dgdFavObjList_CopyingRowClipboardContent(object sender, DataGridRowClipboardEventArgs e)
        {
            var item = e.ClipboardRowContent[dgdFavObjList.CurrentCell.Column.DisplayIndex];
            e.ClipboardRowContent.Clear();
            e.ClipboardRowContent.Add(item);
        }
        private void BtnSelectQuery_Click(object sender, RoutedEventArgs e)
        {


            SelectQuery uc = this.OwnerWindow.GetTabItem("tiSelectQuery") as SelectQuery;
            if (uc == null) return;

            this.OwnerWindow.SelectTabItem("tiSelectQuery");

            string query = MakeQueryBasic();
            uc.ExcuteSelectQuery(query);

        }


        private void BtnOpenPLEdit_Click(object sender, RoutedEventArgs e)
        {
            var item = dgdRefObjList.SelectedItem as RefObj;
            if (item == null) return;

            string dbsource_txt = "";

            if (item.OBJ_TYPE.ToUpper() == "VIEW") dbsource_txt = this.GetViewSourceText(item.OWNER, item.OBJ_NAME.Trim());
            else dbsource_txt = this.GetDBSourceText(item.OBJ_NAME.Trim());

            if (dbsource_txt != "")
            {
                string pledit_path = this.GetBasicSettingValue("PLEditPath");

                if (!File.Exists(pledit_path))
                {
                    this.OwnerWindow.ShowMsgBox("PLEdit 경로를 확인하세요.\n\n" + pledit_path, 3000);
                    return;
                }

                string src_file_path = this.SaveTempTextFile(item.OBJ_NAME.ToLower() + ".sql", dbsource_txt);

                //using (Process p = new Process())
                //{
                //    p.StartInfo.FileName = pledit_path;
                //    p.StartInfo.Arguments = "\"" + src_file_path + "\"";
                //    p.Start();
                //}

                this.ExecuteProgram(pledit_path, src_file_path);

                return;
            }
        }

        private void tbSelectAlias_TextChanged(object sender, TextChangedEventArgs e)
        {
            Dispatcher.BeginInvoke
            (
                DispatcherPriority.ContextIdle,
                new Action
                (
                    delegate
                    {
                        (sender as TextBox).Text = (sender as TextBox).Text.ToUpper();
                    }
                )
            );
        }

        private void tbSelectAlias_GotFocus(object sender, RoutedEventArgs e)
        {
            Dispatcher.BeginInvoke
            (
                DispatcherPriority.ContextIdle,
                new Action
                (
                    delegate
                    {
                        (sender as TextBox).SelectAll();
                    }
                )
            );
        }

        private void tbSelectAlias_TextChanged_1(object sender, TextChangedEventArgs e)
        {

        }

        private void chkOwnerFilter_Click(object sender, RoutedEventArgs e)
        {
            if (this.chkOwnerFilter.IsChecked == true)
                this.rdOwner.Height = GridLength.Auto;
            else
            {
                this.rdOwner.Height = new GridLength(0);
            }

            if (this.tabMain.SelectedIndex == 0)
                CollectionViewSource.GetDefaultView(dgdObjList.ItemsSource).Refresh();
            else if (this.tabMain.SelectedIndex == 1)
                CollectionViewSource.GetDefaultView(dgdFavObjList.ItemsSource).Refresh();

        }

        private void cboAndOr_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            ComboBox cbo = sender as ComboBox;

            if (cbo.Name == "cboAndOr")
            {
                if (string.IsNullOrEmpty(this.txtKeyword.Text) == false)
                {
                    if (this.tabMain.SelectedIndex == 0)
                        CollectionViewSource.GetDefaultView(dgdObjList.ItemsSource).Refresh();
                    else if (this.tabMain.SelectedIndex == 1)
                        CollectionViewSource.GetDefaultView(dgdFavObjList.ItemsSource).Refresh();
                }
            }

            if (cbo.Name == "cboAndOrCol")
            {
                if (string.IsNullOrEmpty(this.txtKeywordCol.Text) == false)
                    CollectionViewSource.GetDefaultView(dgdColInfo.ItemsSource).Refresh();
            }

            if (cbo.Name == "cboAndOrObj")
            {
                if (string.IsNullOrEmpty(this.txtKeywordObj.Text) == false)
                    CollectionViewSource.GetDefaultView(dgdRefObjList.ItemsSource).Refresh();
            }
        }



        private void Qeury_Create_Click(object sender, RoutedEventArgs e)
        {
            //TableInfo table_info = dgdObjList.SelectedItem as TableInfo;
            //IList tables = dgdObjList.SelectedItems.Clone;

            if (tabMain.SelectedIndex == 0)
                this.MakeTableDDLCreate(dgdObjList.SelectedItems);
            else
                this.MakeTableDDLCreate(dgdFavObjList.SelectedItems);

        }

        public void MakeTableDDLCreate(IList table_list)
        {
            var tables = new List<TableInfo>();
            foreach (var item in table_list)
            {
                tables.Add(item as TableInfo);
            }

            //선택하지 않은 상태로
            dgdObjList.SelectedIndex = -1;

            this.IsASyncGetTableDetail = false; //비동기 호출 사용중지

            string sql = "";
            foreach (TableInfo table_info in tables)
            {
                //선택하여 컬럼 및 인덱스 정보 조회
                dgdObjList.SelectedIndex = dgdObjList.Items.IndexOf(table_info);

                sql += MakeDDLCreate(table_info);
            }


            this.IsASyncGetTableDetail = true; //비동기 호출 사용

            this.OpenCodeWIndow(sql);

            //처음 선택된 상태로 
            dgdObjList.SelectedItems.Clear();
            foreach (TableInfo table_info in tables)
            {
                dgdObjList.SelectedItems.Add(table_info);
            }
        }

        private string MakeDDLCreate(TableInfo table_info)
        {
            IList items = dgdColInfo.Items;

            if (items == null || table_info == null) return "";

            string comment = "";
            string sql = "--DROP TABLE " + table_info.TABLE_NAME + ";" + Environment.NewLine + Environment.NewLine;
            sql += "CREATE TABLE " + table_info.TABLE_NAME + Environment.NewLine;
            sql += "(" + Environment.NewLine;

            int idx = 0;
            foreach (ColInfo item in items)
            {
                idx++;


                sql += "    " + item.COL_NAME + GetBlank(item.COL_NAME) + item.DATATYPE + (item.NULLABLE == "N" ? " NOT NULL" : "");
                comment += $"COMMENT ON COLUMN {table_info.TABLE_NAME}.{item.COL_NAME} IS '{item.COMMENTS}';" + Environment.NewLine;

                if (idx != items.Count)
                    sql += ",";

                sql += Environment.NewLine;

            }
            sql += ");" + Environment.NewLine;

            comment += $"COMMENT ON TABLE {table_info.TABLE_NAME} IS '{table_info.TABLE_COMMENTS}';" + Environment.NewLine;

            string pk = $"CREATE UNIQUE INDEX {table_info.TABLE_NAME}_PK ON {table_info.TABLE_NAME}" + Environment.NewLine;
            pk += "(";

            string index = "";

            string pk_cols = "";
            foreach (IndexInfo item in dgdIndexInfo.Items)
            {
                if (item.INDEX_NAME.IndexOf("PK") > -1)
                {
                    pk_cols += ", " + item.COL_NAME;
                }
            }

            if (pk_cols == "")
            {
                pk = "";
            }
            else
            {
                pk_cols = pk_cols.Substring(2);

                pk += pk_cols + ");" + Environment.NewLine;

                index = $"ALTER TABLE {table_info.TABLE_NAME}" + Environment.NewLine;
                index += $"ADD CONSTRAINT {table_info.TABLE_NAME}_PK PRIMARY KEY({pk_cols})" + Environment.NewLine;
                index += $"USING INDEX {table_info.TABLE_NAME}_PK; ";
            }


            sql += Environment.NewLine + comment + Environment.NewLine + pk + Environment.NewLine + index;

            return sql;
        }

        private void LoadFavTableList()
        {
            string file_path = this.GetFavTableListFilePath();


            if (!File.Exists(file_path)) return;

            XmlSerializer xs = new XmlSerializer(typeof(ObservableCollection<TableInfo>));

            ObservableCollection<TableInfo> xdata = null;
            using (StreamReader rd = new StreamReader(file_path))
            {
                xdata = xs.Deserialize(rd) as ObservableCollection<TableInfo>;
            }


            if (this.ocFavTableInfo == null) this.ocFavTableInfo = new ObservableCollection<TableInfo>();
            this.ocFavTableInfo.Clear();

            foreach (var item in xdata)
            {
                this.ocFavTableInfo.Add(item);

            }
        }


        private void SaveFavTableList()
        {
            var is_dup = this.ocFavTableInfo.GroupBy(x => x.TABLE_NAME).All(g => g.Count() > 1);

            if (is_dup)
            {
                MessageBox.Show("중복되는 항목이 있습니다.");
                return;
            }


            string file_path = this.GetFavTableListFilePath();

            XmlSerializer xs = new XmlSerializer(typeof(ObservableCollection<TableInfo>));
            using (StreamWriter wr = new StreamWriter(file_path))
            {
                xs.Serialize(wr, ocFavTableInfo);

                wr.Close();
            }

            //this.OwnerWindow.ShowMsgBox("저장완료.");
            this.OwnerWindow.ShowMsgBox("저장완료", 1000);


        }

        public string GetFavTableListFilePath()
        {
            string file_path = "";
            if (ApplicationDeployment.IsNetworkDeployed)
            {
                var deployment = ApplicationDeployment.CurrentDeployment;
                string file_name = string.Format(@"FavTableInfo.xml");
                file_path = System.IO.Path.Combine(deployment.DataDirectory, file_name);
            }
            else
            {
                file_path = string.Format(@".\Config\FavTableInfo.xml");
            }

            return file_path;
        }

        private void tabMain_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (e.Source is TabControl)
            {

                if (this.tabMain.SelectedIndex == 0)
                {
                    if (this.dgdObjList.SelectedItem != null)
                        this.dgdObjList_SelectionChanged(null, null);
                }
                else if (this.tabMain.SelectedIndex == 1)
                {
                    if (this.ocFavTableInfo == null || this.ocFavTableInfo.Count == 0)
                        this.LoadFavTableList();

                    if (this.dgdFavObjList.SelectedItem != null)
                        this.dgdObjList_SelectionChanged(null, null);
                }
            }
        }

        private void Fav_Add_Click(object sender, RoutedEventArgs e)
        {
            var item = dgdObjList.SelectedItem as TableInfo;
            var new_item = (TableInfo)item.Clone();

            if (this.ocFavTableInfo.Count(d => d.TABLE_NAME == item.TABLE_NAME) > 0)
            {
                this.OwnerWindow.ShowMsgBox("이미 추가된 항목입니다.", 3000);
                return;
            }

            this.ocFavTableInfo.Insert(0, new_item);

            this.SaveFavTableList();

        }

        private void BtnUp_Click(object sender, RoutedEventArgs e)
        {
            var item = dgdFavObjList.SelectedItem as TableInfo;
            if (item == null) return;

            if (item == this.ocFavTableInfo.FirstOrDefault()) return;

            var new_item = item.Clone() as TableInfo;
            var new_idx = this.ocFavTableInfo.IndexOf(item) - 1;


            this.ocFavTableInfo.Insert(new_idx, new_item);
            this.ocFavTableInfo.Remove(item);

            this.dgdFavObjList.SelectedItem = new_item;
        }

        private void BtnDown_Click(object sender, RoutedEventArgs e)
        {
            var item = dgdFavObjList.SelectedItem as TableInfo;
            if (item == null) return;

            if (item == this.ocFavTableInfo.LastOrDefault()) return;

            var new_item = item.Clone() as TableInfo;
            var new_idx = this.ocFavTableInfo.IndexOf(item) + 2;


            this.ocFavTableInfo.Insert(new_idx, new_item);
            this.ocFavTableInfo.Remove(item);

            this.dgdFavObjList.SelectedItem = new_item;
        }

        private void BtnDelete_Click(object sender, RoutedEventArgs e)
        {
            var item = dgdFavObjList.SelectedItem as TableInfo;
            if (item == null) return;

            this.ocFavTableInfo.Remove(item);
        }

        private void BtnSave_Click(object sender, RoutedEventArgs e)
        {
            this.SaveFavTableList();
        }

        private void BtnReload_Click(object sender, RoutedEventArgs e)
        {
            this.LoadFavTableList();
        }
    }




    class TestDynaminObject : DynamicObject
    {
    }
}
