@ECHO OFF

OPENFILES >NUL 2>NUL || (
  ECHO Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
  ECHO UAC.ShellExecute "%~s0", "", "", "runas", 1  >> "%temp%\getadmin.vbs"
  "%temp%\getadmin.vbs" >NUL 2>&1
  REM  GOTO �������ڽ���Ŀ���ǩ :EOF, �����ǩ������ת�Ƶ���ǰ���ű��ļ��Ľ�β����������˳����ű��ļ�������һ�����׵İ취������������������˳�������ű���.
  GOTO:EOF
)

REM  ���� getadmin.vbs �ļ�.
DEL /F /Q "%temp%\getadmin.vbs" >NUL 2>NUL

REM  �л�Ŀ¼.
CD /D %ProgramFiles%\Microsoft Office\Office16      >NUL 2>NUL  ||  ^
CD /D %ProgramFiles(x86)%\Microsoft Office\Office16 >NUL 2>NUL
IF NOT "%ERRORLEVEL%"=="0" ECHO �л�Ŀ¼ʧ��,�����˳� && PAUSE && EXIT

REM [���� UWP Office 2016/2019](https://www.v2ex.com/t/551857)
SET PRODUCT_KEY=NMMKJ-6RK4F-KMJVX-8D9MJ-6MWKP
ECHO =========================================================
ECHO Office Professional Plus 2019
ECHO cn_office_professional_plus_2019_x86_x64_dvd_5e5be643.iso
ECHO %PRODUCT_KEY%
ECHO =========================================================

REM  �˹�����KMS��������ַ.
SET /P KMS_HOST=������KMS��������ַ: 
:selectWhile
SET /P  selectValue=��ȷ��KMS��������ַ:[%KMS_HOST%], ����[y]ȷ��, ����[n]�˳�: 
IF /I "%selectValue%"=="y" GOTO selectBreak
IF /I "%selectValue%"=="n" EXIT
GOTO selectWhile
:selectBreak

REM  ================
REM  ��"��������ʾ"(`command-line prompt(cmd.exe)`)����[cscript ospp.vbs /?]�鿴����.
REM  ================
cscript ospp.vbs /inslic:"..\root\Licenses16\ProPlus2019VL_KMS_Client_AE-ppd.xrm-ms"
cscript ospp.vbs /inslic:"..\root\Licenses16\ProPlus2019VL_KMS_Client_AE-ul.xrm-ms"
cscript ospp.vbs /inslic:"..\root\Licenses16\ProPlus2019VL_KMS_Client_AE-ul-oob.xrm-ms"
cscript ospp.vbs /inslic:"..\root\Licenses16\ProPlus2019VL_MAK_AE-pl.xrm-ms"
cscript ospp.vbs /inslic:"..\root\Licenses16\ProPlus2019VL_MAK_AE-ppd.xrm-ms"
cscript ospp.vbs /inslic:"..\root\Licenses16\ProPlus2019VL_MAK_AE-ul-oob.xrm-ms"
cscript ospp.vbs /inslic:"..\root\Licenses16\ProPlus2019VL_MAK_AE-ul-phn.xrm-ms"

cscript ospp.vbs /inpkey:%PRODUCT_KEY%
cscript ospp.vbs /sethst:%KMS_HOST%
cscript ospp.vbs /act

PAUSE
