@echo off
REM Intended to run from Task Scheduler, so move to the script directory.
cd /d %~dp0
REM Run webfilegetter.py using the Python interpreter in env\Scripts.
REM Target URL to download.
set URL=https://www.data.jma.go.jp/stats/data/mdrr/pre_rct/alltable/pre1h00_rct.csv
REM If file download succeeds, move the downloaded file to the specified folder.
REM If not specified, the downloaded file is saved in the same folder as the script.
set DEST_DIR=%~dp0
set SCRIPT_DIR=%~dp0
set PROJECT_ROOT=%SCRIPT_DIR%..
set PYTHON_EXE=%PROJECT_ROOT%\env\Scripts\python.exe
set SCRIPT_FILE=%SCRIPT_DIR%webfilegetter.py
REM Check if the env folder exists
IF NOT EXIST "%PYTHON_EXE%" (
    echo "env folder does not exist. Please create a virtual environment first."
    exit /b 1
)
REM Write execution output to a log file.
set LOGFILE=%SCRIPT_DIR%webfilegetter.log
REM Run the script with URL argument.
"%PYTHON_EXE%" "%SCRIPT_FILE%" "%URL%" > "%LOGFILE%" 2>&1
REM Move the downloaded file to the destination directory if specified.
IF NOT "%DEST_DIR%"=="" (
    IF NOT EXIST "%DEST_DIR%" (
        mkdir "%DEST_DIR%"
    )
    move "%SCRIPT_DIR%%URL:~-1%" "%DEST_DIR%"
)
echo "Execution completed. Check %LOGFILE% for details."
pause