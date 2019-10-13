@REM 递归删除指定目录下的所有空文件夹.
@REM windows下批量删除空目录的简单方法
@REM https://blog.csdn.net/sl543001/article/details/34810995


@REM 开启变量延迟的设置.
@SETLOCAL enabledelayedexpansion

@CD /D %~dp0

@SET WORK_DIR=.\hexo_section\source

@IF "%WORK_DIR%" == "" (
    IF NOT "%1" == "" (
        CD /D "%1"
        IF NOT "%ERRORLEVEL%" == "0" ECHO 切换目录失败 && GOTO EXIT
    )
) ELSE (
    CD /D "%WORK_DIR%"
    IF NOT "!ERRORLEVEL!" == "0"  ECHO 切换目录失败 && GOTO EXIT
)

@ECHO 当前目录: %cd%

@REM 命令(RMDIR/RM)在删除目录时, 如果不是递归删除, 如果目录不为空, 那么将删除失败.
@FOR /F "delims=" %%a IN ('DIR . /B /AD /S ^| SORT /R') DO RMDIR /Q "%%a" 2>NUL

:EXIT
@ECHO;
@PAUSE
