using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Runtime.Serialization;
using System.Collections;
using System.Collections.ObjectModel;
using System.ComponentModel;

namespace DH.Entity
{
    public class BaseEntity : INotifyPropertyChanged, ICloneable
    {
        public string Mode { set; get; } //S, I, D, U

        public string DBGbn { set; get; } //DEV, APP

        public string ServiceName { set; get; }

        public string QueryId { set; get; }

        public event PropertyChangedEventHandler PropertyChanged;

        protected void OnPropertyChanged(string propertyName)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }


		public object Clone()
        {
            return this.MemberwiseClone();
        }
    }

}