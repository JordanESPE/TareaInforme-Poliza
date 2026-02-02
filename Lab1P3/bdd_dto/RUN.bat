@echo off
title Backend - Polizas
cd /d "%~dp0"

echo ================================================
echo  EJECUTANDO BACKEND SPRING BOOT
echo ================================================
echo.
echo Backend URL: http://localhost:9090/bdd_dto
echo.

call mvnw.cmd clean spring-boot:run
