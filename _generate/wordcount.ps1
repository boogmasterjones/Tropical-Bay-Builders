$root = Split-Path -Parent $PSScriptRoot
$files = Get-ChildItem -Path $root -Filter *.html -Recurse | Where-Object { $_.FullName -notmatch '_source_clearvant' }

$results = foreach ($f in $files) {
    $html = Get-Content $f.FullName -Raw
    $html = [regex]::Replace($html, '(?is)<script.*?</script>', ' ')
    $html = [regex]::Replace($html, '(?is)<style.*?</style>', ' ')
    $html = [regex]::Replace($html, '(?is)<header.*?</header>', ' ')
    $html = [regex]::Replace($html, '(?is)<footer.*?</footer>', ' ')
    $text = [regex]::Replace($html, '(?s)<[^>]+>', ' ')
    $text = $text -replace '&amp;', '&' -replace '&mdash;', '-' -replace '&rsquo;', "'" -replace '&nbsp;', ' ' -replace '&[a-zA-Z#0-9]+;', ' '
    $words = ($text -split '\s+') | Where-Object { $_ -ne '' }
    [PSCustomObject]@{
        Path  = $f.FullName.Substring($root.Length + 1)
        Words = $words.Count
    }
}

$results | Sort-Object Path | Format-Table -AutoSize
$total = ($results | Measure-Object -Property Words -Sum).Sum
Write-Output "TOTAL: $total words across $($results.Count) pages"
