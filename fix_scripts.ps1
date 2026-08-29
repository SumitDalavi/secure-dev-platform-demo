$files = Get-ChildItem -Path cluster, demo -Recurse -Filter *.sh
foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName)
    $content = $content -replace '\bkubectl\s', 'kubectl.exe '
    $content = $content -replace '\bhelm\s', 'helm.exe '
    $content = $content -replace '\bkind\s', 'kind.exe '
    $content = $content -replace '\bdocker\s', 'docker.exe '
    $content = $content -replace '\r\n', "`n"
    [System.IO.File]::WriteAllText($file.FullName, $content, (New-Object System.Text.UTF8Encoding($false)))
}
Write-Host "Fixed scripts"
