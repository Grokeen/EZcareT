   M S B A M L   `   `   `  ����I  EDH, Version=1.0.0.0, Culture=neutral, PublicKeyToken=50535a6f1106be75clr-namespace:DH.LibDH.Lib  5      clr-namespace:DH.UCDH.UC  6/       DH.View.SelectQuery   5      [ WHIS.UI.Design.Themes, Version=1.0.0.0, Culture=neutral, PublicKeyToken=50535a6f1106be75\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35U QHIS.UI.Utility, Version=1.0.0.0, Culture=neutral, PublicKeyToken=50535a6f1106be75R NHIS.UI.Core, Version=1.0.0.0, Culture=neutral, PublicKeyToken=50535a6f1106be75R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35a ]HSF.Controls.WPF.Extension, Version=1.0.0.0, Culture=neutral, PublicKeyToken=50535a6f1106be75W SHSF.Controls.WPF, Version=1.0.0.0, Culture=neutral, PublicKeyToken=50535a6f1106be75R NHIS.UI.Base, Version=1.0.0.0, Culture=neutral, PublicKeyToken=50535a6f1106be75V	 RHIS.UI.Controls, Version=1.0.0.0, Culture=neutral, PublicKeyToken=50535a6f1106be75W
 SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R 9http://schemas.microsoft.com/winfx/2006/xaml/presentation
         	 
 5      R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml    
 5      Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006    
 5      @d2http://schemas.microsoft.com/expression/blend/2008    
 5      $srcclr-namespace:DH.Lib    
 5      "ucclr-namespace:DH.UC    
 6/      DH.Lib.UCBase    Loaded$  UserControl_Loaded��5   8   .��5
      �  � RowDefinitions 5   
   �� 5      -   5         ��Name$ 
Tab0Search��5      $��0 �60   �� 5      $��* �6   .+�5   
   ��    SearchFormBox#��[  6   ._�5      �  � ColumnDefinitions 5      �� 5      $��60��6'   $
��Auto �65   �� 5      $	��120��6'   $
��Auto �66   �� 5      .+�5      �� -   5         ��Name$ 	BtnSelect��5      $��Right=�6D   $��Center=�6`   $��0q�6{   $��2��6�   $��25��6�   $��64��6�   .��5      ��  �� Orientation$ 
Horizontal=�6!   .+�5      �� $��21��6    $��21��6+   $(��"/DH;component/Images/Icon/Find.png��67   $��Center=�6c   $	��Top=�6�   $��5,0,0,0q�6�   �� 5      $��실행��6$   $��Center=�6.   $��Center=�6K   $��11(�6f   $��WrapWithOverflow=�6t   $��
5, 0, 5, 0q�6�   5      5      5       5!      � 5#   
   $��1��6   $��4q�6    5%      �� 5&      $	��120 �6    �� 5'      $��* �6    .+�5*         DH.UC.DHTextBox  -   5          Name$ txtSql��5*         DH.UC.DHTextBox   GotFocus$ txtSql_GotFocus��6�      PreviewMouseWheel$ txtSql_PreviewMouseWheel��6  	   KeyDown$	 txtSql_KeyDown��6F  $3��-SELECT쿼리만 실행됩니다. (Ctrl+Enter)��6+   
 � ToolTip$3
 -SELECT쿼리만 실행됩니다. (Ctrl+Enter)��6P    �� TextWrapping$
 Wrap=�6x    �� AcceptsReturn . $��IBM Plex Mono)�6�   " �� VerticalScrollBarVisibility$
 Auto=�6�   $��14(�6�   $��0,0,0,5q�6�   6F  �� 5,      $��5��6   $��Stretch=�6&   $��Bottom=�6D   &   System.Windows.Controls.DataGrid  5.      -   5          Name$ 	dgdResult��5.   P      AutoGenerateColumns . $��Stretch=�62   $��Stretch=�6c    %� IsVirtualizing .  J� 	AllowDrop .     CanUserAddRows .  $��1��5/   c      EnableRowVirtualization .    HorizontalGridLinesBrush �	#FFD5D5D5   VerticalGridLinesBrush �	#FFD5D5D5!   EnableColumnVirtualization . 50   _   51      54      55      