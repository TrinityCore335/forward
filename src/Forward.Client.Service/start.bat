@echo off

echo ------------------------------------------
echo -------��������ת������װ�������-------
echo ------------------------------------------

set run_path=%cd%
set service_name="Forward.Client.Service"

SC QUERY %service_name% > NUL
IF ERRORLEVEL 1060 GOTO NOTEXIST
GOTO EXIST

:NOTEXIST
sc create %service_name% binpath="%run_path%\Forward.Client.Service.exe"
sc description %service_name% "��������ת������"
sc config %service_name% start= auto

:EXIST
for /f "skip=3 tokens=4" %%i in ('sc query %service_name%') do set "zt=%%i" &goto :next
:next
if /i "%zt%"=="RUNNING" (
    echo �Ѿ����ָ÷��������С�
) else (
    echo ����%service_name% ����
    sc start %service_name%
)
pause