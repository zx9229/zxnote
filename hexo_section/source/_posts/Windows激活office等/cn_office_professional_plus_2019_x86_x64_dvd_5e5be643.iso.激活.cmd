@ECHO OFF

OPENFILES >NUL 2>NUL || (
  ECHO Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
  ECHO UAC.ShellExecute "%~s0", "", "", "runas", 1  >> "%temp%\getadmin.vbs"
  "%temp%\getadmin.vbs" >NUL 2>&1
  REM  GOTO 命令现在接受目标标签 :EOF, 这个标签将控制转移到当前批脚本文件的结尾。不定义就退出批脚本文件，这是一个容易的办法。【在这里就是立即退出批处理脚本】.
  GOTO:EOF
)

REM  清理 getadmin.vbs 文件.
DEL /F /Q "%temp%\getadmin.vbs" >NUL 2>NUL

REM  切换目录.
CD /D %ProgramFiles%\Microsoft Office\Office16      >NUL 2>NUL  ||  ^
CD /D %ProgramFiles(x86)%\Microsoft Office\Office16 >NUL 2>NUL
IF NOT "%ERRORLEVEL%"=="0" ECHO 切换目录失败,即将退出 && PAUSE && EXIT

REM [激活 UWP Office 2016/2019](https://www.v2ex.com/t/551857)
SET PRODUCT_KEY=NMMKJ-6RK4F-KMJVX-8D9MJ-6MWKP
ECHO =========================================================
ECHO Office Professional Plus 2019
ECHO cn_office_professional_plus_2019_x86_x64_dvd_5e5be643.iso
ECHO %PRODUCT_KEY%
ECHO =========================================================

REM  人工输入KMS服务器地址.
SET /P KMS_HOST=请输入KMS服务器地址: 
:selectWhile
SET /P  selectValue=请确认KMS服务器地址:[%KMS_HOST%], 输入[y]确认, 输入[n]退出: 
IF /I "%selectValue%"=="y" GOTO selectBreak
IF /I "%selectValue%"=="n" EXIT
GOTO selectWhile
:selectBreak

REM  ================
REM  在"命令行提示"(`command-line prompt(cmd.exe)`)输入[cscript ospp.vbs /?]查看帮助.
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
