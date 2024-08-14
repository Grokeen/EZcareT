using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using System.Windows.Media;

namespace DH.UC
{
	[TemplatePart(Name = "PART_ClearButton", Type = typeof(Button))]
	public class DHTextBox : TextBox //, IValidation
	{
		//public const string PART_ClearButtonName = "PART_ClearButton";

		private Button PART_ClearButton;
        private Button PART_CopyButton;

		private ImeConversionModeValues previewGotImeConversionModeValues = ImeConversionModeValues.DoNotCare;

		private ImeConversionModeValues GotImeConversionModeValues = ImeConversionModeValues.DoNotCare;

		private bool isChangedIME;

		public static readonly RoutedEvent TextClearedEvent;
        public static readonly RoutedEvent TextCopiedEvent;

		public static readonly DependencyProperty RegexPatternProperty;

		public static readonly DependencyProperty IsGotFocusAutoSelectProperty;

		public static readonly DependencyProperty TextModeProperty;

		public static readonly DependencyProperty RegexExpressionProperty;

		public static readonly DependencyProperty MaxByteLengthProperty;

		public static readonly DependencyProperty AllowNegativeNumberProperty;

		public static readonly DependencyProperty ImeConversionModeProperty;

		public static readonly DependencyProperty AllowOwnerWindowResizeProperty;

		//public static readonly DependencyProperty IsRequiredProperty;

		public static readonly DependencyProperty InvalidTypeProperty;

		public static readonly DependencyProperty InvalidBehaviorProperty;

		public static readonly DependencyProperty WatermarkProperty;

		public static readonly DependencyProperty WatermarkTemplateProperty;

		public static readonly DependencyProperty WatermarkTemplateSelectorProperty;

		public static readonly DependencyProperty HasWatermarkProperty;

		public static readonly DependencyProperty ComputedWatermarkVisibilityProperty;

		public static readonly DependencyProperty WatermarkOpacityProperty;

		public static readonly DependencyProperty ClearButtonVisibilityProperty;
        public static readonly DependencyProperty CopyButtonVisibilityProperty;

		public static readonly DependencyProperty IsRememberImeConversionModeProperty;

		public static readonly DependencyProperty CustomInputValueProperty;

		public static readonly RoutedCommand ClearCommand;
        public static readonly RoutedCommand CopyCommand;

		//[method: CompilerGenerated]
		//[CompilerGenerated]
		//public event EventHandler<ValidationFailedEventArgs> ValidationFailed;

		public event RoutedEventHandler TextCleared
		{
			add
			{
				base.AddHandler(DHTextBox.TextClearedEvent, value);
			}
			remove
			{
				base.RemoveHandler(DHTextBox.TextClearedEvent, value);
			}
		}

		public event RoutedEventHandler TextCopied
		{
			add
			{
				base.AddHandler(DHTextBox.TextCopiedEvent, value);
			}
			remove
			{
				base.RemoveHandler(DHTextBox.TextCopiedEvent, value);
			}
		}


		[Browsable(true), Category("DH"), DefaultValue(false)]
		public bool IsGotFocusAutoSelect
		{
			get
			{
				return (bool)base.GetValue(DHTextBox.IsGotFocusAutoSelectProperty);
			}
			set
			{
				base.SetValue(DHTextBox.IsGotFocusAutoSelectProperty, value);
			}
		}


		[Browsable(true), Category("DH"), DefaultValue(4000)]
		public int MaxByteLength
		{
			get
			{
				return (int)base.GetValue(DHTextBox.MaxByteLengthProperty);
			}
			set
			{
				base.SetValue(DHTextBox.MaxByteLengthProperty, value);
			}
		}

		[Browsable(true), Category("DH"), DefaultValue(false)]
		public bool AllowNegativeNumber
		{
			get
			{
				return (bool)base.GetValue(DHTextBox.AllowNegativeNumberProperty);
			}
			set
			{
				base.SetValue(DHTextBox.AllowNegativeNumberProperty, value);
			}
		}

