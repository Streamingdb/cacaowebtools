@echo off
cls
set director=%cd%
setlocal enableextensions enabledelayedexpansion

Rem W32 Tools
set CHOOSE=Choose32.exe
set SHOWC=ShowConsole.exe
set COLOR=txtcolor.exe

Rem r้pertoire configCS
set configca=configCS\configca.txt
set confignav=configCS\confignav.txt
set configpar=configCS\configpar.txt

Rem r้pertoire divers
set temp23="%temp%\temp23.txt"
set licence=licence.txt
set aide1=AideCS\AideCS1.txt
set aide2=AideCS\AideCS2.txt
set aide3=AideCS\AideCS3.txt

cls
REM Cela ne marche que sous NT
if not "%os%"=="Windows_NT" goto :NT926
color 02

Rem Infologiciel
set nomlog=CacaoSupervisor
set verlog=1.0
title %nomlog% v%verlog%

Rem Options de lancements: -d utilisation sans d้tection du navigateur
Rem                        -c cacaomod: d้tecte si cacaoweb est d้ja lan็้ sinon le lance (r้pertoire courants)
Rem                        -k cacaostop: ้teint juste cacaoweb dans les processus
Rem                        -i invisiblemod: fais tout sans aucunes fen๊tre
Rem                        -j menu de configuration avanc้e...
Rem                        -m menu
Rem                        -q invisi + lance cacaoweb
Rem                        -S invisi avec cacao
Rem                        -delete Pour supprimer tout les fichiers de configuration..
Rem                        -p Profil manager

        if "%1"=="" goto :NoParam
        if "%1"=="-h" goto :command
        if "%1"=="-d" goto :navigateurok
        if "%1"=="-c" goto :cacaomod
        if "%1"=="-k" goto :cacaostop
        if "%1"=="-i" goto :invisible
        if "%1"=="-j" goto :parameter
        if "%1"=="-m" goto :menureturn22
        if "%1"=="-q" goto :invisicacao
        if "%1"=="-s" goto :invisinonav
        if "%1"=="-delete" goto :delcongig
        if "%1"=="-help" goto :help
        if "%1"=="-p" goto :manager
            if "%1"=="-p1" goto :benjamin
            if "%1"=="-p2" goto :marine
            if "%1"=="-p3" goto :evelyne
        

Rem Menu d'un mode de lancement...
:menureturn22
cls
%SHOWC% SHOW MAXIMIZED
mode con cols=93 lines=58
color 84
Rem utilisation de txtcolor.exe by carlos
echo.
%COLOR% 80 0 "     "
%COLOR% 70 0 "                                                                                "
%COLOR% 00 1 ""
%COLOR% 80 0 "     "
%COLOR% 70 0 "        ***** BIENVENUE DANS LE MENU PRICIPALE DE"
%COLOR% 70 0 " "
%COLOR% 72 0 "CacaoSupervisor"
%COLOR% 70 0 " *****         "
%COLOR% 80 0 " "
%COLOR% 70 1 ""
%COLOR% 80 0 "     "
%COLOR% 70 0 "                                                                                "
%COLOR% 00 0 " "
%COLOR% 70 1 ""
%COLOR% 80 0 "       "
%COLOR% 00 0 "                                                                               "
%COLOR% 00 1 ""
echo.
%COLOR% 80 0 "      "
%COLOR% 70 0 "                                                                                "
%COLOR% 00 1 ""
%COLOR% 80 0 "      "
%COLOR% 76 0 "  [CHOIX Nฐ1] - Lancement en mode normal :                                      "
%COLOR% 00 1 ""
%COLOR% 80 0 "      "
%COLOR% 70 0 "    ++ Detection du navigateur. Attente de fermeture du navigateur.             "
%COLOR% 00 1 ""
%COLOR% 80 0 "      "
%COLOR% 70 0 "    ++ Stoppe le processus de Cacaoweb.                                         "
%COLOR% 00 1 ""
%COLOR% 80 0 "      "
%COLOR% 70 0 "    ++ Suppression des traces de Cacaoweb dans AppData et dans le registre.     "
%COLOR% 00 1 ""
%COLOR% 80 0 "      "
%COLOR% 70 0 "                                                                                "
%COLOR% 80 1 ""
%COLOR% 80 0 "      "
%COLOR% 76 0 "  [CHOIX Nฐ2] - Lancement en tache de fond :                                    "
%COLOR% 00 1 ""
%COLOR% 80 0 "      "
%COLOR% 70 0 "    ++ Effectue les operation du mode normal, le logiciel n'apparait pas.       "
%COLOR% 00 1 ""
%COLOR% 80 0 "      "
%COLOR% 73 0 "    Les erreurs feront reaparaitre la console.                                  "
%COLOR% 80 1 ""
%COLOR% 80 0 "      "
%COLOR% 73 0 "    A utiliser que si vous etes sur que le mode normal fonctionne correctement. "
%COLOR% 00 1 ""
%COLOR% 80 0 "      "
%COLOR% 70 0 "                                                                                "
%COLOR% 80 1 ""
%COLOR% 80 0 "      "
%COLOR% 76 0 "  [CHOIX Nฐ3] - Lancement en mode normal avec Cacaoweb :                        "
%COLOR% 00 1 ""
%COLOR% 80 0 "      "
%COLOR% 70 0 "    ++ Effectue les operation du mode normal, mais ajoute le demarrage          "
%COLOR% 00 1 ""
%COLOR% 80 0 "      "
%COLOR% 70 0 "    automatique de Cacaoweb s'il a ete trouve. Voir l'aide pour en savoir plus. "
%COLOR% 80 1 ""
%COLOR% 80 0 "      "
%COLOR% 70 0 "                                                                                "
%COLOR% 80 1 ""
%COLOR% 80 0 "      "
%COLOR% 76 0 "  [CHOIX Nฐ4] - Lancement en tache de fond avec Cacaoweb :                      "
%COLOR% 00 1 ""
%COLOR% 80 0 "      "
%COLOR% 70 0 "    ++ Meme indications citee dans le menu nฐ2, ajoute le lancement de Cacaoweb."
%COLOR% 80 1 ""
%COLOR% 80 0 "      "
%COLOR% 70 0 "                                                                                "
%COLOR% 00 1 ""
echo.
echo          Attention les modes suivant sont a executer lorsque vous ne regardez plus un
echo          film, sinon la lecture de celui-ci pourrait tre interompue.
echo.
%COLOR% 80 0 "      "
%COLOR% 70 0 "                                                                                "
%COLOR% 80 1 ""
%COLOR% 80 0 "      "
%COLOR% 76 0 "  [CHOIX Nฐ5] - Suppression totale de Cacaoweb :                                "
%COLOR% 00 1 ""
%COLOR% 80 0 "      "
%COLOR% 70 0 "   ++ Stoppe Cacaoweb, le supprime de AppData et du registre.                   "
%COLOR% 80 1 ""
%COLOR% 80 0 "      "
%COLOR% 70 0 "                                                                                "
%COLOR% 00 1 ""
%COLOR% 80 0 "      "
%COLOR% 76 0 "  [CHOIX Nฐ6] - Suppression totale de Cacaoweb,"
%COLOR% 73 0 " en tache de fond"
%COLOR% 76 0 ":               "
%COLOR% 00 1 ""
%COLOR% 80 0 "      "
%COLOR% 70 0 "   ++ Meme actions que pour le choix nฐ5, "
%COLOR% 73 0 "meme chose en cas d'erreur.          "
%COLOR% 70 0 " "
%COLOR% 80 1 ""
%COLOR% 80 0 "      "
%COLOR% 70 0 "                                                                                "
%COLOR% 00 1 ""
echo.
%COLOR% 80 0 "      "
%COLOR% 70 0 "                                                                                "
%COLOR% 00 1 ""
%COLOR% 80 0 "      "
%COLOR% 76 0 "  [CHOIX Nฐ7] - AIDE DE CACAOSUPERVISOR :                                       "
%COLOR% 00 1 ""
%COLOR% 80 0 "      "
%COLOR% 70 0 "    ++ Cette section vous est reserve si vous ne connaissez pas le logiciel.    "
%COLOR% 00 1 ""
%COLOR% 80 0 "      "
%COLOR% 70 0 "    Elle contient toutes les informations necessaire a son bon fonctionnement.  "
%COLOR% 00 1 ""
%COLOR% 80 0 "      "
%COLOR% 70 0 "    ++ Elle pourra aussi afficher les informations et la licence du logiciel.   "
%COLOR% 00 1 ""
%COLOR% 80 0 "      "
%COLOR% 70 0 "                                                                                "
%COLOR% 80 1 ""
%COLOR% 80 0 "      "
%COLOR% 76 0 "  [CHOIX Nฐ8] - CONFIGURATION AVANCEES DES REPERTOIRES :                        "
%COLOR% 00 1 ""
%COLOR% 80 0 "      "
%COLOR% 70 0 "    ++ Attention cette section est reservee aux personnes innitiee a l'informa- "
%COLOR% 00 1 ""
%COLOR% 80 0 "      "
%COLOR% 70 0 "    tique.Un sous-menu proposera; de definir le repertoire du logiciel Cacaoweb "
%COLOR% 00 1 ""
%COLOR% 80 0 "      "
%COLOR% 70 0 "    ou bien de modifier le lancement de votre navigateur (Chemin + Parametres). "
%COLOR% 00 1 ""
%COLOR% 80 0 "      "
%COLOR% 70 0 "                                                                                "
%COLOR% 80 1 ""
echo.
echo            *Le [Choix n.9], qui consiste … tuer rapidement le processus.*
echo.
%COLOR% 80 0 "   CacaoSupervisor est un logiciel sous licence protegee. (Voir Menu Aide)      "
%COLOR% 80 1 ""
%COLOR% 80 0 "   Programme par benjahinfo, benjahinfo@laposte.net                             "
%COLOR% 00 1 ""
echo.
echo Pressez [M] pour aller au gestionnaire de profils.
echo Pressez [C] pour voir les options de lancements possible (Commandes).

set errorlevel=
%CHOOSE% -c 123456789MRQC -p " *Faites votre choix [R=Pour rafficher le menu][Q=Quitter]"
if errorlevel==13 goto :command
if errorlevel==12 goto :endall
if errorlevel==11 goto :menureturn22
if errorlevel==10 goto :manager
if errorlevel==9 goto :cacaostop
if errorlevel==8 goto :parameter
if errorlevel==7 goto :help
if errorlevel==6 goto :invisinonav
if errorlevel==5 goto :navigateurok
if errorlevel==4 goto :invisicacao
if errorlevel==3 goto :cacaomod
if errorlevel==2 goto :invisible
if errorlevel==1 goto :NoParam


Rem Lancement Automatique de Cacaoweb
:cacaomod
cls
if exist "%configca%" (
          goto :startperso
) else (
          goto :defautcaca
)

:defautcaca
set app0="cacaoweb.exe"
set app1="%userprofile%\Desktop\cacaoweb.exe"
set app2="%appdata%\cacaoweb\cacaoweb.exe"


if exist "cacaoweb.exe" goto :replogstart
echo cacaoweb.exe non trouv dans le rpertoire du logiciel
cd "%userprofile%\Desktop"

if exist "%userprofile%\Desktop\cacaoweb.exe" goto :desktoplaunch
echo cacaoweb.exe non trouv sur le bureau de %USERNAME%
cd "%appdata%\cacaoweb"

if exist "%appdata%\cacaoweb\cacaoweb.exe" goto :bataroo
echo cacaoweb.exe non trouv dans "%appdata%\cacaoweb\"

goto :ohnoo

Rem Demmarrage Cacaoweb
:replogstart
start "cacaoweb" %app0%
goto :suiteok
:desktoplaunch
start "cacaoweb" %app1%
goto :suiteok
:bataroo
start "cacaoweb" %app2%
goto :suiteok

