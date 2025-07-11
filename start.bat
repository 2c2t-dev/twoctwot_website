@echo off
echo 🚀 Lancement du site 2c2t.dev - Matrix Background Ultra-Light (0% CPU)...
echo.

REM Vérifier si Flutter est installé
flutter --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Flutter n'est pas installé ou pas dans le PATH
    pause
    exit /b 1
)

REM Installation des dépendances
echo 📦 Installation des dépendances...
flutter pub get

REM Lancement du serveur de développement
echo 🌐 Lancement du serveur web sur http://localhost:8080
echo.
echo 💡 Tip: Le site va s'ouvrir automatiquement dans votre navigateur
echo 💡 Appuyez sur 'r' dans le terminal pour hot reload
echo 💡 Appuyez sur 'q' pour quitter
echo.

flutter run -d chrome --web-port=8080

pause
