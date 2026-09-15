$root = Split-Path -Parent $PSScriptRoot
$files = Get-ChildItem -Path $root -Filter *.html -Recurse | Where-Object { $_.FullName -notmatch '_source_clearvant' }

$brokenLinks = @()
$externalHosts = @{}

foreach ($f in $files) {
    $html = Get-Content $f.FullName -Raw
    $hrefs = [regex]::Matches($html, 'href="([^"]+)"') | ForEach-Object { $_.Groups[1].Value }
    foreach ($href in $hrefs) {
        if ($href -match '^(tel:|mailto:|https?://|#)') {
            if ($href -match '^https?://') {
                $hostMatch = [regex]::Match($href, '^https?://([^/]+)')
                $h = $hostMatch.Groups[1].Value
                if (-not $externalHosts.ContainsKey($h)) { $externalHosts[$h] = 0 }
                $externalHosts[$h]++
            }
            continue
        }
        $path = $href -replace '#.*$', ''
        if ($path -eq '' -or $path -eq '/') { continue }
        $path = $path.TrimStart('/')
        if ($path -eq '') { continue }
        $target = Join-Path $root $path
        if (-not (Test-Path $target -PathType Leaf)) {
            $brokenLinks += [PSCustomObject]@{ Source = $f.FullName.Substring($root.Length+1); Href = $href }
        }
    }
}

Write-Output "=== BROKEN INTERNAL LINKS ==="
if ($brokenLinks.Count -eq 0) { Write-Output "None found." } else { $brokenLinks | Format-Table -AutoSize }

Write-Output ""
Write-Output "=== EXTERNAL HOSTS REFERENCED ==="
$externalHosts.GetEnumerator() | Sort-Object Name | ForEach-Object { Write-Output "$($_.Key): $($_.Value) links" }