Rem Aucun Navigateur trouv้...
:ohnoo
%SHOWC% SHOW MAXIMIZED
mode con cols=78 lines=18
color 4F
echo.
echo  Cacaoweb n'a pas pu tre trouv sur votre ordinateur...
echo  Par dfaut, CacaoSupervisor recherche Cacaoweb … ses emplacements possible
echo  qui sont:
echo   - Le rpertoire de CacaoSupervisor.
echo   - Le rpertoire "Bureau" de cette session.
echo   - Le rpertoire "utilisateur\AppData\Roaming\cacaoweb".
echo  ___________________________________________________________________________
echo.
echo   *** Vous avez la possibilit de (Configurer) votre propre rpertoire: ***
echo                 ***** Appuyez sur la touche [C]. *****
echo  ___________________________________________________________________________
echo.
echo  Pour (Quitter) le programme, pressez [Q].
echo  Pour (Ignorer) et passer … la suite, pressez [I],
echo       * N'oubliez pas de lancer Cacaoweb ! *
echo.
set errorlevel=
%CHOOSE% -c CQI -p "  Quel est votre choix ?"
if errorlevel==3 goto :NoParam
if errorlevel==2 goto :endall
if errorlevel==1 goto :configcacao


Rem param่tre perso du navigateur avex cacaoweb
:startperso
if exist "%confignav%" (
         goto :blattera
) else (
         goto :launchcaca
)

:launchcaca
Rem lancement Cacaoweb en lisant le fichier config !
for /f "tokens=2 delims=;" %%q in ('type %configca%') do set cacaoweb=%%q
if "%cacaoweb%"=="" (
             goto :bouyaka
) else (
             start "" "%cacaoweb%"
             goto :suiteok
)


REM lancement auto config perso cacaoweb
:blattera
for /f "tokens=2 delims=;" %%r in ('type %confignav%') do set confignav22=%%r
if exist "%configpar%" (
           goto :avecparametre
) else (
           goto :sansparametre
)

:sansparametre
for /f "tokens=2 delims=;" %%q in ('type %configca%') do set cacaoweb22=%%q
if "%cacaoweb22%"=="" (
             goto :bouyaka
) else (
             goto :lololo
)

:lololo
if "%confignav22%"=="" (
                 goto :bouyaka
) else (
                 goto :popopo
)
:popopo
start "Cacaoweb" %cacaoweb22% -noplayer
cls
echo  En attente du dmarrage de Cacaoweb...
ping 0.0.0.0 -n 7 >nul
start "Cacaoweb" "%confignav22%" http://local.cacaoweb.org:4001/
goto :cacaotestnav



:avecparametre
for /f "tokens=2 delims=;" %%x in ('type %configca%') do set cacaoweb33=%%x
if "%cacaoweb33%"=="" (
             goto :bouyaka
) else (
             goto :mama
)

:mama
if "%confignav22%"=="" (
                 goto :bouyaka
) else (
                 goto :bijou
)
:bijou
for /f "tokens=2 delims=;" %%r in ('type %configpar%') do set configpar22=%%r
if "%configpar22%"=="" (
                 goto :bouyaka
) else (
                 goto :cinq
)
:cinq
start "Cacaoweb" "%cacaoweb33%" -noplayer
cls
echo  En attente du dmarrage de Cacaoweb...
ping 0.0.0.0 -n 7 >nul
start "" "%confignav22%" http://local.cacaoweb.org:4001/ %configpar22%

:cacaotestnav
%SHOWC% SHOW MAXIMIZED
mode con cols=75 lines=7
REM TESTER LE LANCEMENT DE CACAOWEB AVEC CONFIG NAVIGATEUR
color 0E
cls
echo  Patientez... Le logiciel vrifie que Cacaoweb est bien lan.
ping 0.0.0.0 -n 3 >nul
cls
tasklist | findstr /i "cacaoweb.exe" >nul
if errorlevel==1 goto :boucherdu
if errorlevel==0 goto :pontative
:pontative
echo  Cacaoweb … bien t trouv dans la liste des processus actifs...
goto :attentenavok
:boucherdu
mode con cols=75 lines=7
color 4F
echo  Cacaoweb n'a pas t dtect, le rpertoire est-il bien correcte ?
echo  Vrifiez la configuration s'il vous plait...
echo  INFO: Faites "CacaoSupervisor.exe -delete" pour supprimer votre
echo  rpertoire de configuration et revenir … la configuration normale.
ping 0.0.0.0 -n 10 >nul
goto  :bouyaka


:suiteok
%SHOWC% SHOW MAXIMIZED
mode con cols=75 lines=7
REM TESTER LE LANCEMENT DE CACAOWEB AVEC CONFIG REP CACAO
color 0E
cls
echo  Patientez... Le logiciel vrifie que Cacaoweb est bien lan.
ping 0.0.0.0 -n 8 > nul
cls
tasklist | findstr /i "cacaoweb.exe" >nul
if errorlevel==1 goto :marcleroter
if errorlevel==0 goto :dupontat
:dupontat
echo  Cacaoweb … bien t trouv dans la liste des processus actifs...
goto :NoParam
:marcleroter
mode con cols=75 lines=7
color 4F
echo  Cacaoweb n'a pas t dtect, le rpertoire est-il correcte ?
echo  Vrifiez la configuration s'il vous plait...
echo  Si votre navigateur est lent … l'ouverture, il est possible que le
echo  logiciel ne le dtecte pas.
echo  INFO: Faites "CacaoSupervisor.exe -delete" pour supprimer votre
echo  rpertoire de configuration et revenir … la configuration normale.
ping 0.0.0.0 -n 15 > NUL
goto  :bouyaka

REM CONFIG PERSO ERROR
:bouyaka
%SHOWC% SHOW MAXIMIZED
mode con cols=77 lines=25
color 4F
cls
echo.
echo Impossible de charger vos paramtres personnaliss...
echo Vrifiez la configuration s'il vous plat.
echo - Pressez [C] pour (Configurer) vos rpertoires et paramtres.
echo.
echo - Important 1: si Cacaoweb s'est correctement excut vous pouvez appuyer
echo sur [D] pour Poursuivre vers la (Dtection) du {navigateur par dfaut}.
echo - Important 2: si Cacaoweb s'est correctement excut dans votre
echo navigateur personnalis vous pouvez appuyer sur [P] pour (Poursuivre) vers
echo la dtection approprie.
echo.
echo - Pressez [L] pour lancer Cacaoweb depuis les rpertoires par dfauts qui
echo sont: Dans le dossier "appdata", le bureau, le rperoire de CacaoSupervisor.
echo Cela annulera le lancement avec votre navigateur personnalis.
echo.
echo - Pressez [S] pour (Supprimer) les fichiers de configurations, cela
echo remettra le logiciel par dfaut mais vous devrez reconfigurer vos
echo chemins de rpertoires et vos paramtres si vous voulez les rutiliser.
echo Ensuite le logiciel se fermera.
echo.
echo - Pressez [Q] pour (Quitter).
echo.
set errorlevel=
%CHOOSE% -c SCQLDP -p "  Quel est votre choix ?"
if errorlevel==6 goto :attentenavok
if errorlevel==5 goto :NoParam
if errorlevel==4 goto :defautcaca
if errorlevel==3 goto :endall
if errorlevel==2 goto :parameter
if errorlevel==1 goto :delcongig




REM TEST NAVIGATEUR LANCEMENT
:attentenavok
cls
echo En attente pour trouver le processus du navigateur personnel...

set navigator=PERSO

For /f "delims=." %%d in ('type "%confignav%"') do set moon=%%d
echo ^%moon% > tmpa.txt

for /f "tokens=15* delims=\" %%g in ('type "tmpa.txt"') do set barrette=%%g
if "%barrette%"=="" (
goto :moro14
) else (
goto :boullete
)

:moro14
set barrette=
for /f "tokens=14* delims=\" %%g in ('type "tmpa.txt"') do set barrette=%%g
if "%barrette%"=="" (
goto :moro13
) else (
goto :boullete
)

:moro13
set barrette=
for /f "tokens=13* delims=\" %%g in ('type "tmpa.txt"') do set barrette=%%g
if "%barrette%"=="" (
goto :moro12
) else (
goto :boullete
)

:moro12
set barrette=
for /f "tokens=12* delims=\" %%g in ('type "tmpa.txt"') do set barrette=%%g
if "%barrette%"=="" (
goto :moro11
) else (
goto :boullete
)

:moro11
set barrette=
for /f "tokens=11* delims=\" %%g in ('type "tmpa.txt"') do set barrette=%%g
if "%barrette%"=="" (
goto :moro10
) else (
goto :boullete
)

:moro10
set barrette=
for /f "tokens=10* delims=\" %%g in ('type "tmpa.txt"') do set barrette=%%g
if "%barrette%"=="" (
goto :moro9
) else (
goto :boullete
)

:moro9
set barrette=
for /f "tokens=9* delims=\" %%g in ('type "tmpa.txt"') do set barrette=%%g
if "%barrette%"=="" (
goto :moro8
) else (
goto :boullete
)

:moro8
set barrette=
for /f "tokens=8* delims=\" %%g in ('type "tmpa.txt"') do set barrette=%%g
if "%barrette%"=="" (
goto :moro7
) else (
goto :boullete
)

:moro7
set barrette=
for /f "tokens=7* delims=\" %%g in ('type "tmpa.txt"') do set barrette=%%g
if "%barrette%"=="" (
goto :moro6
) else (
goto :boullete
)

:moro6
set barrette=
for /f "tokens=6* delims=\" %%g in ('type "tmpa.txt"') do set barrette=%%g
if "%barrette%"=="" (
goto :moro5
) else (
goto :boullete
)

:moro5
set barrette=
for /f "tokens=5* delims=\" %%g in ('type "tmpa.txt"') do set barrette=%%g
if "%barrette%"=="" (
goto :moro4
) else (
goto :boullete
)

:moro4
set barrette=
for /f "tokens=4* delims=\" %%g in ('type "tmpa.txt"') do set barrette=%%g
if "%barrette%"=="" (
goto :moro3
) else (
goto :boullete
)

:moro3
set barrette=
for /f "tokens=3* delims=\" %%g in ('type "tmpa.txt"') do set barrette=%%g
if "%barrette%"=="" (
goto :moro2
) else (
goto :boullete
)

:moro2
set barrette=
for /f "tokens=2* delims=\" %%g in ('type "tmpa.txt"') do set barrette=%%g
if "%barrette%"=="" (
goto :moro1
) else (
goto :boullete
)

:moro1
set barrette=
for /f "tokens=1* delims=\" %%g in ('type "tmpa.txt"') do set barrette=%%g
if "%barrette%"=="" (
goto :niak
) else (
goto :boullete
)


Rem Navigateur trouv้ !!!
:boullete
del /f /q tmpa.txt
set barrette=%barrette:~0,-1%
mode con cols=73 lines=8
color 06
cls
if "%navigator%"=="%navigator%" (
   for /f "tokens=2 delims= " %%i in ('tasklist ^| findstr /i /c:"%barrette%"') do goto :bonjour
   goto :navigateurok
) else (
   goto :niak
)
:bonjour
if "%navigator%"=="%navigator%" (
   call :timeto
   cls
   color 02
   echo.
   echo  ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
   echo               xxx %barrette% xxx est en cours d'excution...
   echo    Le programme se poursuiverera quand vous fermerez votre navigateur..
   echo              Vrification toutes les 30 secondes environs
   echo  ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
   ping 0.0.0.0 -n 30 > NUL
   cls
   echo.
   color 06
   echo  *** Vous avez 5 secondes pour annuler la dtection du navigateur ***
   echo    ****[S] pour passer … la suppression des traces de cacaoweb****
   echo                 **[Q] pour quitter CacaoSupervisor**
   %CHOOSE% -c SQR -d R -n -q -t R,5
       if errorlevel==3 goto :retourautres888
       if errorlevel==2 goto :endall
       if errorlevel==1 goto :navigateurok
   :retourautres888
   for /f "tokens=2 delims= " %%i in ('tasklist ^| findstr /i /c:"%barrette%"') do goto :bonjour
   goto :navigateurok
) else (
   goto :niak
)

