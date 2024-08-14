using DH.Entity;
using DH.Lib;
using PoorMansTSqlFormatterLib.Formatters;
using PoorMansTSqlFormatterLib.Interfaces;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Windows.Threading;

namespace DH.View
{
    /// <summary>
    /// SelectQuery.xaml에 대한 상호 작용 논리
    /// </summary>
    public partial class SelectQuery : UCBase
    {
        public SelectQuery()
        {
            InitializeComponent();
        }

        private void UserControl_Loaded(object sender, RoutedEventArgs e)
        {

        }



        private void txtSql_PreviewMouseWheel(object sender, MouseWheelEventArgs e)
        {
            bool handle = (Keyboard.Modifiers & ModifierKeys.Control) > 0;
            if (!handle)
                return;

            var obj = sender as TextBox;
            double fontsize = 0;

            if (e.Delta > 0)
                fontsize = obj.FontSize + 1;
            else
                fontsize = obj.FontSize - 1;

            if (fontsize < 11) fontsize = 11;

            obj.FontSize = fontsize;
        }


        private void txtSql_GotFocus(object sender, RoutedEventArgs e)
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
        private void BtnSelect_Click(object sender, RoutedEventArgs e)
        {
            this.Dispatcher.Invoke(DispatcherPriority.Send, (ThreadStart)delegate ()
            {
                this.dgdResult.Dispatcher.BeginInvoke(DispatcherPriority.Input, (Action)delegate ()
                {
                    this.ExcuteSelectQuery();
                });
            });



        }

        private void ExcuteSelectQuery()
        {
            string query = this.txtSql.Text.Replace(";", "");

            try
            {
                DataSet dsResult = this.DBSvc.ExecuteQuery(query);
                dgdResult.ItemsSource = dsResult.Tables[0].DefaultView;
            }
            catch (Exception ex)
            {
                query = string.Format(@"SELECT '{0}' SQLERRM FROM DUAL", ex.Message);
                DataSet dsResult = this.DBSvc.ExecuteQuery(query);
                dgdResult.ItemsSource = dsResult.Tables[0].DefaultView;
            }
        }
        public void ExcuteSelectQuery(string query)
        {
            this.txtSql.Text = query;
            this.ExcuteSelectQuery();
        }

        private void txtSql_KeyDown(object sender, KeyEventArgs e)
        {
            if ((Keyboard.Modifiers & ModifierKeys.Control) == ModifierKeys.Control && e.Key == Key.Enter)
            {
                this.BtnSelect_Click(null, null);
            }
        }


    }
}
