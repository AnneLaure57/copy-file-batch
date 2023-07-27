@echo off
chcp 65001
setlocal enabledelayedexpansion

:RESTART

cls

set /p "source_file=Entrez le chemin complet du fichier source : "
set /p "destination_folder=Entrez le chemin complet du dossier de destination : "
set /p "filename=Entrez le nom de votre nouveau fichier : "
set /p "extension=Entrez l'extension de votre fichier : "
set /p "increment=Entrez le numéro d'incrément souhaité : "
set /p "times=Entrez le nombre de fois que le fichier doit être incrémenté : "

:: Check if source file exists
if not exist "%source_file%" (
    echo Le fichier source n'existe pas.
    goto :RESTART
)

:: Check if destination folder exists, else create it
if not exist "%destination_folder%" (
    mkdir "%destination_folder%"
)

for /L %%i in (1,1,%times%) do (
    set "padded_increment=000000!increment!"
    set "padded_increment=!padded_increment:~-6!"

    set "destination_file=%destination_folder%\%filename%!padded_increment!.%extension%"

    if exist "!destination_file!" (
        set /a "increment+=1"
        goto :RESTART
    )

    :: Copy the source file to the destination folder with the new increment number
    copy "%source_file%" "!destination_file!"
    echo Fichier cloné avec succès : !destination_file!

    set /a "increment+=1"
)

:ASK_RESTART

set /p "retry=Voulez-vous réessayer (O/N) ? "
if /i "%retry%"=="O" goto :RESTART
if /i "%retry%"=="N" goto :EOF

pause