		[Browsable(true), Category("DH"), DefaultValue(ImeConversionModeValues.DoNotCare)]
		public ImeConversionModeValues ImeConversionMode
		{
			get
			{
				return (ImeConversionModeValues)base.GetValue(DHTextBox.ImeConversionModeProperty);
			}
			set
			{
				base.SetValue(DHTextBox.ImeConversionModeProperty, value);
			}
		}

		[Browsable(true), Category("DH"), DefaultValue(false)]
		public bool AllowOwnerWindowResize
		{
			get
			{
				return (bool)base.GetValue(DHTextBox.AllowOwnerWindowResizeProperty);
			}
			set
			{
				base.SetValue(DHTextBox.AllowOwnerWindowResizeProperty, value);
			}
		}

		//[Browsable(true), Category("DH"), DefaultValue(false)]
		//public bool IsRequired
		//{
		//	get
		//	{
		//		return (bool)base.GetValue(DHTextBox.IsRequiredProperty);
		//	}
		//	set
		//	{
		//		base.SetValue(DHTextBox.IsRequiredProperty, value);
		//	}
		//}

		//[Browsable(true), Category("DH")]
		//public InvalidType InvalidType
		//{
		//	get
		//	{
		//		return (InvalidType)base.GetValue(DHTextBox.InvalidTypeProperty);
		//	}
		//	set
		//	{
		//		base.SetValue(DHTextBox.InvalidTypeProperty, value);
		//	}
		//}

		//[Browsable(true), Category("DH")]
		//public InvalidBehavior InvalidBehavior
		//{
		//	get
		//	{
		//		return (InvalidBehavior)base.GetValue(DHTextBox.InvalidBehaviorProperty);
		//	}
		//	set
		//	{
		//		base.SetValue(DHTextBox.InvalidBehaviorProperty, value);
		//	}
		//}

		[Category("DH"), Localizable(true)]
		public object Watermark
		{
			get
			{
				return base.GetValue(DHTextBox.WatermarkProperty);
			}
			set
			{
				base.SetValue(DHTextBox.WatermarkProperty, value);
			}
		}

		[Category("DH"), Localizable(true)]
		public DataTemplate WatermarkTemplate
		{
			get
			{
				return (DataTemplate)base.GetValue(DHTextBox.WatermarkTemplateProperty);
			}
			set
			{
				base.SetValue(DHTextBox.WatermarkTemplateProperty, value);
			}
		}

		[Category("DH"), Localizable(true)]
		public DataTemplateSelector WatermarkTemplateSelector
		{
			get
			{
				return (DataTemplateSelector)base.GetValue(DHTextBox.WatermarkTemplateSelectorProperty);
			}
			set
			{
				base.SetValue(DHTextBox.WatermarkTemplateSelectorProperty, value);
			}
		}

		[Category("DH"), Localizable(true), ReadOnly(true)]
		public bool HasWatermark
		{
			get
			{
				return (bool)base.GetValue(DHTextBox.HasWatermarkProperty);
			}
			private set
			{
				base.SetValue(DHTextBox.HasWatermarkProperty, value);
			}
		}

		[Category("DH"), Localizable(true), ReadOnly(true)]
		public Visibility ComputedWatermarkVisibility
		{
			get
			{
				return (Visibility)base.GetValue(DHTextBox.ComputedWatermarkVisibilityProperty);
			}
			private set
			{
				base.SetValue(DHTextBox.ComputedWatermarkVisibilityProperty, value);
			}
		}

		[Category("DH"), Localizable(true)]
		public double WatermarkOpacity
		{
			get
			{
				return (double)base.GetValue(DHTextBox.WatermarkOpacityProperty);
			}
			set
			{
				base.SetValue(DHTextBox.WatermarkOpacityProperty, value);
			}
		}

		[Category("DH"), Localizable(true)]
		public Visibility ClearButtonVisibility
		{
			get
			{
				return (Visibility)base.GetValue(DHTextBox.ClearButtonVisibilityProperty);
			}
			set
			{
				base.SetValue(DHTextBox.ClearButtonVisibilityProperty, value);
			}
		}

