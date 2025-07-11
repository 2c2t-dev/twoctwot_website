# Script PowerShell pour corriger les warnings withOpacity vers withValues
$projectPath = "c:\Users\ZipName\Documents\GitHub\twoctwot_website"

# Trouver tous les fichiers Dart
$dartFiles = Get-ChildItem -Path $projectPath -Recurse -Filter "*.dart" | Where-Object { $_.DirectoryName -notlike "*\.dart_tool*" }

$totalReplacements = 0

foreach ($file in $dartFiles) {
    $content = Get-Content $file.FullName -Raw
    
    if ($content -match "\.withOpacity\(") {
        Write-Host "Traitement du fichier: $($file.FullName)"
        
        # Remplacer .withOpacity( par .withValues(alpha: 
        $newContent = $content -replace "\.withOpacity\(([^)]+)\)", '.withValues(alpha: $1)'
        
        # Compter les remplacements dans ce fichier
        $matches = [regex]::Matches($content, "\.withOpacity\(")
        $replacements = $matches.Count
        $totalReplacements += $replacements
        
        if ($replacements -gt 0) {
            Set-Content -Path $file.FullName -Value $newContent -NoNewline
            Write-Host "  -> $replacements remplacement(s) effectué(s)"
        }
    }
}

Write-Host ""
Write-Host "Correction terminée ! Total: $totalReplacements remplacements."
Write-Host "Exécution de flutter analyze pour vérifier..."
