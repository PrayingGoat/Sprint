@echo off
setlocal
@REM  temp folder
set "temp=C:\Users\Maharina\Desktop\FIANARANA\S4\Mr_Naina\Framemlay\temp_MVC"

@REM lib folder
set "lib=%cd%\lib"
 
@REM web.xml file                          
set "xml=%cd%\web.xml" 


@REM web folder   
set "web=%cd%\web"  

@REM SRC
set "src=%cd%\src"

@REM webapps folder
set "webapps=C:\Program Files\Apache Software Foundation\Tomcat 10.1\webapps"

@REM Supprime le dossier temporaire 
rmdir /s /q "%temp%"
echo Dossier temporaire supprimé. 

@REM Recrée le dossier temporaire
mkdir "%temp%"

@REM Copie web vers lib
xcopy /s /e /y "%lib%" "%temp%\WEB-INF\lib\"

@REM Copie web/views vers WEB-INF/views/jsp/
xcopy /s /e /y "%web%\views" "%temp%\WEB-INF\views\"

@REM Copie xml vers web
copy /Y %xml% "%temp%\WEB-INF\"

@REM Copie xml vers web
copy /Y %dispatcher% "%temp%\WEB-INF\"

mkdir "%temp%\WEB-INF\classes\"

@REM Compiler les fichiers .java
for /R "%src%" %%f in (*.java) do (
    javac -cp "%lib%\*;%src%" -d "%temp%\WEB-INF\classes" "%%f"
)

@REM get my folder name
for /D %%i in ("%cd%") do set "myfolder=%%~nxi"

@REM Créer un fichier .war à partir du dossier temp
jar -cvf %myfolder%.war -C "%temp%" .

@REM @REM Déplacer le fichier .war vers le dossier webapps de Tomcat
move %myfolder%.war "%webapps%"

endlocal