:niak
%SHOWC% SHOW MAXIMIZED
mode con cols=75 lines=10
color 4F
cls
echo.
echo    Votre navigateur personnalis ne peut tre surveill...
echo.
echo    Appuyez sur [C] pour (Continuer) le processus du logiciel: Il effectura
echo    les oprations de dsinstallation de Cacaoweb. Donc si vous regardez
echo    un film, (Quitter) le logiciel, sinon celui-ci sera intrrompue.[Q].
echo    - Accedez au (Menu) principale via la touche [M].
%CHOOSE% -c CQM -p "  Quel est votre choix ?"
if errorlevel==3 goto :menureturn22
if errorlevel==2 goto :endall
if errorlevel==1 goto :navigateurok

REM MODE NORMAL DEBUT ENTIER
:yesmansay
ping 0.0.0.0 -n 10 > NUL
:NoParam
Rem Utilistaion en mode normal
cls
mode con cols=73 lines=8
Rem Enregistrement du navigateur par d้faut
set navigator=
for /f "tokens=3* delims= " %%A in ('reg query "HKEY_CURRENT_USER\Software\Clients\StartMenuInternet"') do set navigator=%%B
Rem Pricipaux navigateurs
color 06
if "%navigator%"=="FIREFOX.EXE" (
   for /f "tokens=2 delims= " %%i in ('tasklist ^| findstr /i /c:"firefox"') do goto :retourfirefox
   goto :navigateurok
) else (
   goto :internetexplorer1
)
:retourfirefox
color 02
if "%navigator%"=="FIREFOX.EXE" (
   cls
   echo.
   echo  ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
   echo               Mozilla Firefox est en cours d'excution...
   echo    Le programme se poursuiverera quand vous fermerez votre navigateur..
   echo             Vrification toutes les 30 secondes environs
   echo  ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
   ping 0.0.0.0 -n 30 > NUL
   cls
   echo.
   color 06
   echo   *** Vous avez 5 secondes pour annuler la dtection du navigateur ***
   echo      ****[S] pour passer … la suppression des traces de cacaoweb****
   echo                  **[Q] pour quitter CacaoSupervisor**
   %CHOOSE% -c SQR -d R -n -q -t R,5
       if errorlevel==3 goto :retourfirefox77
       if errorlevel==2 goto :endall
       if errorlevel==1 goto :navigateurok
   :retourfirefox77
   for /f "tokens=2 delims= " %%i in ('tasklist ^| findstr /i /c:"firefox"') do goto :retourfirefox
   goto :navigateurok
) else (
   goto :internetexplorer1
)

Rem Navigateur Internet explorer
:internetexplorer1
if "%navigator%"=="IEXPLORE.EXE" (
   for /f "tokens=2 delims= " %%i in ('tasklist ^| findstr /i /c:"iexplore"') do goto :internetexplorer
   goto :navigateurok
) else (
   goto :googlechrome1
)
:internetexplorer
color 02
if "%navigator%"=="IEXPLORE.EXE" (
   cls
   echo.
   echo  ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
   echo             Internet Explorer est en cours d'excution...
   echo    Le programme se poursuiverera quand vous fermerez votre navigateur..
   echo              Vrification toutes les 30 secondes environs
   echo  ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
   ping 0.0.0.0 -n 30 > NUL
   cls
   echo.
   color 06
   echo  *** Vous avez 5 secondes pour annuler la dtection du navigateur ***
   echo    ****[S] pour passer … la suppression des traces de cacaoweb****
   echo                 **[Q] pour quitter CacaoSupervisor**
   %CHOOSE% -c SQR -d R -n -q -t R,5
       if errorlevel==3 goto :internetexplorer77
       if errorlevel==2 goto :endall
       if errorlevel==1 goto :navigateurok
   :internetexplorer77
   for /f "tokens=2 delims= " %%i in ('tasklist ^| findstr /i /c:"iexplore"') do goto :internetexplorer
   goto :navigateurok
) else (
   goto :googlechrome1
)

Rem Google Chrome
:googlechrome1
if "%navigator%"=="Google Chrome" (
   for /f "tokens=2 delims= " %%i in ('tasklist ^| findstr /i /c:"chrome"') do goto :googlechrome
   goto :navigateurok
) else (
   goto :opera1
)
:googlechrome
color 02
if "%navigator%"=="Google Chrome" (
   cls
   echo.
   echo  ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
   echo                Google Chrome est en cours d'excution...
   echo    Le programme se poursuiverera quand vous fermerez votre navigateur..
   echo              Vrification toutes les 30 secondes environs
   echo  ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
   ping 0.0.0.0 -n 30 > NUL
   cls
   echo.
   color 06
   echo  *** Vous avez 5 secondes pour annuler la dtection du navigateur ***
   echo    ****[S] pour passer … la suppression des traces de cacaoweb****
   echo                 **[Q] pour quitter CacaoSupervisor**
   %CHOOSE% -c SQR -d R -n -q -t R,5
       if errorlevel==3 goto :googlechrome77
       if errorlevel==2 goto :endall
       if errorlevel==1 goto :navigateurok
   :googlechrome77
   for /f "tokens=2 delims= " %%i in ('tasklist ^| findstr /i /c:"chrome"') do goto :googlechrome
   goto :navigateurok
) else (
   goto :opera1
)

Rem Navigateur Opera
:opera1
if "%navigator%"=="Opera.exe" (
   for /f "tokens=2 delims= " %%i in ('tasklist ^| findstr /i /c:"opera"') do goto :opera
   goto :navigateurok
) else (
   goto :safari1
)
:opera
color 02
if "%navigator%"=="Opera.exe" (
   cls
   echo.
   echo  ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
   echo                      Opera est en cours d'excution...
   echo    Le programme se poursuiverera quand vous fermerez votre navigateur..
   echo              Vrification toutes les 30 secondes environs
   echo  ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
   ping 0.0.0.0 -n 30 > NUL
   cls
   echo.
   color 06
   echo  *** Vous avez 5 secondes pour annuler la dtection du navigateur ***
   echo    ****[S] pour passer … la suppression des traces de cacaoweb****
   echo                 **[Q] pour quitter CacaoSupervisor**
   %CHOOSE% -c SQR -d R -n -q -t R,5
       if errorlevel==3 goto :opera77
       if errorlevel==2 goto :endall
       if errorlevel==1 goto :navigateurok
   :opera77
   for /f "tokens=2 delims= " %%i in ('tasklist ^| findstr /i /c:"opera"') do goto :opera
   goto :navigateurok
) else (
   goto :safari1
)

Rem Navigateur Safari
:safari1
if "%navigator%"=="Safari.exe" (
   for /f "tokens=2 delims= " %%i in ('tasklist ^| findstr /i /c:"safari"') do goto :safari
   goto :navigateurok
) else (
   goto :autres1
)
:safari
if "%navigator%"=="Safari.exe" (
   color 02
   cls
   echo.
   echo  ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
   echo                    Safari est en cours d'excution...
   echo    Le programme se poursuiverera quand vous fermerez votre navigateur..
   echo              Vrification toutes les 30 secondes environs
   echo  ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
   ping 0.0.0.0 -n 30 > NUL
   cls
   echo.
   color 06
   echo  *** Vous avez 5 secondes pour annuler la dtection du navigateur ***
   echo    ****[S] pour passer … la suppression des traces de cacaoweb****
   echo                 **[Q] pour quitter CacaoSupervisor**
   %CHOOSE% -c SQR -d R -n -q -t R,5
       if errorlevel==3 goto :safari77
       if errorlevel==2 goto :endall
       if errorlevel==1 goto :navigateurok
   :safari77
   for /f "tokens=2 delims= " %%i in ('tasklist ^| findstr /i /c:"safari"') do goto :safari
   goto :navigateurok
) else (
   goto :autres1
)


Rem Navigateur non Courant
:autres1
FOR /F "tokens=3*" %%a IN ('REG QUERY "HKEY_CLASSES_ROOT\http\shell\open\command"') DO set oka=%%b
echo %oka% > tmp.txt
For /f "delims=." %%d in ('type "tmp.txt"') do set baj=%%d
echo ^%baj% > tmpa.txt
del /f /q "tmp.txt"

for /f "tokens=15* delims=\" %%g in ('type "tmpa.txt"') do set barrette=%%g
if "%barrette%"=="" (
goto :zod14
) else (
goto :oknav
)

:zod14
set barrette=
for /f "tokens=14* delims=\" %%g in ('type "tmpa.txt"') do set barrette=%%g
if "%barrette%"=="" (
goto :zod13
) else (
goto :oknav
)

:zod13
set barrette=
for /f "tokens=13* delims=\" %%g in ('type "tmpa.txt"') do set barrette=%%g
if "%barrette%"=="" (
goto :zod12
) else (
goto :oknav
)

:zod12
set barrette=
for /f "tokens=12* delims=\" %%g in ('type "tmpa.txt"') do set barrette=%%g
if "%barrette%"=="" (
goto :zod11
) else (
goto :oknav
)

:zod11
set barrette=
for /f "tokens=11* delims=\" %%g in ('type "tmpa.txt"') do set barrette=%%g
if "%barrette%"=="" (
goto :zod10
) else (
goto :oknav
)

:zod10
set barrette=
for /f "tokens=10* delims=\" %%g in ('type "tmpa.txt"') do set barrette=%%g
if "%barrette%"=="" (
goto :zod9
) else (
goto :oknav
)

:zod9
set barrette=
for /f "tokens=9* delims=\" %%g in ('type "tmpa.txt"') do set barrette=%%g
if "%barrette%"=="" (
goto :zod8
) else (
goto :oknav
)

:zod8
set barrette=
for /f "tokens=8* delims=\" %%g in ('type "tmpa.txt"') do set barrette=%%g
if "%barrette%"=="" (
goto :zod7
) else (
goto :oknav
)

:zod7
set barrette=
for /f "tokens=7* delims=\" %%g in ('type "tmpa.txt"') do set barrette=%%g
if "%barrette%"=="" (
goto :zod6
) else (
goto :oknav
)

:zod6
set barrette=
for /f "tokens=6* delims=\" %%g in ('type "tmpa.txt"') do set barrette=%%g
if "%barrette%"=="" (
goto :zod5
) else (
goto :oknav
)

:zod5
set barrette=
for /f "tokens=5* delims=\" %%g in ('type "tmpa.txt"') do set barrette=%%g
if "%barrette%"=="" (
goto :zod4
) else (
goto :oknav
)

:zod4
set barrette=
for /f "tokens=4* delims=\" %%g in ('type "tmpa.txt"') do set barrette=%%g
if "%barrette%"=="" (
goto :zod3
) else (
goto :oknav
)

:zod3
set barrette=
for /f "tokens=3* delims=\" %%g in ('type "tmpa.txt"') do set barrette=%%g
if "%barrette%"=="" (
goto :zod2
) else (
goto :oknav
)

:zod2
set barrette=
for /f "tokens=2* delims=\" %%g in ('type "tmpa.txt"') do set barrette=%%g
if "%barrette%"=="" (
goto :zod1
) else (
goto :oknav
)

:zod1
set barrette=
for /f "tokens=1* delims=\" %%g in ('type "tmpa.txt"') do set barrette=%%g
if "%barrette%"=="" (
goto :lola
) else (
goto :oknav
)


