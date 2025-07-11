# Script pour remplacer toutes les références GoogleFonts dans le projet
$files = Get-ChildItem -Path "lib" -Recurse -Filter "*.dart"

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    $changed = $false
    
    # Supprimer les imports google_fonts
    if ($content -match "import 'package:google_fonts/google_fonts.dart';") {
        $content = $content -replace "import 'package:google_fonts/google_fonts.dart';\r?\n", ""
        $changed = $true
    }
    
    # Remplacer GoogleFonts.jetBrainsMono par TextStyle avec police système
    if ($content -match "GoogleFonts\.jetBrainsMono\(") {
        $content = $content -replace "GoogleFonts\.jetBrainsMono\(", "const TextStyle(fontFamily: 'JetBrains Mono, Monaco, Consolas, monospace',"
        $changed = $true
    }
    
    # Remplacer GoogleFonts.museoModerno par TextStyle avec police système
    if ($content -match "GoogleFonts\.museoModerno\(") {
        $content = $content -replace "GoogleFonts\.museoModerno\(", "const TextStyle(fontFamily: 'MuseoModerno, Impact, Arial Black, sans-serif',"
        $changed = $true
    }
    
    if ($changed) {
        $content | Set-Content $file.FullName -NoNewline
        Write-Host "Mise à jour de $($file.FullName)"
    }
}

Write-Host "Remplacement terminé !"
