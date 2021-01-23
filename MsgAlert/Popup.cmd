@echo off
::Pop up a msg alert box with a message and sound an alert.
pushd "%cd%"
cd "%~dp0"
if [%1] == [] (
  msg %username% "Alert message not provided."
) else (
  msg %username% %1
) 
cmdmp3.exe 006.wav
popd
