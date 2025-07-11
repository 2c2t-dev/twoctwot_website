# Script pour remplacer GoogleFonts par TextStyle dans main_layout.dart
$filePath = "lib\shared\presentation\widgets\main_layout.dart"

# Lire le contenu du fichier
$content = Get-Content $filePath -Raw

# Remplacements
$content = $content -replace "GoogleFonts\.jetBrainsMono\(\)", "const TextStyle(fontFamily: 'JetBrains Mono, Monaco, Consolas, monospace')"
$content = $content -replace "GoogleFonts\.jetBrainsMono\(\s*fontSize:\s*(\d+),?\s*\)", "const TextStyle(fontFamily: 'JetBrains Mono, Monaco, Consolas, monospace', fontSize: `$1)"
$content = $content -replace "GoogleFonts\.jetBrainsMono\(\s*fontWeight:\s*(FontWeight\.\w+),?\s*\)", "const TextStyle(fontFamily: 'JetBrains Mono, Monaco, Consolas, monospace', fontWeight: `$1)"
$content = $content -replace "GoogleFonts\.jetBrainsMono\(\s*fontSize:\s*(\d+),\s*fontWeight:\s*(FontWeight\.\w+),?\s*\)", "const TextStyle(fontFamily: 'JetBrains Mono, Monaco, Consolas, monospace', fontSize: `$1, fontWeight: `$2)"
$content = $content -replace "GoogleFonts\.jetBrainsMono\(\s*fontWeight:\s*(FontWeight\.\w+),\s*fontSize:\s*(\d+),?\s*\)", "const TextStyle(fontFamily: 'JetBrains Mono, Monaco, Consolas, monospace', fontWeight: `$1, fontSize: `$2)"

# Sauvegarder le fichier
$content | Set-Content $filePath -NoNewline

Write-Host "Remplacement terminé dans $filePath"
