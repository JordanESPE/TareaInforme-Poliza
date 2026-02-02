@echo off
echo ================================================
echo  EJECUTANDO BACKEND SPRING BOOT
echo ================================================
echo.
echo Creando unidad virtual para evitar problemas...
subst Z: "%~dp0" 2>nul
if exist Z:\ (
    echo Unidad Z: creada exitosamente
    cd /d Z:\
    echo.
    echo Ejecutando Maven Wrapper...
    echo.
    call mvnw.cmd spring-boot:run
    subst Z: /D
) else (
    echo No se pudo crear la unidad virtual
    echo Intentando ejecutar directamente...
    cd /d "%~dp0"
    call mvnw.cmd spring-boot:run
)
pause
