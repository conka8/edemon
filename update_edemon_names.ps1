# PowerShell script to update name field in all edemon-nft metadata files

Write-Host "Updating name field in all edemon-nft metadata files..."
Write-Host "Changing from 'Baby Edemon #B-000001 — Pyrelit' to 'Baby Edemon'"

$files = Get-ChildItem -Name "edemon-nft-*.metadata.json" | Where-Object { $_ -match "^edemon-nft-\d+\.metadata\.json$" }
$updatedCount = 0

foreach ($file in $files) {
    $content = Get-Content $file -Raw -Encoding UTF8
    
    # Replace the name field
    $newContent = $content -replace '"name": "Baby Edemon #B-000001 — Pyrelit"', '"name": "Baby Edemon"'
    
    # Write back to file
    $newContent | Out-File -FilePath $file -Encoding UTF8 -NoNewline
    $updatedCount++
    
    if ($updatedCount % 10 -eq 0) {
        Write-Host "Updated $updatedCount files..."
    }
}

Write-Host "Update completed! Modified $updatedCount files."