@REM �ݹ�ɾ��ָ��Ŀ¼�µ����п��ļ���.
@REM windows������ɾ����Ŀ¼�ļ򵥷���
@REM https://blog.csdn.net/sl543001/article/details/34810995


@REM ���������ӳٵ�����.
@SETLOCAL enabledelayedexpansion

@CD /D %~dp0

@SET WORK_DIR=.\hexo_section\source

@IF "%WORK_DIR%" == "" (
    IF NOT "%1" == "" (
        CD /D "%1"
        IF NOT "%ERRORLEVEL%" == "0" ECHO �л�Ŀ¼ʧ�� && GOTO EXIT
    )
) ELSE (
    CD /D "%WORK_DIR%"
    IF NOT "!ERRORLEVEL!" == "0"  ECHO �л�Ŀ¼ʧ�� && GOTO EXIT
)

@ECHO ��ǰĿ¼: %cd%

@REM ����(RMDIR/RM)��ɾ��Ŀ¼ʱ, ������ǵݹ�ɾ��, ���Ŀ¼��Ϊ��, ��ô��ɾ��ʧ��.
@FOR /F "delims=" %%a IN ('DIR . /B /AD /S ^| SORT /R') DO RMDIR /Q "%%a" 2>NUL

:EXIT
@ECHO;
@PAUSE
