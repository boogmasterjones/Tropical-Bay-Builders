. "$PSScriptRoot\parts.ps1"
$root = Split-Path -Parent $PSScriptRoot

# ---------- 404.html ----------
$notFoundBody = @"
<div class="page-header" style="text-align:center;">
  <div class="container">
    <h1>Page Not <em>Found</em></h1>
    <p>The page you're looking for doesn't exist or may have moved. Try one of the links below, or head back home.</p>
    <div class="hero-actions" style="justify-content:center;">
      <a href="/" class="btn btn-primary">Back to Home</a>
      <a href="$PhoneTel" class="btn btn-outline-dark" onclick="gtag('event','call_click',{'event_category':'engagement','event_label':'404_page_phone_button'})">Call $Phone</a>
    </div>
  </div>
</div>
"@
New-Page -Path (Join-Path $root "404.html") -Title "Page Not Found | Tropical Bay Builders" -Desc "The page you're looking for could not be found." -Canonical "404.html" -Body $notFoundBody

# ---------- thank-you.html ----------
$thankYouBody = @"
<div class="page-header" style="text-align:center;">
  <div class="container">
    <h1>Thank <em>You</em></h1>
    <p>We've received your message and will get back to you shortly. If your project is time-sensitive, feel free to call us directly.</p>
    <div class="hero-actions" style="justify-content:center;">
      <a href="$PhoneTel" class="btn btn-primary" onclick="gtag('event','call_click',{'event_category':'engagement','event_label':'thank_you_phone_button'})">Call $Phone</a>
      <a href="/" class="btn btn-outline-dark">Back to Home</a>
    </div>
  </div>
</div>
"@
New-Page -Path (Join-Path $root "thank-you.html") -Title "Thank You | Tropical Bay Builders" -Desc "Thank you for contacting Tropical Bay Builders. We'll be in touch shortly." -Canonical "thank-you.html" -Body $thankYouBody

# ---------- robots.txt ----------
$robots = @"
User-agent: *
Allow: /

Sitemap: $SiteUrl/sitemap.xml
"@
$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText((Join-Path $root "robots.txt"), $robots, $utf8NoBom)

# ---------- sitemap.xml ----------
$today = Get-Date -Format "yyyy-MM-dd"
$urls = @(
  "", "our-services.html", "restoration.html", "service-areas.html", "about.html", "blog.html",
  "services/kitchen-remodeling.html","services/bathroom-remodeling.html","services/new-construction.html",
  "services/exterior-remodel-additions.html","services/roofing.html","services/fences.html",
  "services/driveways-patios.html","services/epoxy-flooring.html","services/woodworking.html",
  "restoration/storm-damage-restoration.html","restoration/water-damage-extraction.html",
  "restoration/fire-damage-restoration.html","restoration/storm-mitigation.html",
  "locations/port-charlotte.html","locations/punta-gorda.html","locations/venice.html",
  "locations/englewood.html","locations/sarasota.html","locations/bradenton.html",
  "locations/fort-myers.html","locations/boca-grande.html",
  "blog/how-to-hire-a-good-general-contractor-in-southwest-florida.html",
  "blog/avoid-these-3-things-when-hiring-someone-to-build-your-home.html",
  "blog/5-structural-features-every-florida-kitchen-should-have.html"
)
$urlEntries = ($urls | ForEach-Object {
    $loc = if ($_ -eq "") { "$SiteUrl/" } else { "$SiteUrl/$_" }
    $priority = if ($_ -eq "") { "1.0" } else { "0.7" }
"  <url>
    <loc>$loc</loc>
    <lastmod>$today</lastmod>
    <priority>$priority</priority>
  </url>"
}) -join "`n"
$sitemap = @"
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
$urlEntries
</urlset>
"@
[System.IO.File]::WriteAllText((Join-Path $root "sitemap.xml"), $sitemap, $utf8NoBom)

Write-Output "404, thank-you, robots.txt, sitemap.xml built"
