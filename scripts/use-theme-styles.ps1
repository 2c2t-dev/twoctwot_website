# Script PowerShell pour remplacer les TextStyle hardcodés par les styles de thème
# Cela va garantir que MuseoModerno soit bien utilisée sur tous les titres

$files = Get-ChildItem -Path "lib" -Recurse -Filter "*.dart"

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    $modified = $false
    
    # Remplacements pour utiliser les styles de thème au lieu de TextStyle hardcodés
    $replacements = @{
        # Titres principaux (grandes tailles)
        "style: const TextStyle\(fontFamily: 'MuseoModerno',\s*fontSize: (48|44|40|36),\s*fontWeight: FontWeight\.bold" = "style: Theme.of(context).textTheme.headlineLarge"
        "style: const TextStyle\(fontFamily: 'MuseoModerno',\s*fontSize: (32|30|28),\s*fontWeight: FontWeight\.(bold|w600)" = "style: Theme.of(context).textTheme.headlineMedium"
        "style: const TextStyle\(fontFamily: 'MuseoModerno',\s*fontSize: (24|22),\s*fontWeight: FontWeight\.(bold|w600)" = "style: Theme.of(context).textTheme.headlineSmall"
        
        # Titres moyens
        "style: const TextStyle\(fontFamily: 'MuseoModerno',\s*fontSize: (20|19|18),\s*fontWeight: FontWeight\.(w500|w600|bold)" = "style: Theme.of(context).textTheme.titleLarge"
        "style: const TextStyle\(fontFamily: 'MuseoModerno',\s*fontSize: (16|17),\s*fontWeight: FontWeight\.(w500|w600|bold)" = "style: Theme.of(context).textTheme.titleMedium"
        
        # Pattern plus simple pour les titres sans spécifications de poids
        "style: const TextStyle\(fontFamily: 'MuseoModerno',\s*fontSize: (48|44|40|36)" = "style: Theme.of(context).textTheme.headlineLarge"
        "style: const TextStyle\(fontFamily: 'MuseoModerno',\s*fontSize: (32|30|28)" = "style: Theme.of(context).textTheme.headlineMedium"
        "style: const TextStyle\(fontFamily: 'MuseoModerno',\s*fontSize: (24|22)" = "style: Theme.of(context).textTheme.headlineSmall"
        "style: const TextStyle\(fontFamily: 'MuseoModerno',\s*fontSize: (20|19|18)" = "style: Theme.of(context).textTheme.titleLarge"
        "style: const TextStyle\(fontFamily: 'MuseoModerno',\s*fontSize: (16|17)" = "style: Theme.of(context).textTheme.titleMedium"
    }
    
    foreach ($search in $replacements.Keys) {
        if ($content -match $search) {
            $content = $content -replace $search, $replacements[$search]
            $modified = $true
            Write-Host "Replaced TextStyle with theme style in: $($file.FullName)" -ForegroundColor Green
        }
    }
    
    # Remplacements spéciaux pour les patterns complexes
    # Pattern avec couleur spécifiée
    if ($content -match "style: const TextStyle\(fontFamily: 'MuseoModerno',\s*fontSize: (\d+),\s*fontWeight: FontWeight\.\w+,\s*color: [^,)]+\)") {
        $content = $content -replace "style: const TextStyle\(fontFamily: 'MuseoModerno',\s*fontSize: (\d+),\s*fontWeight: FontWeight\.\w+,\s*color: ([^,)]+)\)", {
            $fontSize = [int]$matches[1]
            $color = $matches[2]
            
            if ($fontSize -ge 36) {
                "style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: $color)"
            } elseif ($fontSize -ge 28) {
                "style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: $color)"
            } elseif ($fontSize -ge 22) {
                "style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: $color)"
            } elseif ($fontSize -ge 18) {
                "style: Theme.of(context).textTheme.titleLarge?.copyWith(color: $color)"
            } else {
                "style: Theme.of(context).textTheme.titleMedium?.copyWith(color: $color)"
            }
        }
        $modified = $true
        Write-Host "Replaced complex TextStyle with theme style in: $($file.FullName)" -ForegroundColor Blue
    }
    
    if ($modified) {
        Set-Content $file.FullName $content -NoNewline
    }
}

Write-Host "Theme style replacement completed!" -ForegroundColor Cyan
