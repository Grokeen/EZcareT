   M S B A M L   `   `   `  ����I  EDH, Version=1.0.0.0, Culture=neutral, PublicKeyToken=50535a6f1106be75clr-namespace:DH.LibDH.Lib  5   	   clr-namespace:DH.UCDH.UC  5	          DH.View.CodeWindow   5      [ WHIS.UI.Design.Themes, Version=1.0.0.0, Culture=neutral, PublicKeyToken=50535a6f1106be75\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35U QHIS.UI.Utility, Version=1.0.0.0, Culture=neutral, PublicKeyToken=50535a6f1106be75R NHIS.UI.Core, Version=1.0.0.0, Culture=neutral, PublicKeyToken=50535a6f1106be75R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35a ]HSF.Controls.WPF.Extension, Version=1.0.0.0, Culture=neutral, PublicKeyToken=50535a6f1106be75W SHSF.Controls.WPF, Version=1.0.0.0, Culture=neutral, PublicKeyToken=50535a6f1106be75R NHIS.UI.Base, Version=1.0.0.0, Culture=neutral, PublicKeyToken=50535a6f1106be75V	 RHIS.UI.Controls, Version=1.0.0.0, Culture=neutral, PublicKeyToken=50535a6f1106be75W
 SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R 9http://schemas.microsoft.com/winfx/2006/xaml/presentation
         	 
 5   	   R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml    
 5   	   $srcclr-namespace:DH.Lib    
 5   	   "ucclr-namespace:DH.UC    
 5	         DH.Lib.WinBase    Loaded$  Window_Loaded��5   #    � Title$ 
CodeWindow��5   	    � 
ResizeMode$ 	CanResize=�5   	    � WindowStartupLocation$ CenterScreen=�5   	    J� SnapsToDevicePixels . $	��100��5
   	   $	��100��6   
 � Top$ 0��6(    � Left$ 0��60   $	��768��5   	   $
��1400��6   .��5      �  � RowDefinitions 5   
   �� 5      $��* �6   .+�5   
      DH.UC.DHTextBox  -   5          Name$ txtCode��5         DH.UC.DHTextBox	   GotFocus$	 txtCode_GotFocus��6<   
 �� TextWrapping$

 Wrap=�6(   $��Consolas)�6X   $��14(�6n   " �� VerticalScrollBarVisibility$
 Auto=�6|   $��0��6�   $��5q�6�   5      5      