Rem Navigateur trouv้ !!!
:oknav
set barrette=%barrette:~0,-1%
del /f /q "tmpa.txt"
color 06
cls
if "%navigator%"=="%navigator%" (
   for /f "tokens=2 delims= " %%n in ('tasklist ^| findstr /i /c:"%barrette%"') do goto :mechano
   goto :navigateurok
) else (
   goto :batar
)

:mechano
color 02
if "%navigator%"=="%navigator%" (
   cls
   echo.
   echo  ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
   echo             xxx %navigator% xxx est en cours d'excution...
   echo    Le programme se poursuiverera quand vous fermerez votre navigateur..
   echo              Vrification toutes les 30 secondes environs
   echo  ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
   ping 0.0.0.0 -n 30 > NUL
   cls
   echo.
   color 06
   echo  *** Vous avez 5 secondes pour annuler la dtection du navigateur ***
   echo    ****[S] pour passer … la suppression des traces de cacaoweb****
   echo                 **[Q] pour quitter CacaoSupervisor**
   %CHOOSE% -c SQR -d R -n -q -t R,5
       if errorlevel==3 goto :suitar
       if errorlevel==2 goto :endall
       if errorlevel==1 goto :navigateurok
   :suitar
   for /f "tokens=2 delims= " %%n in ('tasklist ^| findstr /i /c:"%barrette%"') do goto :mechano
   goto :navigateurok
) else (
   goto :batar
)

Rem erreur aucun navigateur trouv้ >>vers support
:batar
cls
%SHOWC% SHOW MAXIMIZED
mode con cols=75 lines=10
color 4F
cls
echo.
echo    Aucun navigateur par dfaut n'… t dtecte.
echo.
echo    Le logiciel ne peut pas surveiller la fermeture de votre navigateur.
echo    [   %navigator%   ] ** Si votre navigateur par dfaut est inscrit
echo    entre les crochets, cela signifie que le logiciel n'a pas russi
echo    … trouv le rpertoire du navigateur. Vous pouvez utiliser le menu
echo    de configuration via le menu principale de CacaoSupervisor.
echo    Appuyez sur [C] pour (Continuer) le processus du logiciel: Il effectura
echo    les oprations de dsinstallation de Cacaoweb. Donc si vous regardez
echo    un film, (Quitter) le logiciel, sinon celui-ci sera intrrompue.[Q].
echo    - Accedez au (Menu) principale via la touche [M].
set errorlevel=
%CHOOSE% -c CQM -p "  Quel est votre choix ?"
if errorlevel==3 goto :menureturn22
if errorlevel==2 goto :endall
if errorlevel==1 goto :navigateurok

rem V้rification de la pr้sence de cacaoweb, dans les processus et dans appdata
:navigateurok
color 08
REM - Le premier chiffre correspond เ la couleur de fond, et le second เ celui de premier plan :
REM 8 = Gris, 9 = Bleu, A = Vert, B = Cyan, C = Rouge, D = Rose, E = Jaune, F = Blanc 
REM 0 = Noir, 1 = Bleu fonc้, 2 = Vert, 3 = Bleu-gris, 4 = Marron, 5 = Pourpre, 6 = Kaki, 7 = Gris clair

cls
mode con cols=75 lines=8
cd "%APPDATA%\cacaoweb"
cls
if exist "%APPDATA%\cacaoweb" (
  goto :normalsuite
)else (
  goto :end2
)

:normalsuite
rem  Tue le processus
for /f "tokens=2 delims= " %%i in ('tasklist ^| findstr /i /c:"cacaoweb"') do @taskkill /T /F /PID %%i
cls
@taskkill /T /F /IM cacaoweb.exe > NUL
cls
rem roit et modifications
@takeown /f "%APPDATA%\cacaoweb"
cls
@Attrib -r -a -s -h -i "%APPDATA%\cacaoweb" /S /D
cls
rem efface les fichiers dans appdata
mode con cols=75 lines=8
set liste=%temp%\listeCSappData.txt
set lograpp=RapportCS.log
@takeown /f RapportCS.log
dir /A /B /O:GENDS /Q /R /T:CAW /W /4 "%APPDATA%\cacaoweb">%liste%
cls
rem heure et date
cmd /e:2000 /c for %%i in (1 2) do prompt set _t=$t$_ | find "$" /v >{t}.bat
for %%c in (call del) do %%c {t}.bat
cls
REM et CA LA DATE
cmd /e:2000 /c for %%i in (1 2) do prompt set _d=$d$_ | find "$" /v >{t}.bat
for %%c in (call del) do %%c {t}.bat
cls
cd %director%
cls
echo Le %_d% … %_t%, les actions suivantes ont t ffectues:>%lograpp%

tasklist | findstr /i "cacaoweb.exe" >nul
if errorlevel==1 echo Le processus "cacaoweb.exe" … t stopp.>>%lograpp%

    @takeown /f "%APPDATA%\cacaoweb\*.*"
    cls
    @Attrib -r "%APPDATA%\cacaoweb\*.*"
    cls
    @del /f /q "%APPDATA%\cacaoweb\*.*"
    cls
    ping 0.0.0.0 -n 2 > NUL

    @takeown /f "%APPDATA%\cacaoweb"
    cls
    @rd "%APPDATA%\cacaoweb" /s /q
    cls
if not exist "%APPDATA%\cacaoweb" (
    goto :oksamarch
) else (
    goto :nomarchpa
)

:oksamarch
echo Tout les fichiers ont bien ete supprimes:>>%lograpp%
type %liste%>>%lograpp%
goto :Boulebill
:nomarchpa
echo Tout les fichiers n'ont pas bien ete supprimes:>>%lograpp%
type %liste%>>%lograpp%
goto :Boulebill
:Boulebill
cls

Rem Supprime les cl้s de registre du d้marrage automatique de cacaoweb
echo.>>%lograpp%
reg delete "HKEY_CURRENT_USER\Software\cacaoweb" /f>>%lograpp%
cls
echo pour la clef de registre "HKEY_CURRENT_USER\Software\cacaoweb">>%lograpp%
cls
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v cacaoweb /f>>%lograpp%
cls
echo pour la clef de registre "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run">>%lograpp%
cls
goto realend

Rem Fin pas cacaoweb sur l'ordinateur
:end2
cls
mode con cols=75 lines=7
rem  Tue le processus au cas ou
for /f "tokens=2 delims= " %%i in ('tasklist ^| findstr /i /c:"cacaoweb"') do @taskkill /T /F /PID %%i
cls
@taskkill /T /F /IM cacaoweb.exe
cls
color F6
echo     ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo     บ    Le navigateur par dfaut est ferm...                   บÜ
echo     บ    Cacaoweb n'a pas t dtect dans le rpertoire AppData บÛ
echo     บ    Appuyez sur une touche pour quitter.                    บÛ
echo     ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผÛ
echo     ÿ ฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
pause >nul
color 02
goto :endall


:realend
mode con cols=78 lines=32
cls
color F6
echo.
echo   ÿษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปÜ
echo   ÿบ     Le navigateur est ferme:                                    บÛ
echo   ÿบ       -Le processus "Cacaoweb" … t stopp .                    บÛ
echo   ÿบ       -Les fichiers ont bien t effacs du rpertoire Appdata.  บÛ
echo   ÿบ       -Le registre … t nttoy.                                บÛ
echo   ÿศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผÛ
echo   ÿ ฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
echo.
echo.
echo                         ***RapportCS.log***
echo       (vous pouvez le consulter depuis le rpertoire du logiciel)
echo.
type "%lograpp%"
pause
goto :endall


:endall
mode con cols=15 lines=1
del /f /q %liste%
goto :megaend


Rem Justkill cacao -k
:cacaostop
%SHOWC% HIDE
for /f "tokens=2 delims= " %%i in ('tasklist ^| findstr /i /c:"cacaoweb"') do taskkill /T /F /PID %%i
taskkill /T /F /IM cacaoweb.exe
goto :megaend


Rem lancement nonav invisible
:invisinonav
%SHOWC% HIDE
goto :balrog

Rem lancement Just invisible
:invisible
%SHOWC% HIDE
goto :badur

Rem Just invisible + lancement cacao
:invisicacao
%SHOWC% HIDE

if exist "%configca%" (
          goto :stanley
) else (
          goto :machin
)

:machin
set app0="cacaoweb.exe"
set app1="%userprofile%\Desktop\cacaoweb.exe"
set app2="%appdata%\cacaoweb\cacaoweb.exe"


if exist "cacaoweb.exe" goto :beens
echo cacaoweb.exe non trouv dans le rpertoire du logiciel
cd "%userprofile%\Desktop"

if exist "%userprofile%\Desktop\cacaoweb.exe" goto :yourahh
echo cacaoweb.exe non trouv sur le bureau de %USERNAME%
cd "%appdata%\cacaoweb"

if exist "%appdata%\cacaoweb\cacaoweb.exe" goto :koli
echo cacaoweb.exe non trouv dans "%appdata%\cacaoweb\"

goto :raaah

Rem Demmarrage Cacaoweb
:beens
start "cacaoweb" %app0%
goto :ninet
:yourahh
start "cacaoweb" %app1%
goto :ninet
:koli
start "cacaoweb" %app2%
goto :ninet

Rem Aucun Navigateur trouv้...
:raaah
%SHOWC% SHOW MAXIMIZED
mode con cols=78 lines=18
color 4F
echo.
echo  Cacaoweb n'a pas pu tre trouv sur votre ordinateur...
echo  Par dfaut, CacaoSupervisor recherche Cacaoweb … ses emplacements possible
echo  qui sont:
echo   - Le rpertoire de CacaoSupervisor.
echo   - Le rpertoire "Bureau" de cette session.
echo   - Le rpertoire "utilisateur\AppData\Roaming\cacaoweb".
echo  ___________________________________________________________________________
echo.
echo   *** Vous avez la possibilit de (Configurer) votre propre rpertoire: ***
echo                 ***** Appuyez sur la touche [C]. *****
echo  ___________________________________________________________________________
echo.
echo  Pour (Quitter) le programme, pressez [Q].
echo  Pour (Ignorer) et passer … la suite, pressez [I],
echo       * N'oubliez pas de lancer Cacaoweb ! *
echo.
set errorlevel=
%CHOOSE% -c CQI -p "  Quel est votre choix ?"
if errorlevel==3 goto :NoParam
if errorlevel==2 goto :endall
if errorlevel==1 goto :configcacao


Rem param่tre perso du navigateur avex cacaoweb
:stanley
if exist "%confignav%" (
         goto :bidule
) else (
         goto :master
)

:master
Rem lancement Cacaoweb en lisant le fichier config !
for /f "tokens=2 delims=;" %%q in ('type %configca%') do set cacaoweb=%%q
if "%cacaoweb%"=="" (
             goto :yaka
) else (
             start "" "%cacaoweb%"
             goto :ninet
)


REM lancement auto config perso cacaoweb
:bidule
for /f "tokens=2 delims=;" %%r in ('type %confignav%') do set confignav22=%%r
if exist "%configpar%" (
           goto :avecpa
) else (
           goto :sanspa
)

:sanspa
for /f "tokens=2 delims=;" %%q in ('type %configca%') do set cacaoweb22=%%q
if "%cacaoweb22%"=="" (
             goto :yaka
) else (
             goto :pppo
)

:pppo
if "%confignav22%"=="" (
                 goto :yaka
) else (
                 goto :ooop
)
:ooop
start "Cacaoweb" %cacaoweb22% -noplayer
cls
echo  En attente du dmarrage de Cacaoweb...
ping 0.0.0.0 -n 7 >nul
start "Cacaoweb" "%confignav22%" http://local.cacaoweb.org:4001/
goto :kilmp