		[Category("DH"), Localizable(true)]
		public Visibility CopyButtonVisibility
		{
			get
			{
				return (Visibility)base.GetValue(DHTextBox.CopyButtonVisibilityProperty);
			}
			set
			{
				base.SetValue(DHTextBox.CopyButtonVisibilityProperty, value);
			}
		}

		[Category("Common"), Description("IsRememberImeConversionMode을 설정하거나 가져옵니다.")]
		public bool IsRememberImeConversionMode
		{
			get
			{
				return (bool)base.GetValue(DHTextBox.IsRememberImeConversionModeProperty);
			}
			set
			{
				base.SetValue(DHTextBox.IsRememberImeConversionModeProperty, value);
			}
		}

		[Category("Common"), Description("CustomInputValue을 설정하거나 가져옵니다.")]
		public string CustomInputValue
		{
			get
			{
				return (string)base.GetValue(DHTextBox.CustomInputValueProperty);
			}
			set
			{
				base.SetValue(DHTextBox.CustomInputValueProperty, value);
			}
		}

		static DHTextBox()
		{
			DHTextBox.TextClearedEvent = EventManager.RegisterRoutedEvent("TextCleared", RoutingStrategy.Direct, typeof(RoutedEventHandler), typeof(DHTextBox));
            DHTextBox.TextCopiedEvent = EventManager.RegisterRoutedEvent("TextCopied", RoutingStrategy.Direct, typeof(RoutedEventHandler), typeof(DHTextBox));
			//DHTextBox.RegexPatternProperty = DependencyProperty.Register("RegexPattern", typeof(RegexPattern), typeof(DHTextBox), new PropertyMetadata(RegexPattern.None, new PropertyChangedCallback(DHTextBox.OnRegexPatternPropertyChanged)));
			DHTextBox.IsGotFocusAutoSelectProperty = DependencyProperty.Register("IsGotFocusAutoSelect", typeof(bool), typeof(DHTextBox), new PropertyMetadata(false));
			//DHTextBox.TextModeProperty = DependencyProperty.Register("TextMode", typeof(TextMode), typeof(DHTextBox), new PropertyMetadata(TextMode.Default, new PropertyChangedCallback(DHTextBox.OnTextModePropertyChanged)));
			//DHTextBox.RegexExpressionProperty = DependencyProperty.Register("RegexExpression", typeof(Regex), typeof(DHTextBox), new PropertyMetadata(null, new PropertyChangedCallback(DHTextBox.OnRegexExpressionPropertyChanged)));
			DHTextBox.MaxByteLengthProperty = DependencyProperty.Register("MaxByteLength", typeof(int), typeof(DHTextBox), new PropertyMetadata(4000));
			DHTextBox.AllowNegativeNumberProperty = DependencyProperty.Register("AllowNegativeNumber", typeof(bool), typeof(DHTextBox), new PropertyMetadata(false));
			DHTextBox.ImeConversionModeProperty = DependencyProperty.Register("ImeConversionMode", typeof(ImeConversionModeValues), typeof(DHTextBox), new PropertyMetadata(ImeConversionModeValues.DoNotCare, new PropertyChangedCallback(DHTextBox.OnImeConversionModePropertyChanged)));
			DHTextBox.AllowOwnerWindowResizeProperty = DependencyProperty.Register("AllowOwnerWindowResize", typeof(bool), typeof(DHTextBox), new PropertyMetadata(false));
			//DHTextBox.IsRequiredProperty = DependencyProperty.Register("IsRequired", typeof(bool), typeof(DHTextBox), new PropertyMetadata(false));
			//DHTextBox.InvalidTypeProperty = DependencyProperty.Register("InvalidType", typeof(InvalidType), typeof(DHTextBox), new PropertyMetadata(InvalidType.None));
			//DHTextBox.InvalidBehaviorProperty = DependencyProperty.Register("InvalidBehavior", typeof(InvalidBehavior), typeof(DHTextBox), new PropertyMetadata(InvalidBehavior.Default));
			DHTextBox.WatermarkProperty = DependencyProperty.Register("Watermark", typeof(object), typeof(DHTextBox), new PropertyMetadata(new PropertyChangedCallback(DHTextBox.OnWatermarkPropertyChanged)));
			DHTextBox.WatermarkTemplateProperty = DependencyProperty.Register("WatermarkTemplate", typeof(DataTemplate), typeof(DHTextBox), new PropertyMetadata(new PropertyChangedCallback(DHTextBox.OnWatermarkTemplatePropertyChanged)));
			DHTextBox.WatermarkTemplateSelectorProperty = DependencyProperty.Register("WatermarkTemplateSelector", typeof(DataTemplateSelector), typeof(DHTextBox), new PropertyMetadata(new PropertyChangedCallback(DHTextBox.OnWatermarkTemplateSelectorPropertyChanged)));
			DHTextBox.HasWatermarkProperty = DependencyProperty.Register("HasWatermark", typeof(bool), typeof(DHTextBox), new PropertyMetadata(false));
			DHTextBox.ComputedWatermarkVisibilityProperty = DependencyProperty.Register("ComputedWatermarkVisibility", typeof(Visibility), typeof(DHTextBox), new PropertyMetadata(Visibility.Visible));
			DHTextBox.WatermarkOpacityProperty = DependencyProperty.Register("WatermarkOpacity", typeof(double), typeof(DHTextBox), new PropertyMetadata(0.4));
			DHTextBox.ClearButtonVisibilityProperty = DependencyProperty.Register("ClearButtonVisibility", typeof(Visibility), typeof(DHTextBox), new PropertyMetadata(Visibility.Collapsed));
            DHTextBox.CopyButtonVisibilityProperty = DependencyProperty.Register("CopyButtonVisibility", typeof(Visibility), typeof(DHTextBox), new PropertyMetadata(Visibility.Collapsed));
			DHTextBox.IsRememberImeConversionModeProperty = DependencyProperty.Register("IsRememberImeConversionMode", typeof(bool), typeof(DHTextBox), new PropertyMetadata(false));
			DHTextBox.CustomInputValueProperty = DependencyProperty.Register("CustomInputValue", typeof(string), typeof(DHTextBox), new PropertyMetadata("0"));
			DHTextBox.ClearCommand = new RoutedCommand("ClearCommand", typeof(DHTextBox));
            DHTextBox.CopyCommand = new RoutedCommand("CopyCommand", typeof(DHTextBox));
			FrameworkElement.DefaultStyleKeyProperty.OverrideMetadata(typeof(DHTextBox), new FrameworkPropertyMetadata(typeof(DHTextBox)));
		}

