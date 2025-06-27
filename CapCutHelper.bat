@echo off
setlocal EnableDelayedExpansion

:: Display usage tutorial
echo CapCutHelper: Tutorial for Exporting Clips with Compound Clips in CapCut (Free Features)
echo 1. Open CapCut.
echo 2. Select all edited clips (Hotkey: Ctrl+A).
echo 3. Right-click on any clips and select "Create Compound Clip (Subproject)" (Hotkey: Alt+G).
echo 4. Right-click on the compound clip and select "Pre-process Compound Clip (Subproject)".
echo 5. Wait for processing to complete.
echo.
echo Press any key to search for the latest "combination" folder...
pause >nul

set "searchDir=%LocalAppData%\CapCut\User Data\Projects\com.lveditor.draft"
set "searchTerm=combination"

if not exist "%searchDir%" (
    echo Directory "%searchDir%" does not exist.
    exit /b
)

set "latestFolder="
set "latestTime=0"

:: Search recursively for folders named exactly "combination"
for /r "%searchDir%" /d %%i in (*combination*) do (
    set "folder=%%i"
    :: Check if the folder name is exactly "combination"
    if /i "%%~nxi"=="combination" (
        for %%a in ("%%i") do set "mtime=%%~ta"
        set "mtime=!mtime:/=!"
        set "mtime=!mtime::=!"
        set "mtime=!mtime: =!"
        
        if !mtime! gtr !latestTime! (
            set "latestTime=!mtime!"
            set "latestFolder=!folder!"
        )
    )
)

if "!latestFolder!"=="" (
    echo No folder named "combination" was found.
    pause
) else (
    echo Most recently modified "combination" folder: "!latestFolder!"
    :: Open the folder in Windows Explorer
    explorer "!latestFolder!"
)

endlocal