:avecpa
for /f "tokens=2 delims=;" %%x in ('type %configca%') do set cacaoweb33=%%x
if "%cacaoweb33%"=="" (
             goto :yaka
) else (
             goto :makmam
)

:makmam
if "%confignav22%"=="" (
                 goto :yaka
) else (
                 goto :biljlou
)
:biljlou
for /f "tokens=2 delims=;" %%r in ('type %configpar%') do set configpar22=%%r
if "%configpar22%"=="" (
                 goto :yaka
) else (
                 goto :deuz
)
:deuz
start "Cacaoweb" "%cacaoweb33%" -noplayer
cls
echo  En attente du dmarrage de Cacaoweb...
ping 0.0.0.0 -n 7 >nul
start "" "%confignav22%" http://local.cacaoweb.org:4001/ %configpar22%

:kilmp
REM TESTER LE LANCEMENT DE CACAOWEB AVEC CONFIG NAVIGATEUR
echo  Patientez... Le logiciel vrifie que Cacaoweb est bien lan.
ping 0.0.0.0 -n 3 >nul
cls
tasklist | findstr /i "cacaoweb.exe" >nul
if errorlevel==1 goto :urur
if errorlevel==0 goto :jjjk
:jjjk
echo  Cacaoweb … bien t trouv dans la liste des processus actifs...
goto :zizio
:urur
goto :yaka


:ninet
REM TESTER LE LANCEMENT DE CACAOWEB AVEC CONFIG REP CACAO
ping 0.0.0.0 -n 8 > nul
tasklist | findstr /i "cacaoweb.exe" >nul
if errorlevel==1 goto :durev
if errorlevel==0 goto :dupot
:dupot
echo  Cacaoweb … bien t trouv dans la liste des processus actifs...
goto :badur
:durev
goto  :yaka

REM CONFIG PERSO ERROR
:yaka
%SHOWC% SHOW MAXIMIZED
mode con cols=77 lines=25
color 4F
cls
echo.
echo Impossible de charger vos paramtres personnaliss...
echo Vrifiez la configuration s'il vous plat.
echo - Pressez [C] pour (Configurer) vos rpertoires et paramtres.
echo.
echo - Important 1: si Cacaoweb s'est correctement excut vous pouvez appuyer
echo sur [D] pour Poursuivre vers la (Dtection) du {navigateur par dfaut}.
echo - Important 2: si Cacaoweb s'est correctement excut dans votre
echo navigateur personnalis vous pouvez appuyer sur [P] pour (Poursuivre) vers
echo la dtection approprie.
echo.
echo - Pressez [L] pour lancer Cacaoweb depuis les rpertoires par dfauts qui
echo sont: Dans le dossier "appdata", le bureau, le rperoire de CacaoSupervisor.
echo Cela annulera le lancement avec votre navigateur personnalis.
echo.
echo - Pressez [S] pour (Supprimer) les fichiers de configurations, cela
echo remettra le logiciel par dfaut mais vous devrez reconfigurer vos
echo chemins de rpertoires et vos paramtres si vous voulez les rutiliser.
echo Ensuite le logiciel se fermera.
echo.
echo - Pressez [Q] pour (Quitter).
echo.
set errorlevel=
%CHOOSE% -c SCQLDP -p "  Quel est votre choix ?"
if errorlevel==6 goto :attentenavok
if errorlevel==5 goto :NoParam
if errorlevel==4 goto :defautcaca
if errorlevel==3 goto :endall
if errorlevel==2 goto :parameter
if errorlevel==1 goto :delcongig




REM TEST NAVIGATEUR LANCEMENT
:zizio
set navigator=PERSO

For /f "delims=." %%d in ('type "%confignav%"') do set moon=%%d
echo ^%moon% > tmpa.txt

for /f "tokens=15* delims=\" %%g in ('type "tmpa.txt"') do set barrette=%%g
if "%barrette%"=="" (
goto :mhhoro14
) else (
goto :bhhoullete
)

:mhhoro14
set barrette=
for /f "tokens=14* delims=\" %%g in ('type "tmpa.txt"') do set barrette=%%g
if "%barrette%"=="" (
goto :mhhoro13
) else (
goto :bhhoullete
)

:mhhoro13
set barrette=
for /f "tokens=13* delims=\" %%g in ('type "tmpa.txt"') do set barrette=%%g
if "%barrette%"=="" (
goto :mhhoro12
) else (
goto :bhhoullete
)

:mhhoro12
set barrette=
for /f "tokens=12* delims=\" %%g in ('type "tmpa.txt"') do set barrette=%%g
if "%barrette%"=="" (
goto :mhhoro11
) else (
goto :bhhoullete
)

:mhhoro11
set barrette=
for /f "tokens=11* delims=\" %%g in ('type "tmpa.txt"') do set barrette=%%g
if "%barrette%"=="" (
goto :mhhoro10
) else (
goto :bhhoullete
)

:mhhoro10
set barrette=
for /f "tokens=10* delims=\" %%g in ('type "tmpa.txt"') do set barrette=%%g
if "%barrette%"=="" (
goto :mhhoro9
) else (
goto :bhhoullete
)

:mhhoro9
set barrette=
for /f "tokens=9* delims=\" %%g in ('type "tmpa.txt"') do set barrette=%%g
if "%barrette%"=="" (
goto :mhhoro8
) else (
goto :bhhoullete
)

:mhhoro8
set barrette=
for /f "tokens=8* delims=\" %%g in ('type "tmpa.txt"') do set barrette=%%g
if "%barrette%"=="" (
goto :mhhoro7
) else (
goto :bhhoullete
)

:mhhoro7
set barrette=
for /f "tokens=7* delims=\" %%g in ('type "tmpa.txt"') do set barrette=%%g
if "%barrette%"=="" (
goto :mhhoro6
) else (
goto :bhhoullete
)

:mhhoro6
set bhharrette=
for /f "tokens=6* delims=\" %%g in ('type "tmpa.txt"') do set barrette=%%g
if "%barrette%"=="" (
goto :mhhoro5
) else (
goto :bhhoullete
)

:mhhoro5
set barrette=
for /f "tokens=5* delims=\" %%g in ('type "tmpa.txt"') do set barrette=%%g
if "%barrette%"=="" (
goto :mhhoro4
) else (
goto :bhhoullete
)

:mhhoro4
set barrette=
for /f "tokens=4* delims=\" %%g in ('type "tmpa.txt"') do set barrette=%%g
if "%barrette%"=="" (
goto :mhhoro3
) else (
goto :bhhoullete
)

:mhhoro3
set barrette=
for /f "tokens=3* delims=\" %%g in ('type "tmpa.txt"') do set barrette=%%g
if "%barrette%"=="" (
goto :mhhoro2
) else (
goto :bhhoullete
)

:mhhoro2
set barrette=
for /f "tokens=2* delims=\" %%g in ('type "tmpa.txt"') do set barrette=%%g
if "%barrette%"=="" (
goto :mhhoro1
) else (
goto :bhhoullete
)

:mhhoro1
set barrette=
for /f "tokens=1* delims=\" %%g in ('type "tmpa.txt"') do set barrette=%%g
if "%barrette%"=="" (
goto :nhhiak
) else (
goto :bhhoullete
)


Rem Navigateur trouv้ !!!
:bhhoullete
del /f /q tmpa.txt
set barrette=%barrette:~0,-1%
if "%navigator%"=="%navigator%" (
   for /f "tokens=2 delims= " %%i in ('tasklist ^| findstr /i /c:"%barrette%"') do goto :bhhonjour
   goto :nhhavigateurok
) else (
   goto :nhhiak
)
:bonjour
if "%navigator%"=="%navigator%" (
   ping 0.0.0.0 -n 30 > NUL
   for /f "tokens=2 delims= " %%i in ('tasklist ^| findstr /i /c:"%barrette%"') do goto :bhhonjour
   goto :nhhavigateurok
) else (
   goto :nhhiak
)

:nhhiak
%SHOWC% SHOW MAXIMIZED
mode con cols=75 lines=10
color 4F
cls
echo.
echo    Votre navigateur personnalis ne peut tre surveill...
echo.
echo    Appuyez sur [C] pour (Continuer) le processus du logiciel: Il effectura
echo    les oprations de dsinstallation de Cacaoweb. Donc si vous regardez
echo    un film, (Quitter) le logiciel, sinon celui-ci sera intrrompue.[Q].
echo    - Accedez au (Menu) principale via la touche [M].
%CHOOSE% -c CQM -p "  Quel est votre choix ?"
if errorlevel==3 goto :menureturn22
if errorlevel==2 goto :endall
if errorlevel==1 goto :navigateurok

REM MODE NORMAL DEBUT ENTIER
:yhhesmansay
ping 0.0.0.0 -n 10 > NUL
:badur
set navigator=
for /f "tokens=3* delims= " %%A in ('reg query "HKEY_CURRENT_USER\Software\Clients\StartMenuInternet"') do set navigator=%%B

color 06
if "%navigator%"=="FIREFOX.EXE" (
   for /f "tokens=2 delims= " %%i in ('tasklist ^| findstr /i /c:"firefox"') do goto :rhhetourfirefox
   goto :nhhavigateurok
) else (
   goto :ihhnternetexplorer
)
:rhhetourfirefox
color 02
if "%navigator%"=="FIREFOX.EXE" (
   ping 0.0.0.0 -n 30 > NUL
   for /f "tokens=2 delims= " %%i in ('tasklist ^| findstr /i /c:"firefox"') do goto :rhhetourfirefox
   goto :nhhavigateurok
) else (
   goto :ihhnternetexplorer
)

:ihhnternetexplorer
if "%navigator%"=="IEXPLORE.EXE" (
   for /f "tokens=2 delims= " %%i in ('tasklist ^| findstr /i /c:"iexplore"') do goto :internetexhhplorer
   goto :navigateurok
) else (
   goto :googlechrome1
)
:internetexhhplorer
color 02
if "%navigator%"=="IEXPLORE.EXE" (
   ping 0.0.0.0 -n 30 > NUL
   for /f "tokens=2 delims= " %%i in ('tasklist ^| findstr /i /c:"iexplore"') do goto :internetexhhplorer
   goto :nhhavigateurok
) else (
   goto :ghhooglechrome1
)

:ghhooglechrome1
if "%navigator%"=="Google Chrome" (
   for /f "tokens=2 delims= " %%i in ('tasklist ^| findstr /i /c:"chrome"') do goto :ghhooglechrome
   goto :nhhavigateurok
) else (
   goto :ohhpera1
)
:ghhooglechrome
color 02
if "%navigator%"=="Google Chrome" (
   ping 0.0.0.0 -n 30 > NUL
   for /f "tokens=2 delims= " %%i in ('tasklist ^| findstr /i /c:"chrome"') do goto :ghhooglechrome
   goto :nhhavigateurok
) else (
   goto :ohhpera1
)

:ohhpera1
if "%navigator%"=="Opera.exe" (
   for /f "tokens=2 delims= " %%i in ('tasklist ^| findstr /i /c:"opera"') do goto :ohhpera
   goto :nhhavigateurok
) else (
   goto :shhafari1
)
:ohhpera
color 02
if "%navigator%"=="Opera.exe" (
   ping 0.0.0.0 -n 30 > NUL
   for /f "tokens=2 delims= " %%i in ('tasklist ^| findstr /i /c:"opera"') do goto :ohhpera
   goto :nhhavigateurok
) else (
   goto :shhafari1
)

:shhafari1
if "%navigator%"=="Safari.exe" (
   for /f "tokens=2 delims= " %%i in ('tasklist ^| findstr /i /c:"safari"') do goto :shhafari
   goto :nhhavigateurok
) else (
   goto :ahhutres1
)
:shhafari
if "%navigator%"=="Safari.exe" (
   ping 0.0.0.0 -n 30 > NUL
   for /f "tokens=2 delims= " %%i in ('tasklist ^| findstr /i /c:"safari"') do goto :shhafari
   goto :nhhavigateurok
) else (
   goto :ahhutres1
)