		public DHTextBox()
		{
			base.AddHandler(DataObject.PastingEvent, new DataObjectPastingEventHandler(this.OnPasteEvent), true);
			base.AddHandler(UIElement.PreviewMouseLeftButtonDownEvent, new MouseButtonEventHandler(DHTextBox.SelectivelyHandleMouseButton), true);
		}

		//private static void OnTextModePropertyChanged(DependencyObject d, DependencyPropertyChangedEventArgs e)
		//{
		//	switch ((TextMode)e.NewValue)
		//	{
		//	case TextMode.Default:
		//		InputMethod.SetIsInputMethodEnabled(d, true);
		//		InputMethod.SetPreferredImeConversionMode(d, ImeConversionModeValues.DoNotCare);
		//		InputMethod.SetPreferredImeState(d, InputMethodState.On);
		//		return;
		//	case TextMode.Number:
		//	case TextMode.Decimal:
		//	case TextMode.Eng:
		//	case TextMode.AlphaNumeric:
		//		InputMethod.SetIsInputMethodEnabled(d, false);
		//		InputMethod.SetPreferredImeConversionMode(d, ImeConversionModeValues.Alphanumeric);
		//		InputMethod.SetPreferredImeState(d, InputMethodState.On);
		//		InputMethod.Current.ImeConversionMode = ImeConversionModeValues.Alphanumeric;
		//		return;
		//	case TextMode.Hangule:
		//		InputMethod.SetIsInputMethodEnabled(d, true);
		//		InputMethod.SetPreferredImeConversionMode(d, ImeConversionModeValues.Native);
		//		InputMethod.SetPreferredImeState(d, InputMethodState.On);
		//		InputMethod.Current.ImeConversionMode = ImeConversionModeValues.Native;
		//		return;
		//	default:
		//		return;
		//	}
		//}

