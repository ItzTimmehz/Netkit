::NetKit made by ItzTimmeh (https://github.com/ItzTimmehz)   VERSION : 1.0
  @echo off
  title NetKit by ItzTimmeh
  color a
  mode 75, 40

::Menu
 :menu
  cls
  echo.
  type NetKit.txt
  echo.

::functions
 :maininput
  echo.
  echo 1)scan 2)ping 3)ip info 4)menu 5)exit
  echo.
  set /p input="input>"
  if /I "%input%" EQU "1" goto scan
  if /I "%input%" EQU "2" goto pinginput
  if /I "%input%" EQU "3" goto ipinf
  if /I "%input%" EQU "4" goto menu
  if /I "%input%" EQU "5" exit
  
::scan
 :scan ::1
  arp -a
  goto maininput

::ip
 :ipinf
  cls
  echo.
  set /p ip="IP Address: "
  cls
  set webclient=webclient
  if exist "%temp%\%webclient%.vbs" del "%temp%\%webclient%.vbs" /f /q /s >nul
  if exist "%temp%\response.txt" del "%temp%\response.txt" /f /q /s >nul
 :iplookup
  echo sUrl = "http://ipinfo.io/%ip%/json" > %temp%\%webclient%.vbs
 :localip
  cls
  echo set oHTTP = CreateObject("MSXML2.ServerXMLHTTP.6.0") >> %temp%\%webclient%.vbs
  echo oHTTP.open "GET", sUrl,false >> %temp%\%webclient%.vbs
  echo oHTTP.setRequestHeader "Content-Type", "application/x-www-form-urlencoded" >> %temp%\%webclient%.vbs
  echo oHTTP.setRequestHeader "Content-Length", Len(sRequest) >> %temp%\%webclient%.vbs
  echo oHTTP.send sRequest >> %temp%\%webclient%.vbs
  echo HTTPGET = oHTTP.responseText >> %temp%\%webclient%.vbs
  echo strDirectory = "%temp%\response.txt" >> %temp%\%webclient%.vbs
  echo set objFSO = CreateObject("Scripting.FileSystemObject") >> %temp%\%webclient%.vbs
  echo set objFile = objFSO.CreateTextFile(strDirectory) >> %temp%\%webclient%.vbs
  echo objFile.Write(HTTPGET) >> %temp%\%webclient%.vbs
  echo objFile.Close >> %temp%\%webclient%.vbs
  echo Wscript.Quit >> %temp%\%webclient%.vbs
  start %temp%\%webclient%.vbs
  set /a requests=0
 :checkresponseexists
  set /a requests=%requests% + 1
  if %requests% gtr 7 goto failed
  IF EXIST "%temp%\response.txt" (
  goto response_exist
  ) ELSE (
  ping 127.0.0.1 -n 2 -w 1000 >nul
  goto checkresponseexists
  )
 :failed
  taskkill /f /im wscript.exe >nul
  del "%temp%\%webclient%.vbs" /f /q /s >nul
  echo.
  echo Did not receive a response from the API.
  echo.
  goto menu
 :response_exist
  cls
  echo.
  for /f "delims=     " %%i in ('findstr /i "," %temp%\response.txt') do (
  set data=%%i
  set data=!data:,=!
  set data=!data:""=Not Listed!
  set data=!data:"=!
  set data=!data:ip:=IP:      !
  set data=!data:hostname:=Hostname:  !
  set data=!data:org:=ISP:        !
  set data=!data:city:=City:      !
  set data=!data:region:=State:   !
  set data=!data:country:=Country:    !
  set data=!data:postal:=Postal:  !
  set data=!data:loc:=Location:   !
  set data=!data:timezone:=Timezone:  !
  echo !data!
  )
  echo.
  del "%temp%\%webclient%.vbs" /f /q /s >nul
  del "%temp%\response.txt" /f /q /s >nul
  if '%ip%'=='' goto menu
  pause

::ping
 :pinginput
  echo.
  echo 1)Normal ping 2.) until stopped 3)Back to menu 4)exit
  echo.
  set /p pinginput="ping>"
  if /I "%pinginput%" EQU "1" goto ping1
  if /I "%pinginput%" EQU "2" goto ping2
  if /I "%pinginput%" EQU "3" goto menu
  if /I "%pinginput%" EQU "4" exit
   
 :ping1
  echo. 
  echo DO NOT MESS UP! (i didnt put a way to cancel yet) ::i will fix this on version 1.5
  echo.
  set /p ip=Target ip: 
  set /p count=Count: 
  set /p size=Size(bytes): 
  pause 
  cls
  ping -n %count% -l %size% %ip%
  goto pinginput

 :ping2
  echo. 
  echo DO NOT MESS UP! (i didnt put a way to cancel yet) ::i will fix this on version 1.5
  echo.
  set /p ip=Target ip: 
  pause 
  cls
  ping -t %ip%
  goto pinginput