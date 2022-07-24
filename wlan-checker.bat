rem version 0.1.3
@echo off
chcp 65001 > nul
rem Ширина окна "cols=60" символов. По точке в секунду, значит одна сторочка = одна минута
mode con:cols=60 lines=30 > nul
cd %~dp0
cls

rem Обработка аргументов командной строки %1 и %2.
rem Какое соединение мониторить можно передать аргументом, или изменить исходники
rem Пример передачи аргумента через ярлык: "C:\soft\wlan-checker\wlan-checker.bat miwifi 192.168.31.1"
set network=Home
set gateway=192.168.31.1
if not "%1" EQU "" set "network=%1"
if not "%2" EQU "" set "gateway=%2"
title %network%. WLAN-CHECKER
set status=0

if "%network%" EQU "Home" echo. Настройки сети не заданы, используются стандартные!
echo. Мониторинг подключения активирован. 
echo. Сеть: %network%
echo. Пинг: %gateway%

:start1
ping -n 1 %gateway% | find /I "TTL" > nul
if %ERRORLEVEL%==0 (
set status=0
rem Вывод символов в одну строку
< nul set /p str="."
timeout /t 1 > nul
goto start1
)
if %status% EQU 0 echo.& rem Тут перенос строки, что бы следующее сообщение вывелось на новой
set /a status=%status%+1
set timeout=5
rem Дополнительный таймаут. EQU:==  NEQ:!=  LSS:<  LEQ:<=  GTR:>  GEQ:>=
if %status% GTR 2 set timeout=15
echo %time% Переподключение. Попытка: %status%. Подожди %timeout%с.
netsh wlan disconnect > nul
netsh wlan connect name=%network% ssid=%network% > nul
timeout /t %timeout% > nul
goto start1



rem Ниже нерабочий ванлайнер. К сожалению необходимо сначала проверять пинг
REM for /L %%I in (1,0,2) DO (netsh wlan connect name=Afroditius && timeout /t 4 > nul)