		private static void OnRegexExpressionPropertyChanged(DependencyObject d, DependencyPropertyChangedEventArgs e)
		{
		}

		//private static void OnRegexPatternPropertyChanged(DependencyObject d, DependencyPropertyChangedEventArgs e)
		//{
		//	if ((RegexPattern)e.NewValue != RegexPattern.None)
		//	{
		//		string regexPattern = Utility.GetRegexPattern((RegexPattern)e.NewValue);
		//		((DHTextBox)d).RegexExpression = new Regex(regexPattern);
		//		return;
		//	}
		//	((DHTextBox)d).RegexExpression = null;
		//}

		private static void OnImeConversionModePropertyChanged(DependencyObject d, DependencyPropertyChangedEventArgs e)
		{
		}

		private static void OnWatermarkPropertyChanged(DependencyObject sender, DependencyPropertyChangedEventArgs e)
		{
			(sender as DHTextBox).OnWatermarkChanged(e);
		}

		private static void OnWatermarkTemplatePropertyChanged(DependencyObject sender, DependencyPropertyChangedEventArgs e)
		{
			(sender as DHTextBox).OnWatermarkTemplateChanged(e);
		}

		private static void OnWatermarkTemplateSelectorPropertyChanged(DependencyObject sender, DependencyPropertyChangedEventArgs e)
		{
			(sender as DHTextBox).OnWatermarkTemplateSelectorChanged(e);
		}

		private static void OnHasWatermarkPropertyChanged(DependencyObject sender, DependencyPropertyChangedEventArgs e)
		{
			(sender as DHTextBox).OnHasWatermarkChanged((bool)e.OldValue, (bool)e.NewValue);
		}

		private static void OnCanExecuteClear(object sender, CanExecuteRoutedEventArgs e)
		{
			(sender as DHTextBox).OnCanExecuteClear(e);
		}

		protected virtual void OnCanExecuteClear(CanExecuteRoutedEventArgs e)
		{
			e.CanExecute = !string.IsNullOrEmpty(base.Text);
			e.Handled = true;
		}

		private static void OnExecutedClear(object sender, ExecutedRoutedEventArgs e)
		{
			(sender as DHTextBox).OnExecutedClear(e);
		}

		protected virtual void OnExecutedClear(ExecutedRoutedEventArgs e)
		{
			base.SetValue(TextBox.TextProperty, string.Empty);
			base.RaiseEvent(new RoutedEventArgs(DHTextBox.TextClearedEvent, this));
		}

		private static void OnCanExecuteCopy(object sender, CanExecuteRoutedEventArgs e)
		{
			(sender as DHTextBox).OnCanExecuteCopy(e);
		}

		protected virtual void OnCanExecuteCopy(CanExecuteRoutedEventArgs e)
		{
			e.CanExecute = !string.IsNullOrEmpty(base.Text);
			e.Handled = true;
		}

		private static void OnExecutedCopy(object sender, ExecutedRoutedEventArgs e)
		{
			(sender as DHTextBox).OnExecutedCopy(e);
		}

		protected virtual void OnExecutedCopy(ExecutedRoutedEventArgs e)
		{
            Clipboard.SetText(this.Text);
			base.RaiseEvent(new RoutedEventArgs(DHTextBox.TextCopiedEvent, this));
		}


		protected virtual void OnWatermarkChanged(DependencyPropertyChangedEventArgs e)
		{
			if (e.NewValue == null)
			{
				this.HasWatermark = false;
				return;
			}
			this.HasWatermark = true;
		}

		protected virtual void OnWatermarkTemplateChanged(DependencyPropertyChangedEventArgs e)
		{
		}

