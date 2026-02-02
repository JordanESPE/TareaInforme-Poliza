@echo off
title Backend Spring Boot - Pólizas
color 0A
echo ================================================
echo       BACKEND SPRING BOOT - SISTEMA POLIZAS
echo ================================================
echo.
echo [INFO] Verificando MySQL...

REM Verificar si MySQL está corriendo
tasklist /FI "IMAGENAME eq mysqld.exe" 2>NUL | find /I /N "mysqld.exe">NUL
if "%ERRORLEVEL%"=="0" (
    echo [OK] MySQL esta corriendo
) else (
    echo [ADVERTENCIA] MySQL no detectado
    echo.
    echo Por favor:
    echo 1. Abre UniServer
    echo 2. Inicia MySQL
    echo 3. Vuelve a ejecutar este script
    echo.
    pause
    exit /b 1
)

echo.
echo [INFO] Cambiando al directorio del proyecto...
cd /d "%~dp0"

echo [INFO] Verificando Java...
java -version
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Java no encontrado
    pause
    exit /b 1
)

echo.
echo ================================================
echo  EJECUTANDO SPRING BOOT
echo ================================================
echo.
echo Backend se iniciara en: http://localhost:9090/bdd_dto
echo.
echo Presiona Ctrl+C para detener el servidor
echo.

REM Ejecutar usando Maven Wrapper directamente
call "%~dp0mvnw.cmd" clean spring-boot:run

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo [ERROR] Fallo al iniciar el backend
    echo.
    pause
)
