# Script pour corriger les TextStyle const avec des valeurs dynamiques
$files = Get-ChildItem -Path "lib" -Recurse -Filter "*.dart"

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    $changed = $false
    
    # Remplacer const TextStyle avec des propriétés dynamiques par TextStyle simple
    # Recherche des patterns comme color: variable, fontSize: variable, etc.
    if ($content -match "const TextStyle\([^)]*\b(color|fontSize|fontWeight):\s*[a-zA-Z_][a-zA-Z0-9_]*(\.[a-zA-Z_][a-zA-Z0-9_]*)*[^),]*\)") {
        # Supprimer const devant TextStyle quand il y a des propriétés dynamiques
        $content = $content -replace "const TextStyle\(([^)]*\b(?:color|fontSize|fontWeight):\s*[a-zA-Z_][a-zA-Z0-9_]*(?:\.[a-zA-Z_][a-zA-Z0-9_]*)*[^),]*[^)]*)\)", "TextStyle(`$1)"
        $changed = $true
    }
    
    if ($changed) {
        $content | Set-Content $file.FullName -NoNewline
        Write-Host "Correction des const dans $($file.FullName)"
    }
}

Write-Host "Correction des const terminée !"
