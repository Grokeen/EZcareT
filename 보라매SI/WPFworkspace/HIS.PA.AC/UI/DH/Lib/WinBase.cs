using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows;
using System.Windows.Media;
using System.Windows.Media.Imaging;

namespace DH.Lib
{
    public class WinBase : Window
    {
        public DBSvc DBSvc;

        public WinBase()
            : base()
        {
            DBSvc = new DBSvc();

            this.Loaded += new RoutedEventHandler(BaseWindow_Loaded);

        }

        void BaseWindow_Loaded(object sender, RoutedEventArgs e)
        {
            //Uri iconUri = new Uri("pack://application:,,,/Images/Ico/doc2.ico", UriKind.RelativeOrAbsolute);
            Uri iconUri = new Uri("pack://application:,,,/gnome-run.ico", UriKind.RelativeOrAbsolute);
            this.Icon = BitmapFrame.Create(iconUri);
        }

        protected bool MaxScreen()
        {
            var w = SystemParameters.WorkArea.Width;
            var h = SystemParameters.WorkArea.Height;

            if (w > 1920)
            {
                w = 1920;
                h = 1080;
            }

            this.Width = w;
            this.Height = h;

            if (SystemParameters.WorkArea.Width > 1920)
            {
                this.Left = 100;
                this.Top = 100;
            }

            //MessageBox.Show(SystemParameters.WorkArea.Height.ToString());
            //MessageBox.Show(SystemParameters.PrimaryScreenHeight.ToString());

            return true;
        }

    }
}
