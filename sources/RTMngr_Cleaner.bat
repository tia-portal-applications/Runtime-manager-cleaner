@echo off
setlocal enabledelayedexpansion
echo.
echo  * * * * * * * * * ******************************** * * * * * * * * * * 
echo   * * * * * * * * **  ----------------------------  ** * * * * * * * *
echo    * * * * * * * * *  -        RT Manager        -  * * * * * * * * * 
echo     * * * * * * * **  -         Cleaner          -  ** * * * * * * * 
echo      * * * * * * * *  -                          -  * * * * * * * * 
echo       * * * * * * **  -    Author: D. Dupont     -  ** * * * * * * 
echo        * * * * * * *  -    Version: 0.1          -  * * * * * * *
echo         * * * * * **  -                          -  ** * * * * * 
echo          * * * * * *  ----------------------------  * * * * * * 
echo           * * * * *********************************** * * * *
echo.
echo.
echo This is an irreversible process, it will delete all projects and simulations from the Runtime Manager.
echo.
echo In order to use this version, you should make sure that WinCC Unified in installed
echo in the default location, C:\Program Files\Siemens\Automation\WinCCUnified\bin
echo.
choice /c YN /m "Do you want to continue"
echo.
echo.
if errorlevel 2 (
    cls
    echo .
    echo Thanks for choosing Dupont cleaning!
    timeout 5
    exit /b 1
) else (
    cls
    echo You chose Y. Continuing...
    echo.
    echo.
    echo #### Alright, sweeping that out! ####
    echo.
    echo.
:: Raw extraction is just using SIMATIC Runtime Manager output function to generate a txt file with current projects and ID's
    echo Starting project list ID's raw extraction...
    cd "C:\Program Files\Siemens\Automation\WinCCUnified\bin\"
    SIMATICRuntimeManager.exe -s -c projectlist -o

:: Cleanup is creating a new txt file with only the ID's in it, row by row. 
    echo Starting project ID cleanup...
    powershell -ExecutionPolicy Bypass -Command "Get-Content 'C:\Program Files\Siemens\Automation\WinCCUnified\bin\output.txt' | ForEach-Object { if ($_ -match 'Project ID:\s+(.+)') { $matches[1] } } | Set-Content -Path '%TEMP%\project_ids.txt'"
    echo Project IDs extracted and saved to temp directory.

:: Regular project deletion is using SIMATIC Runtime Manager 'remove' command with the cleaned file
    echo Starting regular project deletion...
    for /f "delims=" %%a in (%TEMP%\project_ids.txt) do (
      set "project_id=%%a"
      echo Removing !project_id!
      "C:\Program Files\Siemens\Automation\WinCCUnified\bin\SIMATICRuntimeManager.exe" -s -quiet -c remove !project_id!
    )

:: Simulation project deletion is using SIMATIC Runtime Manager 'remove' command along with the -sim switch
    echo Starting simulation project deletion...
    for /f "delims=" %%a in (%TEMP%\project_ids.txt) do (
      set "project_id_sim=%%a"
      echo Removing !project_id_sim!
      "C:\Program Files\Siemens\Automation\WinCCUnified\bin\SIMATICRuntimeManager.exe" -s -sim -quiet -c remove !project_id_sim!
    )
    echo.
    echo.
    echo All requested projects have been processed.
	
:: Deleting created files
    echo Deleting temporary files...
    del "C:\Program Files\Siemens\Automation\WinCCUnified\bin\output.txt"
    del "%TEMP%\project_ids.txt"
    echo.
    echo.
    timeout 3
)
echo.
echo.
echo #### See you later and thanks for using the broom from Dupont cleaning! ####
echo.
endlocal
timeout 10