:ahhutres1
FOR /F "tokens=3*" %%a IN ('REG QUERY "HKEY_CLASSES_ROOT\http\shell\open\command"') DO set oka=%%b
echo %oka% > tmp.txt
For /f "delims=." %%d in ('type "tmp.txt"') do set baj=%%d
echo ^%baj% > tmpa.txt
del /f /q "tmp.txt"

for /f "tokens=15* delims=\" %%g in ('type "tmpa.txt"') do set barrette=%%g
if "%barrette%"=="" (
goto :hhzod14
) else (
goto :hhoknav
)

:hhzod14
set barrette=
for /f "tokens=14* delims=\" %%g in ('type "tmpa.txt"') do set barrette=%%g
if "%barrette%"=="" (
goto :hhzod13
) else (
goto :hhoknav
)

:hhzod13
set barrette=
for /f "tokens=13* delims=\" %%g in ('type "tmpa.txt"') do set barrette=%%g
if "%barrette%"=="" (
goto :hhzod12
) else (
goto :hhoknav
)

:hhzod12
set barrette=
for /f "tokens=12* delims=\" %%g in ('type "tmpa.txt"') do set barrette=%%g
if "%barrette%"=="" (
goto :hhzod11
) else (
goto :hhoknav
)

:hhzod11
set barrette=
for /f "tokens=11* delims=\" %%g in ('type "tmpa.txt"') do set barrette=%%g
if "%barrette%"=="" (
goto :hhzod10
) else (
goto :hhoknav
)

:hhzod10
set barrette=
for /f "tokens=10* delims=\" %%g in ('type "tmpa.txt"') do set barrette=%%g
if "%barrette%"=="" (
goto :hhzod9
) else (
goto :hhoknav
)

:hhzod9
set barrette=
for /f "tokens=9* delims=\" %%g in ('type "tmpa.txt"') do set barrette=%%g
if "%barrette%"=="" (
goto :hhzod8
) else (
goto :hhoknav
)

:hhzod8
set barrette=
for /f "tokens=8* delims=\" %%g in ('type "tmpa.txt"') do set barrette=%%g
if "%barrette%"=="" (
goto :hhzod7
) else (
goto :hhoknav
)

:hhzod7
set barrette=
for /f "tokens=7* delims=\" %%g in ('type "tmpa.txt"') do set barrette=%%g
if "%barrette%"=="" (
goto :hhzod6
) else (
goto :hhoknav
)

:hhzod6
set barrette=
for /f "tokens=6* delims=\" %%g in ('type "tmpa.txt"') do set barrette=%%g
if "%barrette%"=="" (
goto :hhzod5
) else (
goto :hhoknav
)

:hhzod5
set barrette=
for /f "tokens=5* delims=\" %%g in ('type "tmpa.txt"') do set barrette=%%g
if "%barrette%"=="" (
goto :hhzod4
) else (
goto :hhoknav
)

:hhzod4
set barrette=
for /f "tokens=4* delims=\" %%g in ('type "tmpa.txt"') do set barrette=%%g
if "%barrette%"=="" (
goto :hhzod3
) else (
goto :hhoknav
)

:hhzod3
set barrette=
for /f "tokens=3* delims=\" %%g in ('type "tmpa.txt"') do set barrette=%%g
if "%barrette%"=="" (
goto :hhzod2
) else (
goto :hhoknav
)

:hhzod2
set barrette=
for /f "tokens=2* delims=\" %%g in ('type "tmpa.txt"') do set barrette=%%g
if "%barrette%"=="" (
goto :hhzod1
) else (
goto :hhoknav
)

:hhzod1
set barrette=
for /f "tokens=1* delims=\" %%g in ('type "tmpa.txt"') do set barrette=%%g
if "%barrette%"=="" (
goto :hhlola
) else (
goto :hhoknav
)


:hhoknav
set barrette=%barrette:~0,-1%
del /f /q "tmpa.txt"
color 06
cls
if "%navigator%"=="%navigator%" (
   for /f "tokens=2 delims= " %%n in ('tasklist ^| findstr /i /c:"%barrette%"') do goto :hhmechano
   goto :hhnavigateurok
) else (
   goto :hhbatar
)

:hhmechano
color 02
if "%navigator%"=="%navigator%" (
   ping 0.0.0.0 -n 30 > NUL
   for /f "tokens=2 delims= " %%n in ('tasklist ^| findstr /i /c:"%barrette%"') do goto :hhmechano
   goto :hhnavigateurok
) else (
   goto :hhbatar
)

:hhbatar
%SHOWC% SHOW MAXIMIZED
mode con cols=75 lines=10
color 4F
cls
echo.
echo    Aucun navigateur par dfaut n'… t dtecte.
echo.
echo    Le logiciel ne peut pas surveiller la fermeture de votre navigateur.
echo    [   %navigator%   ] ** Si votre navigateur par dfaut est inscrit
echo    entre les crochets, cela signifie que le logiciel n'a pas russi
echo    … trouv le rpertoire du navigateur. Vous pouvez utiliser le menu
echo    de configuration via le menu principale de CacaoSupervisor.
echo    Appuyez sur [C] pour (Continuer) le processus du logiciel: Il effectura
echo    les oprations de dsinstallation de Cacaoweb. Donc si vous regardez
echo    un film, (Quitter) le logiciel, sinon celui-ci sera intrrompue.[Q].
echo    - Accedez au (Menu) principale via la touche [M].
set errorlevel=
%CHOOSE% -c CQM -p "  Quel est votre choix ?"
if errorlevel==3 goto :menureturn22
if errorlevel==2 goto :endall
if errorlevel==1 goto :navigateurok

rem V้rification de la pr้sence de cacaoweb, dans les processus et dans appdata
:hhnavigateurok
:balrog
cd "%APPDATA%\cacaoweb"
if exist "%APPDATA%\cacaoweb" (
  goto :hhnormalsuite
)else (
  goto :hhend2
)

:hhnormalsuite
for /f "tokens=2 delims= " %%i in ('tasklist ^| findstr /i /c:"cacaoweb"') do @taskkill /T /F /PID %%i
@taskkill /T /F /IM cacaoweb.exe > NUL
ping 0.0.0.0 -n 2 > NUL

@takeown /f "%APPDATA%\cacaoweb"
@Attrib -r -a -s -h -i "%APPDATA%\cacaoweb" /S /D

set liste=%temp%\listeCSappData.txt
set lograpp=RapportCS.log
@takeown /f RapportCS.log
dir /A /B /O:GENDS /Q /R /T:CAW /W /4 "%APPDATA%\cacaoweb">%liste%

cmd /e:2000 /c for %%i in (1 2) do prompt set _t=$t$_ | find "$" /v >{t}.bat
for %%c in (call del) do %%c {t}.bat

cmd /e:2000 /c for %%i in (1 2) do prompt set _d=$d$_ | find "$" /v >{t}.bat
for %%c in (call del) do %%c {t}.bat
echo Le %_d% … %_t%, les actions suivantes ont t ffectues:>%lograpp%

tasklist | findstr /i "cacaoweb.exe" >nul
if errorlevel==1 echo Le processus "cacaoweb.exe" … t stopp.>>%lograpp%

    @takeown /f "%APPDATA%\cacaoweb\*.*"
    @Attrib -r "%APPDATA%\cacaoweb\*.*"
    @del /f /q "%APPDATA%\cacaoweb\*.*"
    ping 0.0.0.0 -n 2 > NUL

    @takeown /f "%APPDATA%\cacaoweb"
    @rd "%APPDATA%\cacaoweb" /s /q
if not exist "%APPDATA%\cacaoweb" (
    goto :hhoksamarch
) else (
    goto :hhnomarchpa
)

:hhoksamarch
echo Tout les fichiers ont bien ete supprimes:>>%lograpp%
type %liste%>>%lograpp%
goto :Boulebill
:hhnomarchpa
echo Tout les fichiers n'ont pas bien ete supprimes:>>%lograpp%
type %liste%>>%lograpp%

Rem Supprime les cl้s de registre du d้marrage automatique de cacaoweb
echo.>>%lograpp%
reg delete "HKEY_CURRENT_USER\Software\cacaoweb" /f>>%lograpp%
echo pour la clef de registre "HKEY_CURRENT_USER\Software\cacaoweb">>%lograpp%
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v cacaoweb /f>>%lograpp%
echo pour la clef de registre "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run">>%lograpp%
cls
goto :endall

:end2
for /f "tokens=2 delims= " %%i in ('tasklist ^| findstr /i /c:"cacaoweb"') do taskkill /T /F /PID %%i
taskkill /T /F /IM cacaoweb.exe
goto :endall

REM FIN INVISIBLE





REM MENU DE CONFIGURATION AVANCEE!
:parameter
color 4F
cls
mode con cols=75 lines=29
echo.
echo  ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo  บ  *Bienvenue dans le menu de configuration avane des rpertoires.*  บ
echo  บ                                                                      บ
echo  บ Deux choix s'offre … vous:                                           บ
echo  บ     -Paramtrer votre propre chemin menant au logiciel (Cacaoweb):   บ
echo  บ                      *** Appuyez sur [C] ***                         บ
echo  บ                                                                      บ
echo  บ   ATTENTION: POUR EFFECTUER L'OPERATION CI DESSOUS VOUS DEVEZ DEJA   บ
echo  บ   AVOIR DEFINIE UN EMPLACEMENT PERSONNALISE DE CACAOWEB. MEME SI     บ
echo  บ   CELUI-CI SE TROUVE DANS LES REPERTOIRES PREDEFFINIE.               บ
echo  บ     -Paramtrer votre propre chemin menant … votre (Navigateur),     บ
echo  บ      Ce qui permet donc d'utiliser n'importe quel navigateur.        บ
echo  บ      Vous avez aussi la possibilite d'inclure des paramtres        บ
echo  บ      de lancement. C'est … dire lorsque que vous lancer un           บ
echo  บ      navigateur personnalise avec des commandes bien prcises       บ
echo  บ      par exemple.    *** Appuyez sur [N] ***                         บ
echo  บ                                                                      บ
echo  บ     - Pressez [S] pour (Supprimer) les fichiers de configurations,   บ
echo  บ       cela remettra le logiciel par dfaut mais vous devrez          บ
echo  บ      reconfigurer vos chemins de rpertoires et vos paramtres via   บ
echo  บ      ce menu si vous voulez les rutiliser.                          บ
echo  บ      Ensuite le logiciel se fermera.                                 บ
echo  บ                                                                      บ
echo  บ                                                                      บ
echo  บ [R] pour (Retourner) au menu pricipale            [Q] pour (Quitter) บ
echo  ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
echo.
set errorlevel=
%CHOOSE% -c CNRQS -p "   Quel est votre choix ?"
if errorlevel==5 goto :delcongig
if errorlevel==4 goto :endall
if errorlevel==3 goto :menureturn22
if errorlevel==2 goto :confignav
if errorlevel==1 goto :configcacao

Rem Configuration du r้pertoire de Cacaoweb  CONFIGURATION AVANCEE
:configcacao
color 4F
cls
echo.
if exist %configca% (
         echo  *Le fichier de Configuration … t trouv.*
         goto :twotime
) else (
         echo  *Le fichier de configuration est absent...*
         goto :firstime
)

:errorfirstime
cls
echo  *** Recommencer *** Sinon CTRL+C ou cliquez sur la croix pour quitter.
goto :firstime

:returnfirstime

