rem version 0.1.1
@echo off
chcp 1251 > nul
title WLAN-CHECKER
mode con:cols=60 lines=30 > nul
cd %~dp0
cls

rem ��������� ���������� ��������� ������ %1 � %2
set network=Home
set gateway=192.168.31.1
if not "%1" EQU "" set "network=%1"
if not "%2" EQU "" set "gateway=%2"
set status=0

if "%network%" EQU "Home" echo. ��������� ���� �� ������, ������������ �����������!
echo. ���������� ����������� �����������. 
echo. ����: %network%
echo. ����: %gateway%

:start1
ping -n 1 %gateway% | find /I "TTL" > nul
if %ERRORLEVEL%==0 goto end
echo. && echo %time% ��������������� � ���� %network%. ������� 5�.
netsh wlan disconnect > nul
netsh wlan connect name=%network% ssid=%network% > nul
timeout /t 4 > nul
rem �������������� �������, ���� �� ���������� ������������ � ������� � ������� ����
if %status% GTR 1 (
echo �������������� �����... �������: %status%
timeout /t 10 > nul
)

set /a status=%status%+1
goto start1

:end
rem ����� ����� � ���� ������
< nul set /p str="."
timeout /t 1 > nul
set status=0
goto start1



REM for /L %%I in (1,0,2) DO (netsh wlan connect name=Afroditius && timeout /t 4 > nul)