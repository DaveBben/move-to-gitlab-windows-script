@ECHO OFF



ECHO This tool will move any repo from GitHub to GitLab

ECHO.

ECHO Before you begin, make sure that you have Git installed and SSH access for GitLab configured.

ECHO ------------------------------

set /p username=Enter GitLab username: 



:download

set /p link=Enter Github URL (without the .git): 

ECHO Downloading Repo

ECHO -------------------------------------

call git clone %link%

ECHO ------------------------------------

ECHO Download Complete.

set project=%link:/= & set project=%

ECHO %project%

CD /D %project%

call git remote set-url origin git@gitlab.com:%username%/%project%.git

call git add . & git commit -m "Moved to Gitlab" & git push -u origin master

ECHO ------------------------------------

ECHO Mirgration complete

CD /D ../

ECHO Cleaning up Files

rmdir /S /Q %project%

ECHO ------------------------------------

set /p INPUT=Would you like to transfer another repo? (y/n) 

If /I "%INPUT%"=="y" goto download 



