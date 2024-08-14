using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Controls;
using System.Windows;
using System.Windows.Threading;
using System.ComponentModel;
using System.Windows.Data;
using DH.View;
using System.Data;
using System.Collections;
using DH.Entity;
using System.Collections.ObjectModel;
using System.Deployment.Application;
using System.IO;
using System.Windows.Input;
using System.Threading;
using System.Windows.Media;
using System.Diagnostics;
using System.Runtime.InteropServices;


namespace DH.Lib
{
    public class UCBase : UserControl, INotifyPropertyChanged
    {
        public int DB { set; get; }


        public UCBase()
            : base()
        {
            this.DB = -1;
        }

        public DBSvc DBSvc
        {
            get
            {
                var win = Window.GetWindow(this) as WinBase;
                if (win == null) return null;
                return win.DBSvc;
            }
        }


        private bool is_admin = false;
        public bool IS_ADMIN
        {
            get => this.is_admin;
            set => this.is_admin = value;
        }



        protected bool NumCheck(string strNumber)
        {
            try
            {
                int iNumber = Convert.ToInt32(strNumber);
                return true;
            }
            catch
            {
                return false;
            }
        }

        protected MainWindow OwnerWindow
        {
            get
            {
                return Window.GetWindow(this) as MainWindow;
            }
        }

        public event PropertyChangedEventHandler PropertyChanged;
        protected void OnPropertyChanged(string propertyName)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }

        protected void ClearSort(DataGrid drid)
        {
            //drid.Dispatcher.Invoke(DispatcherPriority.Normal, (ThreadStart)delegate ()
            //{
                foreach (DataGridColumn column in drid.Columns)
                {
                    column.SortDirection = null;
                }

                ICollectionView dv = CollectionViewSource.GetDefaultView(drid.ItemsSource);
                if (dv == null) return;
                //clear the existing sort order
                dv.SortDescriptions.Clear();
                dv.Refresh();
            //});
        }

        protected void dgdObjList_LoadingRow(object sender, DataGridRowEventArgs e)
        {
            e.Row.Header = e.Row.GetIndex() + 1;
        }
        protected void dgdObjList_AutoGeneratingColumn(object sender, DataGridAutoGeneratingColumnEventArgs e)
        {
            e.Column.Header = e.Column.Header.ToString().Replace("_", "__");
        }

        protected void TextBoxPreviewKeyDown_RemoveBlank(object sender, KeyEventArgs e)
        {

            if ((Keyboard.Modifiers & ModifierKeys.Control) == ModifierKeys.Control && e.Key == Key.V)
            {
                TextBox textbox = sender as TextBox;
                if (textbox == null) return;

                // 텍스트박스의 선택된 텍스트를 저장한다.
                string selected_text = textbox.SelectedText;

                // 클립보드의 텍스트를 가져온다.
                string text = Clipboard.GetText();


                int caretIndex;
                // 선택된 텍스트가 있고 클립보드의 텍스트가 있을 경우, 기존 텍스트를 삭제한다.
                if (!string.IsNullOrEmpty(selected_text) && !string.IsNullOrEmpty(text))
                {
                    int startIndex = textbox.SelectionStart;
                    int endIndex = startIndex + textbox.SelectionLength;
                    textbox.Text = textbox.Text.Remove(startIndex, endIndex - startIndex);
                    caretIndex = startIndex;
                }
                else
                {
                    caretIndex = textbox.CaretIndex;
                }

                string[] parts = text.Split(new string[] { "\r\n" }, StringSplitOptions.RemoveEmptyEntries);


                //textbox.Text += string.Join("\r\n", parts.Select(p => p.Trim()).Where(w => !string.IsNullOrWhiteSpace(w)));

                string trimed_text = string.Join(",", parts.Select(p => p.Trim()).Where(w => !string.IsNullOrWhiteSpace(w))).Trim();
                
                textbox.Text = textbox.Text.Insert(caretIndex, trimed_text);
                textbox.CaretIndex = caretIndex + trimed_text.Length;

                e.Handled = true;
            }

            //if ((Keyboard.Modifiers & ModifierKeys.Control) == ModifierKeys.Control && e.Key == Key.V)
            //{
            //    TextBox textbox = sender as TextBox;
            //    if (textbox == null) return;

            //    string text = Clipboard.GetText();
            //    text = text.Trim();
            //    //string[] parts = text.Split(new string[] { "\r\n" }, StringSplitOptions.RemoveEmptyEntries);
            //    //textbox.Text += string.Join("\r\n", parts.Select(p => p.Trim()).Where(w => !string.IsNullOrWhiteSpace(w)));


            //    int caretIndex = textbox.CaretIndex;
            //    textbox.Text = textbox.Text.Insert(caretIndex, text);
            //    textbox.CaretIndex = caretIndex + text.Length;


            //    //textbox.CaretIndex = textbox.Text.Length;
            //    e.Handled = true;
            //}
        }
        protected void ProgressOn()
        {
            if (OwnerWindow == null) return;
            OwnerWindow.ProgressOn();
        }
        protected void ProgressOff()
        {
            if (OwnerWindow == null) return;
            OwnerWindow.ProgressOff();
        }