		protected virtual void OnWatermarkTemplateSelectorChanged(DependencyPropertyChangedEventArgs e)
		{
		}

		protected virtual void OnHasWatermarkChanged(bool oldValue, bool newValue)
		{
			if (newValue && string.IsNullOrEmpty(base.Text))
			{
				this.ComputedWatermarkVisibility = Visibility.Visible;
				return;
			}
			this.ComputedWatermarkVisibility = Visibility.Collapsed;
		}

		public override void OnApplyTemplate()
		{
			base.OnApplyTemplate();
			if (this.PART_ClearButton != null)
			{
				this.PART_ClearButton.Click -= new RoutedEventHandler(this.PART_ClearButton_Click);
			}
			this.PART_ClearButton = (base.GetTemplateChild("PART_ClearButton") as Button);
			if (this.PART_ClearButton != null)
			{
				this.PART_ClearButton.Click += new RoutedEventHandler(this.PART_ClearButton_Click);
			}


			if (this.PART_CopyButton != null)
			{
				this.PART_CopyButton.Click -= new RoutedEventHandler(this.PART_ClearButton_Click);
			}
			this.PART_CopyButton = (base.GetTemplateChild("PART_CopyButton") as Button);
			if (this.PART_CopyButton != null)
			{
				this.PART_CopyButton.Click += new RoutedEventHandler(this.PART_CopyButton_Click);
			}
		}

		//protected override void OnPreviewLostKeyboardFocus(KeyboardFocusChangedEventArgs e)
		//{
		//	base.OnPreviewLostKeyboardFocus(e);
		//	if (this.RegexExpression != null && !this.RegexExpression.IsMatch(base.Text))
		//	{
		//		MessageHelper.ShowWarning("정규식 패턴과 일치 하지 않습니다.", "", MessageBoxButton.OK);
		//		e.Handled = true;
		//	}
		//}

		//protected override void OnPreviewKeyDown(KeyEventArgs e)
		//{
		//	if (!(e.Key == Key.Left | e.Key == Key.Right | e.Key == Key.Back | e.Key == Key.Delete | e.Key == Key.Up | e.Key == Key.Down | e.Key == Key.Prior | e.Key == Key.Next | (e.Key == Key.X && (Keyboard.IsKeyDown(Key.LeftCtrl) || Keyboard.IsKeyDown(Key.RightCtrl)))) && !this.MaxByteLength.Equals(0) && Encoding.Default.GetByteCount(base.Text) >= this.MaxByteLength)
		//	{
		//		ValidationFailedEventArgs validationFailedEventArgs = new ValidationFailedEventArgs
		//		{
		//			Exception = new Exception("Maximum request length exceeded"),
		//			InvalidBehavior = this.InvalidBehavior,
		//			InvalidType = InvalidType.None
		//		};
		//		if (this.ValidationFailed != null)
		//		{
		//			this.ValidationFailed(this, validationFailedEventArgs);
		//		}
		//		if (!validationFailedEventArgs.Cancel && validationFailedEventArgs.InvalidBehavior == InvalidBehavior.FocusAutoSelect)
		//		{
		//			e.Handled = true;
		//		}
		//	}
		//	base.OnPreviewKeyDown(e);
		//}

		protected override void OnRenderSizeChanged(SizeChangedInfo sizeInfo)
		{
			base.OnRenderSizeChanged(sizeInfo);
			if (this.AllowOwnerWindowResize && sizeInfo.HeightChanged)
			{
				double num = sizeInfo.NewSize.Height - sizeInfo.PreviousSize.Height;
				Window window = Window.GetWindow(this);
				if (window != null)
				{
					window.Height += num;
				}
			}
		}

