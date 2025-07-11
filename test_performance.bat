@echo off
echo ================================================
echo  Test de performance - 2c2t.dev Matrix
echo ================================================
echo.
echo Version actuelle: Ultra-Light (0%% CPU garanti)
echo Fichiers d'arrière-plan nettoyes: OK
echo.
echo Compilation et lancement...
flutter run -d chrome --web-renderer html --web-port 3000 --release
echo.
echo Si vous voyez encore de la consommation CPU:
echo 1. Verifiez les DevTools Chrome ^(F12 ^> Performance^)
echo 2. Le probleme peut venir d'autres elements de la page
echo 3. Changez vers "minimal" dans matrix_background_config.dart
pause
