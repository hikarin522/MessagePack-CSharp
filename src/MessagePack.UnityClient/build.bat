@echo off
setlocal

IF "%Build_ArtifactStagingDirectory%"=="" (
    SET LogDirectory=%~dp0..\..\bin\build_logs
) ELSE (
    SET LogDirectory=%Build_ArtifactStagingDirectory%\build_logs
)
IF NOT EXIST "%LogDirectory%" MD "%LogDirectory%"

ECHO Log files will be created under "%LogDirectory%"

echo on
start "Unity PACKAGE" /wait "C:\Program Files\Unity\Hub\Editor\2019.1.10f1\Editor\Unity.exe" -batchmode -quit -nographics -silent-crashes -buildTarget standalone -projectPath "%~dp0" -executeMethod PackageExporter.Export -logfile "%LogDirectory%\unity_package.log"
@IF ERRORLEVEL 1 (
    ECHO Package build FAILED
    exit /b %ERRORLEVEL%
)
