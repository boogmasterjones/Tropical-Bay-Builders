$root = Split-Path -Parent $PSScriptRoot
$files = Get-ChildItem -Path $root -Filter *.html -Recurse | Where-Object { $_.FullName -notmatch '_source_clearvant' }

$errors = @()
foreach ($f in $files) {
    $html = Get-Content $f.FullName -Raw
    $blocks = [regex]::Matches($html, '(?is)<script type="application/ld\+json">(.*?)</script>')
    foreach ($b in $blocks) {
        $json = $b.Groups[1].Value
        try {
            $null = $json | ConvertFrom-Json -ErrorAction Stop
        } catch {
            $errors += [PSCustomObject]@{ File = $f.FullName.Substring($root.Length+1); Error = $_.Exception.Message }
        }
    }
}

if ($errors.Count -eq 0) {
    Write-Output "All JSON-LD blocks parsed successfully."
} else {
    Write-Output "JSON-LD ERRORS FOUND:"
    $errors | Format-Table -Wrap
}
