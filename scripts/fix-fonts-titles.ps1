# Script PowerShell pour corriger les polices sur les titres
# Remplace JetBrains Mono par MuseoModerno sur les titres et éléments de navigation

$files = Get-ChildItem -Path "lib" -Recurse -Filter "*.dart"

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    $modified = $false
    
    # Patterns pour identifier les titres à modifier avec MuseoModerno
    $titlePatterns = @(
        # Titres principaux des pages
        "style: const TextStyle\(fontFamily: 'JetBrains Mono[^']*',\s*fontSize: (48|44|36|32|28|24),",
        # Headers et navigation
        "style: const TextStyle\(fontFamily: 'JetBrains Mono[^']*',\s*fontSize: (20|18|16),\s*fontWeight: FontWeight\.bold",
        # Sous-titres importants
        "style: const TextStyle\(fontFamily: 'JetBrains Mono[^']*',\s*fontSize: (18|16),\s*fontWeight: FontWeight\.w600"
    )
    
    foreach ($pattern in $titlePatterns) {
        if ($content -match $pattern) {
            $content = $content -replace "fontFamily: 'JetBrains Mono[^']*'", "fontFamily: 'MuseoModerno'"
            $modified = $true
            Write-Host "Modified title fonts in: $($file.FullName)" -ForegroundColor Green
        }
    }
    
    # Remplacements spécifiques pour les éléments de navigation et titres identifiés
    $replacements = @{
        # Titres de sections principales
        "Text\(\s*'(Nos Projets|Notre Équipe|À Propos|Contact|Projets|Équipe|Technologies|Roadmap|Stack Technique)',\s*style: const TextStyle\(fontFamily: 'JetBrains Mono[^']*'" = "Text(`n        '$1',`n        style: const TextStyle(fontFamily: 'MuseoModerno'"
        
        # Headers de cartes et sections
        "fontFamily: 'JetBrains Mono[^']*',\s*fontSize: (24|20|18),\s*fontWeight: FontWeight\.(bold|w600)" = "fontFamily: 'MuseoModerno', fontSize: $1, fontWeight: FontWeight.$2"
    }
    
    foreach ($search in $replacements.Keys) {
        if ($content -match $search) {
            $content = $content -replace $search, $replacements[$search]
            $modified = $true
            Write-Host "Applied specific replacement in: $($file.FullName)" -ForegroundColor Blue
        }
    }
    
    if ($modified) {
        Set-Content $file.FullName $content -NoNewline
    }
}

Write-Host "Font correction completed!" -ForegroundColor Cyan
