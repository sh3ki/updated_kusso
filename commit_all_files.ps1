# Commit each file individually
Write-Host "Starting commits..." -ForegroundColor Green

$files = git ls-files --others --exclude-standard
$files += git ls-files --modified
$files += git diff --cached --name-only
$files = $files | Where-Object { $_ } | Select-Object -Unique | Sort-Object

Write-Host "Found $($files.Count) files" -ForegroundColor Cyan

$count = 0
foreach ($file in $files) {
    $count++
    Write-Host "[$count/$($files.Count)] $file"
    git add "$file"
    git commit -m "Create $file"
}

Write-Host "`nPushing..." -ForegroundColor Yellow
git push origin master
Write-Host "Done!" -ForegroundColor Green