:firstime
mode con cols=78 lines=17
color 4F
echo.
echo    Vous allez maintenant saisir le chemin du rpertoire de Cacaoweb.
echo    Exemple de chemin:
echo     ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
echo     ณRepCacaoweb;D:\MonDossier Perso\Streaming\cacaoweb.exe;          ณ
echo     ณ                                                                 ณ
echo    CONSEIL: Dplacer-vous jusqu'au programme … l'aide de l'explorateur
echo    Windows. Ceci fait, regarder en haut de votre fentre, il s'y trouve
echo    une barre d'adrresse, elle sera compose de C:\ect..
echo    Slectionner ce qui se trouve … l'intrieur puis faites "clic droit"
echo    "copier".
echo    Revenez sur CacaoSupervisor et faites "clic droit" "coller" ci dessous.
echo.
SET /P configdir=Inscrivez le chemin complet du rpertoire de cacaoweb en respectant la casse :
echo RepCacaowe;%configdir%;>%configca%
if exist %configca% (
         cls
         echo.
         echo  *Le fichier de Configuration … bien t cre.*
         ping 0.0.0.0 -n 2 > NUL
         goto :twotimebef
) else (
         echo  *Le fichier de configuration est toujours absent...*
         ping 0.0.0.0 -n 2 > NUL
         goto :errorfirstime
)

:twotimebef
cls

:twotime
mode con cols=77 lines=24
color 4F
echo.
echo      ** Configuration du rpertoire … l'emplacement de Cacaoweb: **
echo   -Pour (Modifier) le chemin du rpertoire de Cacaoweb appuyez sur [M]
echo.
echo   INFO: Le fichier de configuration 'configca.txt' se trouve dans le mme
echo   rpertoire que CacaoSupervisor. Vous pouvez le modifier directement
echo   sans passer par ce menu:
echo   Appuyez sur [O] pour (Ouvrir) votre fichier 'config.txt', placer le
echo   chemin du rpertoire entre 'RepCacaoweb;' et ';' sur la premire ligne.
echo   Exemple:
echo     ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
echo     ณRepCacaoweb;D:\MonDossier Perso\Streaming\cacaoweb.exe;          ณ
echo     ณ                                                                 ณ
echo   Attention, vous ne devez pas confonfondre le rpertoire {Cacaoweb} et
echo   le nom du logiciel {Cacaoweb.exe}. Si le rpertoire o— se trouve
echo   Cacaoweb.exe se nomme XXXXX peu importe, il faudra donc crire … la fin
echo   'XXXXX' {dans l'exemple c'est "Streaming"} et non pas 'Cacaoweb.exe'.
echo.
echo   -Pour [Configurer] les rpertoires [C].
echo   -Pour (Poursuivre) vers la dtection du navigateur appuyez sur [P].
echo   -Pour (Quitter) le programme, pressez la touche [Q].
echo   -Pour (Lancer) Cacaoweb appuyez sur [L].
echo.
set errorlevel=
%CHOOSE% -c MOPQLC -p "   Quel est votre choix ?"
if errorlevel==6 goto :parameter
if errorlevel==5 goto :cacaomod
if errorlevel==4 goto :endall
if errorlevel==3 goto :NoParam
if errorlevel==2 goto :openconfig
if errorlevel==1 goto :returnfirstime

Rem  Ouverture du fichier de Configuration
:openconfig
if not exist "%configca%" echo RepCacaoweb;"Ecrivez votre chemin ici,sans les guillemets";>%configca%
%configca%
cls
goto :twotime





REM CONFIGURATION DU NAVIGATEUR
:confignav
color 4F
cls
mode con cols=77 lines=28
:bostem
cls
echo.
echo    *** Menu de configuration du rpertoire et paramtres navigateur ***
echo    Mme chose que pour le rpertoire de Cacaoweb, vous pouvez dfinir les
echo    rpertoires sans passer par ce menu, directement depuis le dossier
echo    du logiciel. (Dossier configCS)
echo    Rappelez-vous, "RepNavigateur;", "Paranav;" et les ";" sont Obligatoire.
echo    mme le dernier ";".
echo    Exemple pour le fichier confignav:
echo      ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
echo      ณRepNavigateur;D:\MonDossier Perso\Streaming\navigateur.exe;      ณ
echo      ณ                                                                 ณ
echo    et pour le fichier configpar:
echo      ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
echo      ณParanav;-p "BOUBLI";                                             ณ
echo      ณ                                                                 ณ
echo.   ATTENTION: VOUS DEVEZ DEJA AVOIR DEFINIE UN EMPLACEMENT PERSONALISEE
echo    POUR CACAOWEB !
echo    - Pour modifier le chemin du (Rpertoire) du Navigateur, pressez [R].
echo    Auppyez sur [O] pour ouvrir le fichier de configuration pour y inserer
echo    le rpertoire du navigateur.
echo    [T] pour tester le lancement du navigateur.
echo.
echo    - Pour modifier les (Paramtres) de lancements du navigateur,
echo    pressez la touche [P].
echo.
echo    - Pour retourner au (Menu), pressez la touche [M]
echo    - Pour (Quitter) CacaoSupervisor, pressez la touche [Q]
echo.
set errorlevel=
%CHOOSE% -c RPMQTO -p "   Quel est votre choix ?"
if errorlevel==6 goto :testerer
if errorlevel==5 goto :opcour
if errorlevel==4 goto :endall
if errorlevel==3 goto :parameter
if errorlevel==2 goto :modifpara
if errorlevel==1 goto :modifrepert
:testerer
if not exist "%confignav%" echo RepNavigateur;"Ecrivez votre chemin ici,sans les guillemets";>%confignav%
%confignav%
cls
goto :bostem

:opcour
if not exist "%confignav%" goto :confignav
for /f "tokens=2 delims=;" %%r in ('type %confignav%') do set confignavtest=%%r
for /f "tokens=2 delims=;" %%r in ('type %configpar%') do set configpartest=%%r
start "" "%confignavtest%" %configpartest%
goto :confignav

:errorbacktime
echo Impossible de crer le fichier de configuration du navigateur
goto :botobot
Rem modification du r้pertoire du navigateur
:modifrepert
color 4F
cls
mode con cols=78 lines=15
:botobot
echo.
echo      ** Configuration du rpertoire … l'emplacement du Navigateur: **
echo      Saisissez le chemin complet inclus "mon navigateur.exe"
echo      Exemple:
echo          C:\Program Perso\Navigateur Scuris\mon navigateur.exe
echo.
SET /P configdirb=Inscrivez le chemin complet du rpertoire du cacaoweb en respectant la casse :
echo RepNavigateur;%configdirb%;>%confignav%

if exist "%confignav%" (
         echo.
         echo  *Le fichier de Configuration … bien t cre.*
         ping 0.0.0.0 -n 2 > NUL
         goto :bostem
) else (
         echo  *Le fichier de configuration est toujours absent...*
         ping 0.0.0.0 -n 2 > NUL
         goto :errorbacktime
)

:errorbacktime2
echo Impossible de crer le fichier de configuration des paramtres.
goto :boromir

Rem modification des param่tres navigateur:
:modifpara
color 4F
cls
:boromir
mode con cols=78 lines=15
echo.
echo     ** Configuration des paramtres du navigateur personnel **
echo     Saisissez les paramtres de lancement du navigateur
echo     Exemple:
echo            -p "Prive" -s
echo.
echo     Les paramtres servent si vous voulez lancer votre navigateur
echo     avec des paramtres bien particuliers...
echo     Par exemple le navigateur Firefox dipose d'une options de lancement
echo     sur diffrents profiles.
echo.
SET /P configdirc=Inscrivez le chemin complet des paramtres en respectant la casse :
echo Paranav;%configdirc%;>%configpar%

if exist "%configpar%" (
         cls
         echo.
         echo  *Le fichier de Configuration … bien t cre.*
         ping 0.0.0.0 -n 2 > NUL
         goto :bostem
) else (
         echo  *Le fichier de configuration est toujours absent...*
         ping 0.0.0.0 -n 2 > NUL
         goto :errorbacktime2
)


REM DELETE CONFIG

:delcongig
mode con cols=70 lines=10
%SHOWC% SHOW MAXIMIZED
title= Rinitialisation de %nomlog% v%verlog%
color 4f
@takeown /f %configca%
@takeown /f %configca%
@takeown /f %configpar%
@del /f /q %configca%
@del /f /q %confignav%
@del /f /q %configpar%
echo Vrifiez que le fichiers suit ont bien t ffas dans le
echo rpertoire ConfigCS: configca.txt, confignav.txt, configpar.txt
pause
goto :megaend

REM MENU AIDE
:help
cls
color F8
mode con cols=71 lines=41
echo   ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo   บ                                                                 บ
echo   บ       Bienvenue dans le menu d'aide de Cacaosupervisor          บ
echo   บ                                                                 บ
echo   ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
echo.
echo               ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
echo               ณ Fichier Aide 1: Informations gnrales ณ
echo               ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
echo.
echo    - Qu'est-ce CacaoSupervisor.
echo    - Diffrentes dfinitions du vocabulaire employ.
echo    - A propos de Shownconsole.exe, Choose32.exe et txtcolor.exe
echo.
echo       ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
echo       ณ     Fichier Aide 2: Les diffrents mode du logiciel     ณ
echo       ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
echo.
echo    - Quels sont les diffrents modes de lancement en dtail.
echo    - Comment utiliser les diffrents modes.
echo.
echo    ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
echo    ณ Fichier Aide 3: Utilisation de la configuration personnalise ณ
echo    ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
echo.
echo    - Comment utiliser la configuration personnalise des rpertoires
echo    et exemples d'utilisation.
echo    - Je n'arrive plus … utilser CacaoSupervisor lorsque je le lance
echo    en mode "Lancement automatique de Cacaoweb".
echo.
echo                    ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
echo                    ณ Licence de CacaoSupervisor ณ
echo                    ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
echo    INFO: Les fichiers d'aide se trouve aussi dans le rpertoire de
echo    CacaoSupervisor sous le dossier "AideCS".
echo.
echo            Pour aide et suggestion: benjahinfo@laposte.net
set errorlevel=
%CHOOSE% -c 123LQM -p " Quel est votre choix ? [L]icence [Q]uitter [M]enu principale"
echo %errorlevel%
if errorlevel==7 goto :endall
if errorlevel==6 goto :menureturn22
if errorlevel==5 goto :endall
if errorlevel==4 goto :oplicence
if errorlevel==3 goto :opaidecs3
if errorlevel==2 goto :opaidecs2
if errorlevel==1 goto :opaidecs1

:oplicence
"%licence%"
cls
goto :help
:opaidecs1
"%aide1%"
cls
goto :help
:opaidecs2
"%aide2%"
cls
goto :help
:opaidecs3
"%aide3%"
cls
goto :help

:manager
color F2
mode con cols=72 lines=35
cls
echo.
echo  ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo  บ                                                                 บ
echo  บ      Bienvenue dans le menu du gestionnaire de profils          บ
echo  บ                                                                 บ
echo  ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
echo.
echo  IMPORTANT SI C'EST LA PREMIERE FOIS QUE VOUS UTILISEZ LE GESTIONNAIRE
echo  POUR CHAQUES FOIS QUE VOUS VOULEZ CREER UN NOUVEAU PROFIL:
echo.
echo   1-Vous devez d'abord avoir crer une fois les fichiers de configura-
echo  tions, si ce n'est pas le cas, appuyez sur [M] pour aller au menu de
echo  configuration des rpertoires personnaliss (Pour CHAQUES nouveau
echo  profils).
echo              2-Ceci fait crer les profils en appuyant sur:
echo           -la touche [A] pour le profil 1
echo              -la touche [B] pour le profil 2
echo                 -la touche [C] pour le profil 3
echo.
echo              ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
echo              ณ TOUCHE 1: UTILISER LE PROFIL NUMERO 1 ณ
echo              ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
echo.
echo              ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
echo              ณ TOUCHE 2: UTILISER LE PROFIL NUMERO 2 ณ
echo              ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
echo.
echo              ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
echo              ณ TOUCHE 3: UTILISER LE PROFIL NUMERO 3 ณ
echo              ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
echo.
set errorlevel=
%CHOOSE% -c 123MAQMBC -p " Quel est votre choix ? [Q]uitter [M]enu principale"
if errorlevel==9 goto :blouz
if errorlevel==8 goto :acta
if errorlevel==7 goto :menureturn22
if errorlevel==6 goto :endall
if errorlevel==5 goto :activation
if errorlevel==4 goto :parameter
if errorlevel==3 goto :matree
if errorlevel==2 goto :mantwo
if errorlevel==1 goto :manaone

