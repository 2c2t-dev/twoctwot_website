# Script PowerShell pour remplacer TOUS les TextStyle avec MuseoModerno par les styles de thème
# Version plus agressive qui capture tous les patterns

$files = Get-ChildItem -Path "lib" -Recurse -Filter "*.dart" | Where-Object { $_.Name -ne "app_theme.dart" }

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    $originalContent = $content
    
    # Patterns pour remplacer par les styles de thème selon la taille
    $patterns = @(
        # Grandes tailles (48, 44, 40, 36) -> headlineLarge
        @{
            Pattern = "style:\s*const\s+TextStyle\([^)]*fontFamily:\s*'MuseoModerno'[^)]*fontSize:\s*(48|44|40|36)[^)]*\)"
            Replacement = "style: Theme.of(context).textTheme.headlineLarge"
        },
        
        # Tailles moyennes-grandes (32, 30, 28) -> headlineMedium  
        @{
            Pattern = "style:\s*const\s+TextStyle\([^)]*fontFamily:\s*'MuseoModerno'[^)]*fontSize:\s*(32|30|28)[^)]*\)"
            Replacement = "style: Theme.of(context).textTheme.headlineMedium"
        },
        
        # Tailles moyennes (24, 22) -> headlineSmall
        @{
            Pattern = "style:\s*const\s+TextStyle\([^)]*fontFamily:\s*'MuseoModerno'[^)]*fontSize:\s*(24|22)[^)]*\)"
            Replacement = "style: Theme.of(context).textTheme.headlineSmall"
        },
        
        # Tailles moyennes-petites (20, 19, 18) -> titleLarge
        @{
            Pattern = "style:\s*const\s+TextStyle\([^)]*fontFamily:\s*'MuseoModerno'[^)]*fontSize:\s*(20|19|18)[^)]*\)"
            Replacement = "style: Theme.of(context).textTheme.titleLarge"
        },
        
        # Petites tailles (16, 17) -> titleMedium
        @{
            Pattern = "style:\s*const\s+TextStyle\([^)]*fontFamily:\s*'MuseoModerno'[^)]*fontSize:\s*(16|17)[^)]*\)"
            Replacement = "style: Theme.of(context).textTheme.titleMedium"
        },
        
        # Très petites tailles (14, 13, 12) -> titleSmall
        @{
            Pattern = "style:\s*const\s+TextStyle\([^)]*fontFamily:\s*'MuseoModerno'[^)]*fontSize:\s*(14|13|12)[^)]*\)"
            Replacement = "style: Theme.of(context).textTheme.titleSmall"
        },
        
        # Sans fontSize spécifiée -> titleLarge par défaut
        @{
            Pattern = "style:\s*const\s+TextStyle\(\s*fontFamily:\s*'MuseoModerno'\s*\)"
            Replacement = "style: Theme.of(context).textTheme.titleLarge"
        },
        
        # Avec seulement fontWeight
        @{
            Pattern = "style:\s*const\s+TextStyle\(\s*fontFamily:\s*'MuseoModerno',\s*fontWeight:\s*FontWeight\.\w+\s*\)"
            Replacement = "style: Theme.of(context).textTheme.titleLarge"
        }
    )
    
    foreach ($patternInfo in $patterns) {
        if ($content -match $patternInfo.Pattern) {
            $content = $content -replace $patternInfo.Pattern, $patternInfo.Replacement
            Write-Host "Applied pattern '$($patternInfo.Pattern)' in: $($file.FullName)" -ForegroundColor Green
        }
    }
    
    # Sauvegarder si des changements ont été faits
    if ($content -ne $originalContent) {
        Set-Content $file.FullName $content -NoNewline
        Write-Host "Modified file: $($file.FullName)" -ForegroundColor Yellow
    }
}

Write-Host "All MuseoModerno TextStyles replaced with theme styles!" -ForegroundColor Cyan