        protected void OpenCodeWIndow(string code)
        {
            using (CodeWindow window = new CodeWindow())
            {
                window.Owner = this.Parent as Window;
                window.Show();
                window.txtCode.Text = code;
            }
        }

        protected DataTable GetColumnNameInfo(ObservableCollection<ParamInfo> list)
        {
            string col_name = "";
            string col = "";
            foreach (var item in list)
            {
                col = item.ARGUMENT_NAME.ToUpper();
                if (col.IndexOf("IN_") == 0)
                    col = col.Substring(3); // IN_ 제거함


                col_name += string.Format(",'{0}'", col);
            }
            if (string.IsNullOrEmpty(col_name))
            {
                return null;
            }
            else
            {
                col_name = col_name.Substring(1);
            }

            return this.GetColumnNameInfo(col_name);
        }

        protected DataTable GetColumnNameInfo(ArrayList list)
        {
            string col_name = "";
            string col = "";
            foreach (string item in list)
            {
                col = item.ToUpper();
                if (col.IndexOf("IN_") == 0)
                    col = col.Substring(3); // IN_ 제거함


                col_name += string.Format(",'{0}'", col);
            }
            if (string.IsNullOrEmpty(col_name))
            {
                return null;
            }
            else
            {
                col_name = col_name.Substring(1);
            }

            return this.GetColumnNameInfo(col_name);
        }
        protected DataTable GetColumnNameInfo(DataTable dt)
        {
            string col_name = "";
            string col = "";

            foreach (DataColumn item in dt.Columns)
            {
                if (item.ColumnName.IndexOf("IN_") == 0)
                    col = item.ColumnName.Substring(3); // IN_ 제거함
                else
                    col = item.ColumnName;

                col_name += string.Format(",'{0}'", col);
            }


            if (string.IsNullOrEmpty(col_name))
            {
                return null;
            }
            else
            {
                col_name = col_name.Substring(1);
            }

            return this.GetColumnNameInfo(col_name);
        }

        protected DataTable GetColumnNameInfo(string col_name)
        {
            var setting_item = this.OwnerWindow.OcBasicSetting.Where(d => d.CODE == "MetaConnectionString").FirstOrDefault();
            if (setting_item == null)
            {
                //this.OwnerWindow.ShowMsgBox("META# ConnectionString이 셋팅되지 않았습니다. Setting 탭에서 설정해주세요.");
                this.OwnerWindow.ShowMsgBox("META# ConnectionString이 셋팅되지 않았습니다. Setting 탭에서 설정해주세요.", 3000);
                return null;
            }

            col_name = col_name.ToUpper();

            string metaConnectionString = setting_item.VALUE;
            string query = string.Format(
                @"SELECT DIC_PHY_NM COL_NAME
                       , DIC_LOG_NM META_COL_NAME
                    FROM UDATAWARE.STD_DIC
                   WHERE DIC_PHY_NM IN ({0}) ", col_name.ToUpper());

            DataTable dtColumnNameInfo = null;
            try
            {
                DataSet ds = DBSvc.ExecuteQuery(metaConnectionString, query);
                if (ds != null)
                {
                    DataTable result_dt = ds.Tables[0];

                    if (result_dt.Rows.Count > 0)
                        dtColumnNameInfo = result_dt;
                }

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString());
            }

            return dtColumnNameInfo;

        }




        protected string GetMetaColumnName(DataTable dt, string col_name)
        {
            if (string.IsNullOrEmpty(col_name)) return "";

            col_name = col_name.Trim().ToUpper();

            //  IN_로 시작하는 컬럼은 제거함.
            if (col_name.IndexOf("IN_") == 0)
                col_name = col_name.Substring(3); // IN_ 제거함
            

            string meta_col_name = col_name; //Default는 컬럼명.

            if (dt == null) return col_name;

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (dt.Rows[i]["COL_NAME"].ToString() == col_name.ToUpper())
                {
                    meta_col_name = dt.Rows[i]["META_COL_NAME"].ToString();
                    break;
                }
            }


