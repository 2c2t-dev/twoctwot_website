# Script pour réparer les fichiers cassés par les regex

$files = @(
    "lib/features/about/presentation/pages/about_page.dart",
    "lib/features/projects/presentation/pages/projects_page.dart", 
    "lib/features/team/presentation/pages/team_page.dart",
    "lib/shared/presentation/widgets/main_layout.dart"
)

foreach ($file in $files) {
    if (Test-Path $file) {
        $content = Get-Content $file -Raw
        $originalContent = $content
        
        # Corriger les patterns cassés les plus courants
        
        # Pattern 1: Theme.of(context).textTheme.xxx,\n    color: AppTheme.xxx,\n  ),
        $content = $content -replace "style: Theme\.of\(context\)\.textTheme\.\w+,\s*color: ([^,\)]+),\s*\)", "style: Theme.of(context).textTheme.titleLarge?.copyWith(color: $1)"
        
        # Pattern 2: color et fontWeight orphelins
        $content = $content -replace "style: Theme\.of\(context\)\.textTheme\.(\w+),\s*color: ([^,\)]+),\s*\),", "style: Theme.of(context).textTheme.$1?.copyWith(color: $2),"
        
        # Pattern 3: context isolé avec fontWeight et color
        $content = $content -replace "(\s+)fontWeight: ([^,]+),\s*color: ([^,\)]+),\s*\),", '$1)'
        
        # Pattern 4: nettoyer les lignes cassées avec des virgules orphelines
        $content = $content -replace ",\s*\),\s*\),", "),"
        
        # Pattern 5: réparer les Theme.of calls cassés
        $content = $content -replace "Theme\.of\(context\)\.textTheme\.(\w+),\s*([^)]+)\),", "Theme.of(context).textTheme.$1"
        
        # Pattern 6: nettoyer les ; orphelins
        $content = $content -replace ";\s*;", ";"
        $content = $content -replace "^\s*;\s*$", ""
        
        # Sauvegarder si des changements ont été faits
        if ($content -ne $originalContent) {
            Set-Content $file $content -NoNewline
            Write-Host "Repaired: $file" -ForegroundColor Green
        } else {
            Write-Host "No changes needed: $file" -ForegroundColor Yellow
        }
    } else {
        Write-Host "File not found: $file" -ForegroundColor Red
    }
}

Write-Host "Repair completed!" -ForegroundColor Cyan