		//protected override void OnPreviewTextInput(TextCompositionEventArgs e)
		//{
		//	switch (this.TextMode)
		//	{
		//	case TextMode.Number:
		//	{
		//		string text = e.Text;
		//		for (int i = 0; i < text.Length; i++)
		//		{
		//			char c = text[i];
		//			if (!char.IsDigit(c) && (!this.AllowNegativeNumber || !c.Equals('-') || !string.IsNullOrEmpty(base.Text)))
		//			{
		//				e.Handled = true;
		//				break;
		//			}
		//		}
		//		break;
		//	}
		//	case TextMode.Decimal:
		//	{
		//		string text = e.Text;
		//		for (int i = 0; i < text.Length; i++)
		//		{
		//			char c2 = text[i];
		//			if (!char.IsDigit(c2) && (!c2.Equals('.') || base.Text.BooleanStringOccurrences(".")) && (!this.AllowNegativeNumber || !c2.Equals('-') || !string.IsNullOrEmpty(base.Text)))
		//			{
		//				e.Handled = true;
		//				break;
		//			}
		//		}
		//		break;
		//	}
		//	case TextMode.Eng:
		//	{
		//		string text = e.Text;
		//		for (int i = 0; i < text.Length; i++)
		//		{
		//			if (!char.IsLetter(text[i]))
		//			{
		//				e.Handled = true;
		//				break;
		//			}
		//		}
		//		break;
		//	}
		//	case TextMode.Hangule:
		//	{
		//		string text = e.Text;
		//		for (int i = 0; i < text.Length; i++)
		//		{
		//			char c3 = text[i];
		//			if (('가' > c3 || c3 > '힣') && ('ㄱ' > c3 || c3 > 'ㆎ'))
		//			{
		//				e.Handled = true;
		//				break;
		//			}
		//		}
		//		break;
		//	}
		//	case TextMode.AlphaNumeric:
		//	{
		//		string text = e.Text;
		//		for (int i = 0; i < text.Length; i++)
		//		{
		//			if (!char.IsLetterOrDigit(text[i]))
		//			{
		//				e.Handled = true;
		//				break;
		//			}
		//		}
		//		break;
		//	}
		//	}
		//	base.OnPreviewTextInput(e);
		//}

		protected override void OnTextChanged(TextChangedEventArgs e)
		{
			base.OnTextChanged(e);
			if (!DesignerProperties.GetIsInDesignMode(this) && !string.IsNullOrEmpty(base.Text))
			{
				this.ComputedWatermarkVisibility = Visibility.Collapsed;
			}
			else if (string.IsNullOrEmpty(base.Text) && !base.IsKeyboardFocusWithin)
			{
				this.ComputedWatermarkVisibility = Visibility.Visible;
			}
			//if (this.TextMode == TextMode.CustomValueSet)
			//{
			//	if (this.ClearButtonVisibility == Visibility.Visible)
			//	{
			//		TextChange textChange = e.Changes.First<TextChange>();
			//		if (textChange.RemovedLength == 8 && textChange.AddedLength == 0 && textChange.Offset == 0)
			//		{
			//			base.Text = string.Empty;
			//			return;
			//		}
			//	}
			//	if (this.CustomInputValue.Length > 1)
			//	{
			//		MessageHelper.ShowWarning("CustomInputValue 값은 1 byte의 문자열로 세팅되어야 합니다", "", MessageBoxButton.OK);
			//		return;
			//	}
			//	string text = base.Text;
			//	int num = base.SelectionStart;
			//	if (text.Length < this.MaxByteLength)
			//	{
			//		if (num == 1 || num == this.MaxByteLength - 1)
			//		{
			//			num = this.MaxByteLength;
			//		}
			//		else
			//		{
			//			num++;
			//		}
			//		for (int i = 0; i < this.MaxByteLength - text.Length; i++)
			//		{
			//			text = string.Format("{0}{1}", this.CustomInputValue, text);
			//		}
			//		base.Text = text;
			//		base.SelectionStart = num;
			//		return;
			//	}
			//	if (text.Length != this.MaxByteLength)
			//	{
			//		base.Text = text.Remove(0, 1);
			//		base.Select(num - 1, 0);
			//	}
			//}
		}

