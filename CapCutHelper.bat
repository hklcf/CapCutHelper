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
echo Limitation: Exported videos are limited to 1080p resolution and 30fps.
echo.
echo Press any key to search for the latest project folder and its Resources\combination subfolder...
pause >nul

set "searchDir=%LocalAppData%\CapCut\User Data\Projects\com.lveditor.draft"

:: Check if the search directory exists
if not exist "%searchDir%" (
    echo Directory "%searchDir%" does not exist.
    pause
    exit /b
)

:: Initialize variables
set "latestFolder="
set "latestTime=0"

:: Find the most recently modified folder in the search directory (non-recursive)
for /f "delims=" %%i in ('dir "%searchDir%" /a:d /o:-d /b') do (
    :: Skip .recycle_bin folder
    if /i not "%%i"==".recycle_bin" (
        set "folder=%searchDir%\%%i"
        :: Get the modification time of the folder
        for %%a in ("!folder!") do set "mtime=%%~ta"
        :: Convert modification time to a comparable format (YYYYMMDDHHMM)
        set "mtime=!mtime:/=!"
        set "mtime=!mtime::=!"
        set "mtime=!mtime: =!"
        
        :: Compare to find the newest folder
        if !mtime! gtr !latestTime! (
            set "latestTime=!mtime!"
            set "latestFolder=!folder!"
        )
    )
)

:: Check if a folder was found
if "!latestFolder!"=="" (
    echo No project folder was found in "%searchDir%".
    pause
) else (
    :: Append \Resources\combination to the latest folder
    set "combinationFolder=!latestFolder!\Resources\combination"
    :: Check if the Resources\combination folder exists
    if exist "!combinationFolder!" (
        echo Most recently modified project folder: "!latestFolder!"
        echo Opening: "!combinationFolder!"
        :: Open the combination folder in Windows Explorer
        explorer "!combinationFolder!"
    ) else (
        echo Resources\combination folder not found in "!latestFolder!".
        pause
    )
)

endlocal
