@echo off
echo ========================================
echo  Ejecutando Frontend Flutter
echo ========================================
echo.
echo Verificando Flutter...
flutter --version
echo.
echo Asegurate de tener un emulador corriendo o dispositivo conectado
echo.
echo Iniciando la aplicacion...
echo Presiona Ctrl+C para detener la app
echo.
echo ========================================
echo.

cd /d "%~dp0"
flutter run

pause