		protected override void OnIsKeyboardFocusWithinChanged(DependencyPropertyChangedEventArgs e)
		{
			base.OnIsKeyboardFocusWithinChanged(e);
			if (!base.IsKeyboardFocusWithin && string.IsNullOrEmpty(base.Text))
			{
				this.ComputedWatermarkVisibility = Visibility.Visible;
				return;
			}
			this.ComputedWatermarkVisibility = Visibility.Collapsed;
		}

		protected override void OnGotKeyboardFocus(KeyboardFocusChangedEventArgs e)
		{
			base.OnGotKeyboardFocus(e);
			if (this.IsGotFocusAutoSelect)
			{
				base.SelectAll();
			}
			this.GotImeConversionModeValues = InputMethod.Current.ImeConversionMode;
			if (this.IsRememberImeConversionMode)
			{
				if (this.previewGotImeConversionModeValues != ImeConversionModeValues.DoNotCare)
				{
					InputMethod.SetPreferredImeConversionMode(this, this.previewGotImeConversionModeValues);
					return;
				}
			}
			else if (this.ImeConversionMode != ImeConversionModeValues.DoNotCare)
			{
				InputMethod.Current.ImeConversionMode = this.ImeConversionMode;
			}
		}

		protected override void OnLostKeyboardFocus(KeyboardFocusChangedEventArgs e)
		{
			this.previewGotImeConversionModeValues = InputMethod.Current.ImeConversionMode;
			base.OnLostKeyboardFocus(e);
			if (this.IsRememberImeConversionMode && !this.isChangedIME)
			{
				InputMethod.Current.ImeConversionMode = this.GotImeConversionModeValues;
			}
		}

		protected override void OnKeyUp(KeyEventArgs e)
		{
			base.OnKeyUp(e);
			if (e.Key == Key.KanaMode)
			{
				this.isChangedIME = true;
			}
		}

		private void OnPasteEvent(object sender, DataObjectPastingEventArgs e)
		{
			object data = Clipboard.GetData(DataFormats.Text);
			if (data != null)
			{
				int byteCount = Encoding.Default.GetByteCount(data.ToString());
				int byteCount2 = Encoding.Default.GetByteCount(base.Text);
				int byteCount3 = Encoding.Default.GetByteCount(base.SelectedText);
				if (byteCount > this.MaxByteLength || byteCount2 - byteCount3 + byteCount > this.MaxByteLength)
				{
					e.CancelCommand();
					//ValidationFailedEventArgs validationFailedEventArgs = new ValidationFailedEventArgs
					//{
					//	Exception = new Exception("Maximum request length exceeded"),
					//	InvalidBehavior = InvalidBehavior.Default,
					//	InvalidType = InvalidType.Waring
					//};
					//if (this.ValidationFailed != null)
					//{
					//	this.ValidationFailed(this, validationFailedEventArgs);
					//}
					//if (!validationFailedEventArgs.Cancel)
					//{
					//	this.InvalidType = validationFailedEventArgs.InvalidType;
					//	this.InvalidBehavior = validationFailedEventArgs.InvalidBehavior;
					//	if (this.InvalidBehavior == InvalidBehavior.FocusAutoSelect)
					//	{
					//		e.Handled = true;
					//	}
					//}
				}
			}
		}

		private static void SelectivelyHandleMouseButton(object sender, MouseButtonEventArgs e)
		{
			DHTextBox DHTextBox = sender as DHTextBox;
			if (DHTextBox.IsGotFocusAutoSelect && DHTextBox != null && !DHTextBox.IsKeyboardFocusWithin && e.OriginalSource.GetType().Name == "TextBoxView")
			{
				e.Handled = true;
				DHTextBox.Focus();
			}
		}

		private void PART_ClearButton_Click(object sender, RoutedEventArgs e)
		{
			base.SetValue(TextBox.TextProperty, string.Empty);
			base.RaiseEvent(new RoutedEventArgs(DHTextBox.TextClearedEvent, this));
		}

		private void PART_CopyButton_Click(object sender, RoutedEventArgs e)
		{
			Clipboard.SetText(this.Text);
			base.RaiseEvent(new RoutedEventArgs(DHTextBox.TextCopiedEvent, this));
		}


	}
}