:activation
@takeown /f "configCS\profiloffCS\ProfilCS1\configca.txt"
@takeown /f "configCS\profiloffCS\ProfilCS1\confignav.txt"
@takeown /f "configCS\profiloffCS\ProfilCS1\configpar.txt"
if exist "configCS\profiloffCS\ProfilCS1\configca.txt" del /f /q "configCS\profiloffCS\ProfilCS1\configca.txt"
if exist "configCS\profiloffCS\ProfilCS1\confignav.txt" del /f /q "configCS\profiloffCS\ProfilCS1\confignav.txt"
if exist "configCS\profiloffCS\ProfilCS1\configpar.txt" del /f /q "configCS\profiloffCS\ProfilCS1\configpar.txt"
if exist "%configca%" copy /y "%configca%" "configCS\profiloffCS\ProfilCS1"
if exist "%confignav%" copy /y "%confignav%" "configCS\profiloffCS\ProfilCS1"
if exist "%configpar%" copy /y "%configpar%" "configCS\profiloffCS\ProfilCS1"
cls
echo Les fichiers suivants sont prsents dans configCS\profiloffCS\ProfilCS1:
dir /A /B /O:GENDS /Q /R /T:CAW /W /4 "configCS\profiloffCS\ProfilCS1"
echo.
pause
goto :manager

:acta
@takeown /f "configCS\profiloffCS\ProfilCS1\configca.txt"
@takeown /f "configCS\profiloffCS\ProfilCS1\confignav.txt"
@takeown /f "configCS\profiloffCS\ProfilCS1\configpar.txt"
if exist "configCS\profiloffCS\ProfilCS2\configca.txt" del /f /q "configCS\profiloffCS\ProfilCS2\configca.txt"
if exist "configCS\profiloffCS\ProfilCS2\confignav.txt" del /f /q "configCS\profiloffCS\ProfilCS2\confignav.txt"
if exist "configCS\profiloffCS\ProfilCS2\configpar.txt" del /f /q "configCS\profiloffCS\ProfilCS2\configpar.txt"
if exist "%configca%" copy /y "%configca%" "configCS\profiloffCS\ProfilCS2"
if exist "%confignav%" copy /y "%confignav%" "configCS\profiloffCS\ProfilCS2"
if exist "%configpar%" copy /y "%configpar%" "configCS\profiloffCS\ProfilCS2"
cls
echo Les fichiers suivants sont prsents dans configCS\profiloffCS\ProfilCS2:
dir /A /B /O:GENDS /Q /R /T:CAW /W /4 "configCS\profiloffCS\ProfilCS2"
echo.
pause
goto :manager

:blouz
@takeown /f "configCS\profiloffCS\ProfilCS3\configca.txt"
@takeown /f "configCS\profiloffCS\ProfilCS3\confignav.txt"
@takeown /f "configCS\profiloffCS\ProfilCS3\configpar.txt"
if exist "configCS\profiloffCS\ProfilCS3\configca.txt" del /f /q "configCS\profiloffCS\ProfilCS3\configca.txt"
if exist "configCS\profiloffCS\ProfilCS3\confignav.txt" del /f /q "configCS\profiloffCS\ProfilCS3\confignav.txt"
if exist "configCS\profiloffCS\ProfilCS3\configpar.txt" del /f /q "configCS\profiloffCS\ProfilCS3\configpar.txt"
if exist "%configca%" copy /y "%configca%" "configCS\profiloffCS\ProfilCS3"
if exist "%confignav%" copy /y "%confignav%" "configCS\profiloffCS\ProfilCS3"
if exist "%configpar%" copy /y "%configpar%" "configCS\profiloffCS\ProfilCS3"
cls
echo Les fichiers suivants sont prsents dans configCS\profiloffCS\ProfilCS3:
dir /A /B /O:GENDS /Q /R /T:CAW /W /4 "configCS\profiloffCS\ProfilCS3"
echo.
pause
goto :manager

:manaone
@takeown /f %configca%
@takeown /f %configca%
@takeown /f %configpar%
@del /f /q %configca%
@del /f /q %confignav%
@del /f /q %configpar%
if exist "configCS\profiloffCS\ProfilCS1\configca.txt" copy /y "configCS\profiloffCS\ProfilCS1\configca.txt" "configCS"
if exist "configCS\profiloffCS\ProfilCS1\confignav.txt" copy /y "configCS\profiloffCS\ProfilCS1\confignav.txt" "configCS"
if exist "configCS\profiloffCS\ProfilCS1\configpar.txt" copy /y "configCS\profiloffCS\ProfilCS1\configpar.txt" "configCS"
cls
echo  La configuration suivante … t applique [Profil 1]:
if exist "%configca%" type %configca%
if exist "%confignav%" type %confignav%
if exist "%configpar%" type %configpar%
pause
cls
goto :manager

:mantwo
@takeown /f %configca%
@takeown /f %configca%
@takeown /f %configpar%
@del /f /q %configca%
@del /f /q %confignav%
@del /f /q %configpar%
if exist "configCS\profiloffCS\ProfilCS2\configca.txt" copy /y "configCS\profiloffCS\ProfilCS2\configca.txt" "configCS"
if exist "configCS\profiloffCS\ProfilCS2\confignav.txt" copy /y "configCS\profiloffCS\ProfilCS2\confignav.txt" "configCS"
if exist "configCS\profiloffCS\ProfilCS2\configpar.txt" copy /y "configCS\profiloffCS\ProfilCS2\configpar.txt" "configCS"
cls
echo  La configuration suivante … t applique [Profil 2]:
if exist "%configca%" type %configca%
if exist "%confignav%" type %confignav%
if exist "%configpar%" type %configpar%
pause
cls
goto :manager

:matree
@takeown /f %configca%
@takeown /f %configca%
@takeown /f %configpar%
@del /f /q %configca%
@del /f /q %confignav%
@del /f /q %configpar%
if exist "configCS\profiloffCS\ProfilCS3\configca.txt" copy /y "configCS\profiloffCS\ProfilCS3\configca.txt" "configCS"
if exist "configCS\profiloffCS\ProfilCS3\confignav.txt" copy /y "configCS\profiloffCS\ProfilCS3\confignav.txt" "configCS"
if exist "configCS\profiloffCS\ProfilCS3\configpar.txt" copy /y "configCS\profiloffCS\ProfilCS3\configpar.txt" "configCS"
cls
echo  La configuration suivante … t applique [Profil 3]:
if exist "%configca%" type %configca%
if exist "%confignav%" type %confignav%
if exist "%configpar%" type %configpar%
pause
cls
goto :manager


:benjamin
@takeown /f %configca%
@takeown /f %configca%
@takeown /f %configpar%
@del /f /q %configca%
@del /f /q %confignav%
@del /f /q %configpar%
if exist "configCS\profiloffCS\ProfilCS1\configca.txt" copy /y "configCS\profiloffCS\ProfilCS1\configca.txt" "configCS"
if exist "configCS\profiloffCS\ProfilCS1\confignav.txt" copy /y "configCS\profiloffCS\ProfilCS1\confignav.txt" "configCS"
if exist "configCS\profiloffCS\ProfilCS1\configpar.txt" copy /y "configCS\profiloffCS\ProfilCS1\configpar.txt" "configCS"
cls
echo  La configuration suivante … t applique [Profil 1]:
if exist "%configca%" type %configca%
if exist "%confignav%" type %confignav%
if exist "%configpar%" type %configpar%
goto :cacaomod

:marine
@takeown /f %configca%
@takeown /f %configca%
@takeown /f %configpar%
@del /f /q %configca%
@del /f /q %confignav%
@del /f /q %configpar%
if exist "configCS\profiloffCS\ProfilCS2\configca.txt" copy /y "configCS\profiloffCS\ProfilCS2\configca.txt" "configCS"
if exist "configCS\profiloffCS\ProfilCS2\confignav.txt" copy /y "configCS\profiloffCS\ProfilCS2\confignav.txt" "configCS"
if exist "configCS\profiloffCS\ProfilCS2\configpar.txt" copy /y "configCS\profiloffCS\ProfilCS2\configpar.txt" "configCS"
cls
echo  La configuration suivante … t applique [Profil 2]:
if exist "%configca%" type %configca%
if exist "%confignav%" type %confignav%
if exist "%configpar%" type %configpar%
goto :cacaomod

:evelyne
@takeown /f %configca%
@takeown /f %configca%
@takeown /f %configpar%
@del /f /q %configca%
@del /f /q %confignav%
@del /f /q %configpar%
if exist "configCS\profiloffCS\ProfilCS3\configca.txt" copy /y "configCS\profiloffCS\ProfilCS3\configca.txt" "configCS"
if exist "configCS\profiloffCS\ProfilCS3\confignav.txt" copy /y "configCS\profiloffCS\ProfilCS3\confignav.txt" "configCS"
if exist "configCS\profiloffCS\ProfilCS3\configpar.txt" copy /y "configCS\profiloffCS\ProfilCS3\configpar.txt" "configCS"
cls
echo  La configuration suivante … t applique [Profil 3]:
if exist "%configca%" type %configca%
if exist "%confignav%" type %confignav%
if exist "%configpar%" type %configpar%
goto :cacaomod

Rem Aide sur les commandes
:command
mode con cols=78 lines=46
cls
echo.
echo Les options de lancement de CacaoSupervisor sont nombreuses;
echo Si vous dsirez en savoir plus, consulter le menu aide via le menu
echo principale.
echo.
echo    Voici les options de lancement:
echo CacaoSupervisor.exe -d
echo Pour supprimer et stopper cacaoweb directement sans dtection du navigateur.
echo.
echo CacaoSupervisor.exe -c
echo Dtecte si Cacaoweb est dja lan, sinon le lance, peut utiliser des
echo rpertoires personnels.
echo.
echo CacaoSupervisor.exe -i
echo Mode normal en tche de fond.
echo.
echo CacaoSupervisor.exe -q
echo Mode avec lancement Cacaoweb, en tche de fond
echo.
echo CacaoSupervisor.exe -s
echo Supprime et arrete Cacaoweb, en tche de fond.
echo.
echo CacaoSupervisor.exe -k
echo Tue le processus de Cacaoweb.
echo.
echo CacaoSupervisor.exe -m
echo Menu principale de CacaoSupervisor.
echo.
echo CacaoSupervisor.exe -j
echo Menu de configuration des rpertoires personnaliss.
echo.
echo CacaoSupervisor.exe -delete
echo Pour supprimer tout les fichiers de configurations perso..
echo.
echo CacaoSupervisor.exe -p
echo Gestionnaire de profils; -p1 ou -p2 ou -p3 lance spcifiquement les
echo profils 1,2 ou 3, avec Cacaosupervisor en mode de lancement automatique
echo de Cacaoweb.
echo.
echo CacaoSupervisor.exe -help
echo Aide de CacaoSupervisor (et licence).
echo.
echo CacaoSupervisor.exe -h
echo Affiche cette page.
pause
goto :menureturn22

Rem focntionne pas no NT
:NT926
cls
echo Fonctionne que sous environement x86 et compatible x64 (NT).
echo Utilisation de processus win32.
pause
goto :megaend


:megaend
echo on
