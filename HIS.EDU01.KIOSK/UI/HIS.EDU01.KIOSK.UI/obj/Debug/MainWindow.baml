   M S B A M L   `   `   `  ����M  IHIS.EDU01.KIOSK.UI, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null7 clr-namespace:HIS.EDU01.KIOSK.UIHIS.EDU01.KIOSK.UI  5   	   #    HIS.EDU01.KIOSK.UI.MainWindow   5      R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NHIS.UI.Base, Version=1.0.0.0, Culture=neutral, PublicKeyToken=50535a6f1106be75W SHSF.Controls.WPF, Version=1.0.0.0, Culture=neutral, PublicKeyToken=50535a6f1106be75a ]HSF.Controls.WPF.Extension, Version=1.0.0.0, Culture=neutral, PublicKeyToken=50535a6f1106be75U QHIS.UI.Utility, Version=1.0.0.0, Culture=neutral, PublicKeyToken=50535a6f1106be75W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35V RHIS.UI.Controls, Version=1.0.0.0, Culture=neutral, PublicKeyToken=50535a6f1106be75[	 WHIS.UI.Design.Themes, Version=1.0.0.0, Culture=neutral, PublicKeyToken=50535a6f1106be75P 9http://schemas.microsoft.com/winfx/2006/xaml/presentation	         	 5   	   R
 NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml  
   5   	   @d2http://schemas.microsoft.com/expression/blend/2008  
   5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006  
   5   	   2local clr-namespace:HIS.EDU01.KIOSK.UI  
   5   	      MainBackground#��[  5   	     � Title$  
MainWindow��5	   	   $	��750��6   $	��800��6)    � DataContext 5
      ,   &HIS.EDU01.KIOSK.UI.MainWindowViewModel  5   
   .��5      �  � RowDefinitions 5   
   �� 5      $��50 �6   �� 5      $	��350 �6   �� 5      $	��150 �6   �� 5      $	��150 �6   .+�5   
   !  HSF.Controls.WPF.HTextBlock  $��
커피 샵��6   $��30(�6!   $��0��6/   $
��Bold"�6<   $��Center=�6N   �� 5   
   $��1��6   ��6$   �� *
MenuList+��5      �� 5      .R�5      � 5      ��5"      �� 5#      .R�5$      !   HIS.EDU01.KIOSK.UI.MenuView  5%      5(      �� 5+   
   $��2��6   ��6$   �� *SelectedMenuList+��5.      �� 5/      .R�50      "  HSF.Controls.WPF.HStackPanel  52      ��55      �� 56      .R�57      )   #HIS.EDU01.KIOSK.UI.SelectedMenuView  59      ��5<      �� 5=      .R�5>      $  HSF.Controls.WPF.HScrollViewer  $��Visible=�6$   .��5?      �� 5@      5A      5E        5H   
   $��3��6   $��5q�6#   .+�5I        
�������$��30(�6C   ��6   �� *TOTAL+6C   !  HSF.Controls.WPF.HWrapPanel  5J      $��10q�6   .+�5K      	� $��현금��6   
�������6+   	� 5L      $��카드��6   
�������6+   5M        HSF.Controls.WPF.HButton  5N      $��결제��6   5O      5Q      5T      