            return meta_col_name;
        }

        protected string NVL(object str, string replace_str)
        {
            if (str == null) return replace_str;

            return str.ToString();
        }


        protected string GetQueryText(string query_id, bool is_sc_replace)
        {
            ObservableCollection<FXQUERYSTORE> ocQueryText = new ObservableCollection<FXQUERYSTORE>();
            string query = "";

            var p = DBSvc.CreateEntity<FXQUERYSTORE>();
            p.QueryId = "DH.SELECT.FXQUERYSTORE.S01";

            p.QUERY_ID = query_id;

            DBSvc.Param.Add(p);
            DBSvc.Result.Add(ocQueryText);

            DBSvc.Select();

            if (ocQueryText.Count == 0) return "";


            query = ocQueryText[0].QUERYTEXT;

            // 특수문자 > < 처리
            if (is_sc_replace)
            {
                query = query.Replace("&gt;", ">");
                query = query.Replace("&lt;", "<");
            }

            return query;

        }


        protected string GetDBSourceText(string obj_name)
        {
            var ocDBSourceText = new ObservableCollection<ALL_SOURCE>();

            StringBuilder txt = new StringBuilder();

            var p = DBSvc.CreateEntity<ALL_SOURCE>();
            p.QueryId = "DH.SELECT.ALL_SOURCE.S02";
            p.NAME = obj_name;


            DBSvc.Param.Add(p);
            DBSvc.Result.Add(ocDBSourceText);

            DBSvc.Select();

            if (ocDBSourceText.Count == 0) return "";


            foreach (var item in ocDBSourceText)
            {
                txt.Append(item.TEXT);
            }

            return txt.ToString();

        }


        protected string GetViewSourceText(string owner, string obj_name)
        {
            var ocDBViewText = new ObservableCollection<ALL_VIEWS>();

            

            var p = DBSvc.CreateEntity<ALL_VIEWS>();
            p.QueryId = "DH.SELECT.ALL_VIEWS.S01";
            p.NAME = obj_name;


            DBSvc.Param.Add(p);
            DBSvc.Result.Add(ocDBViewText);

            DBSvc.Select();

            if (ocDBViewText.Count == 0) return "";

            string txt = string.Format("VIEW {1}.{2} ({3}) AS{0}{4}", Environment.NewLine, owner, obj_name, ocDBViewText[0].COL_INFO, ocDBViewText[0].TEXT);

            return txt;

        }



        public string GetTempFilePath(string file_name)
        {
            string file_path = string.Format(@"Temp\{0}", file_name);

            if (ApplicationDeployment.IsNetworkDeployed)
            {
                var deployment = ApplicationDeployment.CurrentDeployment;
                file_path = System.IO.Path.Combine(deployment.DataDirectory, file_path);
            }
            else
            {
                file_path = System.IO.Path.Combine(Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().Location), file_path);
            }

            FileInfo fi = new FileInfo(file_path);
            if (!Directory.Exists(fi.Directory.FullName)) Directory.CreateDirectory(fi.Directory.FullName);

            return file_path;

        }
        
        protected string SaveTempTextFile(string file_name, string txt)
        {
            string file_path = this.GetTempFilePath(file_name);

            try
            {
                File.WriteAllText(file_path, txt, Encoding.UTF8);
            }
            catch(Exception ex)
            {
                MessageBox.Show(ex.Message);
            }

            return file_path;
        }

        protected string GetBasicSettingValue(string key)
        {
            try
            {
                var setting_item = this.OwnerWindow.OcBasicSetting.Where(d => d.CODE == key).FirstOrDefault();
                if (setting_item == null)
                {
                    //this.OwnerWindow.ShowMsgBox(key + "값이 셋팅되지 않았습니다. Setting 탭에서 설정해주세요.");
                    this.OwnerWindow.ShowMsgBox(key + "값이 셋팅되지 않았습니다. Setting 탭에서 설정해주세요.", 3000);
                    return null;
                }

                return setting_item.VALUE;
            }
            catch
            {
                this.OwnerWindow.ShowMsgBox(key + "값이 셋팅되지 않았습니다. Setting 탭에서 설정해주세요.", 3000);
                return null;
            }
        }

        protected string GetExcludeOwner()
        {
            var setting_item = this.OwnerWindow.OcBasicSetting.Where(d => d.CODE == "ExcludeOwner").FirstOrDefault();
            if (setting_item == null)
            {
                return "";
                //this.OwnerWindow.ShowMsgBox(key + "값이 셋팅되지 않았습니다. Setting 탭에서 설정해주세요.");
                //this.OwnerWindow.ShowMsgBox("제외할 Table Owner 값이 셋팅되지 않았습니다. Setting 탭에서 설정해주세요.", 3000);
                //return null;
            }

            return setting_item.VALUE;
        }


        protected void DataGridScrollAndFocus(DataGrid dgd, int col_index)
        {
            if (dgd == null || col_index < 0) return;

            dgd.Focus();
            dgd.Dispatcher.BeginInvoke(DispatcherPriority.Input, (Action)delegate ()
            {
                if (dgd.SelectedItem == null) return;

                dgd.ScrollIntoView(dgd.SelectedItem, null);

                dgd.Dispatcher.BeginInvoke(DispatcherPriority.Input, (Action)delegate ()
                {
                    DataGridCellInfo cellInfo = new DataGridCellInfo(dgd.SelectedItem, dgd.Columns[col_index]);
                    var cell_content = cellInfo.Column.GetCellContent(cellInfo.Item);
                    if (cell_content != null)
                    {
                        DataGridCell cell = (DataGridCell)cell_content.Parent;
                        if (cell != null)
                        {
                            cell.IsSelected = true;
                            cell.Focus();
                            dgd.BeginEdit();
                        }

                    }
                    
                });
            });
        }


        /// <summary>
        /// Finds a Child of a given item in the visual tree. 
        /// </summary>
        /// <param name="parent">A direct parent of the queried item.</param>
        /// <typeparam name="T">The type of the queried item.</typeparam>
        /// <param name="childName">x:Name or Name of child. </param>
        /// <returns>The first parent item that matches the submitted type parameter. 
        /// If not matching item can be found, 
        /// a null parent is being returned.</returns>
        public T FindChild<T>(DependencyObject parent, string childName)
           where T : DependencyObject
        {
            // Confirm parent and childName are valid. 
            if (parent == null) return null;

            T foundChild = null;

            int childrenCount = VisualTreeHelper.GetChildrenCount(parent);
            for (int i = 0; i < childrenCount; i++)
            {
                var child = VisualTreeHelper.GetChild(parent, i);
                // If the child is not of the request child type child
                T childType = child as T;
                if (childType == null)
                {
                    // recursively drill down the tree
                    foundChild = FindChild<T>(child, childName);

                    // If the child is found, break so we do not overwrite the found child. 
                    if (foundChild != null) break;
                }
                else if (!string.IsNullOrEmpty(childName))
                {
                    var frameworkElement = child as FrameworkElement;
                    // If the child's name is set for search
                    if (frameworkElement != null && frameworkElement.Name == childName)
                    {
                        // if the child's name is of the request name
                        foundChild = (T)child;
                        break;
                    }
                }
                else
                {
                    // child element found.
                    foundChild = (T)child;
                    break;
                }
            }

            return foundChild;
        }

        public T FindChild<T>(DependencyObject parent) where T : DependencyObject
        {
            int numChildren = VisualTreeHelper.GetChildrenCount(parent);
            for (int i = 0; i < numChildren; i++)
            {
                var child = VisualTreeHelper.GetChild(parent, i);
                if (child is T typedChild)
                {
                    return typedChild;
                }
                T childItem = FindChild<T>(child);
                if (childItem != null)
                {
                    return childItem;
                }
            }
            return null;
        }



        public T FindParent<T>(DependencyObject child) where T : DependencyObject
        {
            var parentObject = VisualTreeHelper.GetParent(child);

            if (parentObject == null)
                return null;

            if (parentObject is T parent)
                return parent;

            return FindParent<T>(parentObject);
        }
       










               [DllImport("user32.dll")]
        private static extern bool SetForegroundWindow(IntPtr hWnd);

        public void ExecuteProgram(string path, string src_file_path)
        {
            using (Process p = new Process())
            {
                p.StartInfo.FileName = path;
                p.StartInfo.UseShellExecute = true;
                p.StartInfo.Arguments = "\"" + src_file_path + "\"";
                if (p.Start())
                {
                    //p.WaitForInputIdle();
                    //IntPtr mainWindowHandle = p.MainWindowHandle;
                    //SetForegroundWindow(mainWindowHandle);
                }
            }
        }
    }
}
