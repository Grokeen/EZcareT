using DH.Lib;
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
using System.Windows.Shapes;
using System.Windows.Threading;

namespace DH.View
{
    /// <summary>
    /// CodeWindow.xaml에 대한 상호 작용 논리
    /// </summary>
    public partial class CodeWindow : WinBase, IDisposable
    {
        public CodeWindow()
        {
            InitializeComponent();
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {

        }

        private void txtCode_GotFocus(object sender, RoutedEventArgs e)
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

        public void Dispose()
        {

        }
    }
}
