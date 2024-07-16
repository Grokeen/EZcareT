<base:UserControlBase x:Class="HIS.PA.AC.PE.PS.UI.HipassMobileApprovalMng"
             xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
             xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
             xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" 
             xmlns:d="http://schemas.microsoft.com/expression/blend/2008" 
             xmlns:i="http://schemas.microsoft.com/expression/2010/interactivity"
             xmlns:base="clr-namespace:HIS.UI.Base;assembly=HIS.UI.Base"
			 xmlns:local="clr-namespace:HIS.PA.AC.PE.PS.UI"
             xmlns:conv="clr-namespace:HIS.PA.CORE.UI.CONVERTER;assembly=HIS.PA.CORE.UI.CONVERTER" xmlns:HIS_PA_CORE_UI="clr-namespace:HIS.PA.CORE.UI;assembly=HIS.PA.CORE.UI"
                      Loaded="OnLoaded"
             mc:Ignorable="d" 
             d:DesignWidth="1230" d:DesignHeight="800"  DesignWidth="1230" DesignHeight="800" Background="{StaticResource MainNormalBackground}" UseLayoutRounding="True">
    <UserControl.DataContext>
        <local:MedicalCareApprobationAskData />
    </UserControl.DataContext>

    <base:UserControlBase.Resources>
        <ResourceDictionary>
            <ResourceDictionary.MergedDictionaries>
                <SharedResourceDictionary SourcePath="/HIS.UI.Design.Themes;component/ACResources.xaml" Source="/HIS.UI.Design.Themes;component/ACResources.xaml"/>
            </ResourceDictionary.MergedDictionaries>
            <conv:DateFormatStringConverter x:Key="DateFormatStringConverter"></conv:DateFormatStringConverter>
        </ResourceDictionary>

    </base:UserControlBase.Resources>
    
    
    <Grid Grid.IsSharedSizeScope="True">
        <Grid.RowDefinitions>
            <RowDefinition Height="*"/>
            <RowDefinition Height="30"/>
        </Grid.RowDefinitions>
        <Grid Margin="10">
            <Grid.RowDefinitions>
                <RowDefinition Height="Auto"/>
                <RowDefinition/>
            </Grid.RowDefinitions>
            <Border BorderThickness="0,0,1,1" Height="40" BorderBrush="{StaticResource SearchAreaDarkBorderBrush}" Background="{StaticResource SearchAreaBackground}">
                <Border BorderBrush="{StaticResource SearchAreaLightBorderBrush}" BorderThickness="1,1,0,0">
                    <StackPanel Margin="10,0" Orientation="Horizontal" VerticalAlignment="Center">
                        <Border Style="{StaticResource TitleThreeDepthBulletStyle}"/>
                        <HTextBlock Foreground="{StaticResource TextHighlightForeground}" VerticalAlignment="Center" Margin="5,0,0,0" Text="신청일자"/>

                        <!--<HFromToCalendar VerticalAlignment="Center" Margin="5,0,0,0"  Name="ftcal"/>-->

                        <HFromToCalendar VerticalAlignment="Center" Margin="5,0,0,0"  Name="ftcal" KeyDown="ftcal_KeyDown"
                  FromDate="{Binding Path=HipassMobileApprovalMng_INObj.IN_FRDATE, Mode=TwoWay,                      UpdateSourceTrigger=PropertyChanged,    ConverterParameter='yyyyMMdd' }" 
                    ToDate="{Binding Path=HipassMobileApprovalMng_INObj.IN_TODATE,  Mode=TwoWay, UpdateSourceTrigger=PropertyChanged, Converter={StaticResource DateFormatStringConverter},    ConverterParameter='yyyyMMdd' }"    />

                        


                        <Border Style="{StaticResource TitleThreeDepthBulletStyle}" Margin="30,0,0,0"/>
                        <HTextBlock Foreground="{StaticResource TextHighlightForeground}" VerticalAlignment="Center" Margin="5,0,0,0" Text="승인상태"/>
                        <Border Style="{StaticResource GroupBorderLineStyle}" VerticalAlignment="Center" Margin="5,0,0,0">
                            <StackPanel Orientation="Horizontal" Margin="5,0">
                                <HCheckBox Content="승인"/>
                                <HCheckBox Content="취소" Margin="10,0,0,0"/>
                                <HCheckBox Content="미승인" Margin="10,0,0,0"/>
                            </StackPanel>
                        </Border>


                        <!-- 조회 버튼 -->
                        <HButton Content="조회" ButtonStyleType="Search" VerticalAlignment="Center" Margin="30,0,0,0" Click="MobileHipassSearch_way2"/>



                    </StackPanel>
                </Border>
            </Border>


            <HDataGridEx Grid.Row="1" Margin="0,10,0,0">
                <StackPanel Orientation="Horizontal" Margin="5,0">
                    <HCheckBox Content="승인"/>
                    <HCheckBox Content="취소" Margin="10,0,0,0"/>
                    <HCheckBox Content="미승인" Margin="10,0,0,0"/>
                </StackPanel>
            </HDataGridEx>
        </Grid>

        <Border Background="{StaticResource BoundaryLineNormalBackground}" BorderBrush="{StaticResource BoundaryLineNormalBorderBrush}" BorderThickness="0,0,0,1" Height="2" Grid.Row="1" Margin="0,-2,0,0" VerticalAlignment="Top"/>
        <Border Background="{StaticResource CommonButtonAreaNormalBackground}" Grid.Row="1">


            <DockPanel Margin="10,0" LastChildFill="False">
                <HButton PermissionManager.ButtonPermission="None" Content="닫기" ButtonStyleType="Close" DockPanel.Dock="Right"/>
                <HButton PermissionManager.ButtonPermission="None" Content="엑셀" Style="{StaticResource CommonButtonExcelStyle}" DockPanel.Dock="Right" Margin="0,0,5,0"/>
                <HButton PermissionManager.ButtonPermission="None" Content="취소" Style="{StaticResource CommonButtonCancelStyle}" DockPanel.Dock="Right" Margin="0,0,5,0"/>
                <HButton PermissionManager.ButtonPermission="None" Content="초기화" Style="{StaticResource CommonButtonResetStyle}" DockPanel.Dock="Right" Margin="0,0,5,0"/>
                <HButton PermissionManager.ButtonPermission="None" Content="알림톡" DockPanel.Dock="Right" Margin="0,0,5,0"/>
                <HButton PermissionManager.ButtonPermission="None" Content="승인" DockPanel.Dock="Right" Margin="0,0,5,0"/>
            </DockPanel>
        </Border>
    </Grid>
</base:UserControlBase>
    
    
