@echo off
cd /d "%~dp0"
call mvnw.cmd clean spring-boot:run
