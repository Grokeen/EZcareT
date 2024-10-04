import xml.etree.ElementTree as ET
from collections import Counter

# <?xml version="1.0" encoding="utf-8"?>
# <Project ToolsVersion="14.0" DefaultTargets="Build" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
#   <PropertyGroup>
#     <Configuration Condition=" '$(Configuration)' == '' ">Debug</Configuration>
#     <Platform Condition=" '$(Platform)' == '' ">AnyCPU</Platform>
#     <ProductVersion>8.0.30703</ProductVersion>
#     <SchemaVersion>2.0</SchemaVersion>
#     <ProjectGuid>{1CD021FC-8A6F-4B17-AF95-E364FFC6B1F3}</ProjectGuid>
#     <OutputType>Library</OutputType>
#     <AppDesignerFolder>Properties</AppDesignerFolder>
#     <RootNamespace>HIS.PA.AC.PE.AP.UI</RootNamespace>
#     <AssemblyName>HIS.PA.AC.PE.AP.UI</AssemblyName>
#     <TargetFrameworkVersion>v4.6.2</TargetFrameworkVersion>
#     <ProjectTypeGuids>{60dc8134-eba5-43b8-bcc9-bb4bc16c2548}; {FAE04EC0-301F-11D3-BF4B-00C04F79EFBC}</ProjectTypeGuids>
#     <FileAlignment>512</FileAlignment>
#     <SccProjectName>SAK</SccProjectName>
#     <SccLocalPath>SAK</SccLocalPath>
#     <SccAuxPath>SAK</SccAuxPath>
#     <SccProvider>SAK</SccProvider>
#   </PropertyGroup>
#   <PropertyGroup Condition=" '$(Configuration)|$(Platform)' == 'Debug|AnyCPU' ">
#     <DebugSymbols>true</DebugSymbols>
#     <DebugType>full</DebugType>
#     <Optimize>false</Optimize>
#     <OutputPath>..\..\..\..\HIS\Deploy\Client\PA</OutputPath>
#     <DefineConstants>DEBUG;TRACE</DefineConstants>
#     <ErrorReport>prompt</ErrorReport>
#     <WarningLevel>4</WarningLevel>
#   </PropertyGroup>
#   <PropertyGroup Condition=" '$(Configuration)|$(Platform)' == 'Release|AnyCPU' ">
#     <DebugType>pdbonly</DebugType>
#     <Optimize>true</Optimize>
#     <OutputPath>..\..\..\..\HIS\Deploy\Client\PA</OutputPath>
#     <DefineConstants>TRACE</DefineConstants>
#     <ErrorReport>prompt</ErrorReport>
#     <WarningLevel>4</WarningLevel>
#   </PropertyGroup>
#   <PropertyGroup>
#     <AssemblyOriginatorKeyFile>HSF.snk</AssemblyOriginatorKeyFile>
#   </PropertyGroup>


# cd "/c/kimyongrok/EZcareT/보라매SI/240729_환자별선택진료_병동소급정보조회/240729_F12오류비교"

# python 비교파이썬.py



with open('/비교파이썬.txt', 'r', encoding='utf-8') as file:
    xml_data = file.read()


# XML 데이터를 파싱
root = ET.fromstring(xml_data)

# 모든 <Reference Include="..."> 항목을 수집
references = [ref.attrib['Include'] for ref in root.findall('.//Reference')]

# 중복 항목을 찾기 위해 Counter 사용
reference_counts = Counter(references)

# 중복 항목 출력
duplicates = {ref: count for ref, count in reference_counts.items() if count > 1}

duplicates