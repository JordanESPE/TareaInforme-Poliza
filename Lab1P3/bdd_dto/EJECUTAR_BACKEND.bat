@echo off
echo ========================================
echo  Ejecutando Backend Spring Boot
echo ========================================
echo.
echo Verificando Java...
java -version
echo.
echo Iniciando el servidor en puerto 9090...
echo Presiona Ctrl+C para detener el servidor
echo.
echo ========================================
echo.

cd /d "%~dp0"
call mvnw.cmd spring-boot:run

pause
