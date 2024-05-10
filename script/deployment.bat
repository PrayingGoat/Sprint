rem @echo off
setlocal

rem Déclaration des variables
set projet=Sprint0
set temp=.\..\temp
set conf=.\..\..\test\conf
set lib=.\..\lib
set src=.\..\src
set bin=.\..\bin
set destination=C:\apache-tomcat-10.1.17\webapps

rem Vérifier si le dossier temp existe
if exist "%temp%\" (
    rd /S /Q "%temp%"
)

rem Création d'un dossier temp avec les contenu de base si le dossier temp n'existe pas
mkdir "%temp%"
mkdir "%temp%\WEB-INF"
mkdir "%temp%\WEB-INF\lib"

rem création de fichier .jar
jar cvf "%lib%\%projet%".jar -C "%bin%" .

rem Copie des élements indispensables pour tomcat vers temp
xcopy /E /I /Y "%conf%\" "%temp%\WEB-INF\"
xcopy /E /I /Y "%lib%\" "%temp%\WEB-INF\lib"

rem Compilation des codes java vers le dossier bin
call compilateur.bat

rem Déplacement du répertoire actuel vers temp
cd /D "%temp%"

rem Compresser dans un fichier war
jar -cvf "..\%projet%".war *

rem Déplacement du répertoire actuel vers le projet
cd /D ..\

rem Copie des élements indispensables pour tomcat vers temp
copy /Y  ".\%projet%.war" "%destination%"

endlocal
