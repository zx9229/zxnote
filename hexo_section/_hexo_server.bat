@SET SCRIPTS_DIR=%~dp0
@SET SCRIPT_NAME=%~nx0
@SET SCRIPT_NAME=%~n0%~x0

@WHOAMI
@ECHO SCHTASKS /Create /TN HEXO_SERVER_BAT /RU SYSTEM   /SC ONSTART /TR "%SCRIPTS_DIR%%SCRIPT_NAME%"
@ECHO SCHTASKS /Create /TN HEXO_SERVER_BAT /RU zhangsan /SC ONSTART /TR "%SCRIPTS_DIR%%SCRIPT_NAME%"

@SET MANUAL_PORT=4000
@IF 1==1 @GOTO RUN_HEXO
@SET /P INPUT_PORT=please input listen port ^(default %MANUAL_PORT%^): 
@IF /I NOT "%INPUT_PORT%"=="" (
    SET MANUAL_PORT=%INPUT_PORT%
)
:RUN_HEXO
%USERPROFILE%\AppData\Roaming\npm\hexo.cmd  server  --port=%MANUAL_PORT%  --cwd=%SCRIPTS_DIR%

@REM  Windows下设置开机自启动程序(不依赖账户登录)
@REM  思路：创建一个任务计划，它以系统账户(SYSTEM)运行，它在开机时(ONSTART)运行。无需账户登录。
@REM  命令： `SCHTASKS /Create /TN 任务名          /RU SYSTEM /SC ONSTART /TR 程序的路径和文件名`。
@REM  示例： `SCHTASKS /Create /TN HEXO_SERVER_BAT /RU SYSTEM /SC ONSTART /TR "%SCRIPTS_DIR%%SCRIPT_NAME%"`。
@REM  解释：创建一个任务计划，名为`HEXO_SERVER_BAT`，运行命令是`%SCRIPTS_DIR%%SCRIPT_NAME%`。
@REM  注意：如果需要更细致的设置，请在`任务计划程序`里面进行设置。

@REM  最新说明：
@REM    请使用某一个用户账户(比如【ZHANG-LAPTOP\zhangsan】)；
@REM    不管用户是否登录都要运行；
@REM    使用最高权限运行；
@REM    这样的话，我们可以随时在`任务计划程序`里面(结束/运行)它。
