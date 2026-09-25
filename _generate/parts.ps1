# Shared HTML fragments (header/footer/schema) for the Tropical Bay Builders site.
# Design copied from clearvantwc.com; content is Tropical Bay Builders' own.

$SiteUrl = "https://www.tropicalbaybuilders.com"
$Phone = "(941) 336-6255"
$PhoneTel = "tel:+19413366255"
$Email = "contact@tropicalbaybuilders.com"
$GA4 = "G-XXXXXXXXXX"

function Get-HeadCommon {
    param(
        [string]$Title, [string]$Desc, [string]$Canonical,
        [string]$SchemaBlocks = "",
        [string]$OgImage = "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?q=80&w=1200&auto=format&fit=crop"
    )
@"
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>$Title</title>
<meta name="description" content="$Desc">
<link rel="canonical" href="$SiteUrl/$Canonical">
<link rel="icon" type="image/svg+xml" href="/images/favicon.svg">
<link rel="icon" type="image/png" sizes="32x32" href="/images/favicon-32.png">
<link rel="apple-touch-icon" href="/images/apple-touch-icon.png">

<meta property="og:type" content="website">
<meta property="og:title" content="$Title">
<meta property="og:description" content="$Desc">
<meta property="og:url" content="$SiteUrl/$Canonical">
<meta property="og:site_name" content="Tropical Bay Builders">
<meta property="og:image" content="$OgImage">
<meta property="og:image:width" content="1200">
<meta property="og:image:height" content="630">
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:title" content="$Title">
<meta name="twitter:description" content="$Desc">
<meta name="twitter:image" content="$OgImage">

$SchemaBlocks
<script async src="https://www.googletagmanager.com/gtag/js?id=$GA4"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', '$GA4');
</script>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@500;600;700;800&family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="/css/style.css">
"@
}

function Get-Header {
@"
<header class="site-header">
  <div class="header-inner">
    <a href="/" class="logo">
      <svg width="34" height="34" viewBox="0 0 64 64" aria-hidden="true"><defs><linearGradient id="tbbBg" x1="0" y1="0" x2="64" y2="64" gradientUnits="userSpaceOnUse"><stop offset="0" stop-color="#0b3c33"/><stop offset="1" stop-color="#051f1a"/></linearGradient><linearGradient id="tbbSun" x1="21" y1="15" x2="43" y2="37" gradientUnits="userSpaceOnUse"><stop offset="0" stop-color="#ef8a5c"/><stop offset="1" stop-color="#c04f1e"/></linearGradient></defs><rect width="64" height="64" rx="18" fill="url(#tbbBg)"/><circle cx="32" cy="26" r="11" fill="url(#tbbSun)"/><path d="M14 48c4-12 12-18 18-18s14 6 18 18" stroke="#7fe0c4" stroke-width="5" fill="none" stroke-linecap="round"/></svg>
      <span>Tropical Bay<span class="tagline">Builders</span></span>
    </a>
    <div class="header-cta">
      <div class="menu-wrap">
        <button class="menu-toggle" aria-haspopup="true" aria-expanded="false">
                  <svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="#f4ede1" stroke-width="2"><line x1="3" y1="6" x2="21" y2="6"/><line x1="3" y1="12" x2="21" y2="12"/><line x1="3" y1="18" x2="21" y2="18"/></svg>
          <span class="menu-label">Menu</span>
        </button>
        <nav class="main-nav" aria-label="Primary">
      <a href="/">Home</a>
      <a href="/our-services.html">Our Services</a>
      <a href="/restoration.html">Disaster Restoration</a>
      <a href="/service-areas.html">Service Areas</a>
      <a href="/blog.html">Blog</a>
      <a href="/about.html">About &amp; Contact</a>
        </nav>
      </div>
      <a class="phone-link" href="$PhoneTel" onclick="gtag('event','call_click',{'event_category':'engagement','event_label':'header_phone_button'})">
        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#f4ede1" stroke-width="2"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72c.127.96.361 1.903.7 2.81a2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45c.907.339 1.85.573 2.81.7A2 2 0 0 1 22 16.92z"/></svg>
        <span class="phone-text">$Phone</span>
      </a>
      <a href="/#quote" class="btn btn-primary header-estimate"><span class="btn-full">Free Estimate</span><span class="btn-short">Estimate</span></a>
      <a href="$PhoneTel" class="btn btn-primary header-call" onclick="gtag('event','call_click',{'event_category':'engagement','event_label':'header_mobile_call_button'})"><svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.4"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72c.127.96.361 1.903.7 2.81a2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45c.907.339 1.85.573 2.81.7A2 2 0 0 1 22 16.92z"/></svg><span class="call-word">Call&nbsp;</span><span class="call-num">$Phone</span><span class="call-short">Call</span></a>
    </div>
  </div>
</header>
"@
}

function Get-Footer {
@"
<footer class="site-footer">
  <div class="container">
    <div class="footer-grid">
      <div class="footer-col">
        <div class="footer-logo">
          <svg width="28" height="28" viewBox="0 0 64 64" aria-hidden="true"><defs><linearGradient id="tbbBgF" x1="0" y1="0" x2="64" y2="64" gradientUnits="userSpaceOnUse"><stop offset="0" stop-color="#1aa084"/><stop offset="1" stop-color="#0f6b58"/></linearGradient></defs><rect width="64" height="64" rx="18" fill="url(#tbbBgF)"/><circle cx="32" cy="26" r="11" fill="#ffffff"/><path d="M14 48c4-12 12-18 18-18s14 6 18 18" stroke="#072a24" stroke-width="5" fill="none" stroke-linecap="round"/></svg>
          Tropical Bay Builders
        </div>
        <p style="color:#b8c2cc; font-size:0.9rem;">Licensed general contractor based in North Port, FL, serving the Gulf Coast from Bradenton to Sanibel Island &mdash; remodeling, new construction, and disaster restoration. Licensed &amp; insured.</p>
      </div>
      <div class="footer-col">
        <h4>Remodeling &amp; Construction</h4>
        <a href="/our-services.html">All Services</a>
        <a href="/services/kitchen-remodeling.html">Kitchen Remodeling</a>
        <a href="/services/bathroom-remodeling.html">Bathroom Remodeling</a>
        <a href="/services/new-construction.html">New Construction</a>
        <a href="/services/exterior-remodel-additions.html">Exterior &amp; Additions</a>
        <a href="/services/roofing.html">Roofing</a>
        <a href="/services/fences.html">Fences</a>
        <a href="/services/driveways-patios.html">Driveways &amp; Patios</a>
        <a href="/services/epoxy-flooring.html">Epoxy Flooring</a>
        <a href="/services/woodworking.html">Custom Woodworking</a>
      </div>
      <div class="footer-col">
        <h4>Disaster Restoration</h4>
        <a href="/restoration/storm-damage-restoration.html">Storm Damage</a>
        <a href="/restoration/water-damage-extraction.html">Water Damage &amp; Extraction</a>
        <a href="/restoration/fire-damage-restoration.html">Fire Damage</a>
        <a href="/restoration/storm-mitigation.html">Storm Mitigation</a>
        <h4 style="margin-top:22px;">Service Areas</h4>
        <a href="/">North Port, FL</a>
        <a href="/locations/port-charlotte.html">Port Charlotte, FL</a>
        <a href="/locations/punta-gorda.html">Punta Gorda, FL</a>
        <a href="/locations/venice.html">Venice, FL</a>
        <a href="/locations/englewood.html">Englewood, FL</a>
        <a href="/locations/sarasota.html">Sarasota, FL</a>
        <a href="/locations/bradenton.html">Bradenton, FL</a>
        <a href="/locations/fort-myers.html">Fort Myers, FL</a>
        <a href="/locations/boca-grande.html">Boca Grande, FL</a>
      </div>
      <div class="footer-col">
        <h4>Contact</h4>
        <a href="$PhoneTel" onclick="gtag('event','call_click',{'event_category':'engagement','event_label':'footer_phone_button'})">$Phone</a>
        <a href="mailto:$Email">$Email</a>
        <a href="/about.html">Contact &amp; Free Estimate</a>
        <a href="/blog.html">Blog</a>
        <span style="color:#8a94a0; font-size:0.9rem;">North Port, FL</span>
      </div>
    </div>
    <div class="footer-bottom">
      <span>&copy; <span data-year>2026</span> Tropical Bay Builders. All rights reserved.</span>
      <span>Licensed &amp; Insured &mdash; Serving North Port &amp; Southwest Florida</span>
    </div>
  </div>
</footer>

<script src="/js/main.js"></script>
"@
}

function New-Page {
    param(
        [string]$Path, [string]$Title, [string]$Desc, [string]$Canonical,
        [string]$Body, [string]$SchemaBlocks = "", [string]$OgImage = "", [string]$BodyClass = ""
    )
    $ogImg = if ($OgImage) { $OgImage } else { "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?q=80&w=1200&auto=format&fit=crop" }
    $head = Get-HeadCommon -Title $Title -Desc $Desc -Canonical $Canonical -SchemaBlocks $SchemaBlocks -OgImage $ogImg
    $header = Get-Header
    $footer = Get-Footer
    $bodyAttr = if ($BodyClass) { " class=`"$BodyClass`"" } else { "" }
    $html = @"
<!DOCTYPE html>
<html lang="en">
<head>
$head
</head>
<body$bodyAttr>

$header

<main>

$Body

</main>

$footer
</body>
</html>
"@
    $dir = Split-Path -Parent $Path
    if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Force -Path $dir | Out-Null }
    $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
    [System.IO.File]::WriteAllText($Path, $html, $utf8NoBom)
}

function Get-BizSchema {
@"
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "HomeAndConstructionBusiness",
  "name": "Tropical Bay Builders",
  "telephone": "+1-941-336-6255",
  "url": "$SiteUrl/",
  "areaServed": [
    {"@type": "City", "name": "North Port, FL"},
    {"@type": "City", "name": "Port Charlotte, FL"},
    {"@type": "City", "name": "Punta Gorda, FL"},
    {"@type": "City", "name": "Venice, FL"},
    {"@type": "City", "name": "Englewood, FL"},
    {"@type": "City", "name": "Sarasota, FL"},
    {"@type": "City", "name": "Bradenton, FL"},
    {"@type": "City", "name": "Fort Myers, FL"},
    {"@type": "City", "name": "Boca Grande, FL"},
    {"@type": "City", "name": "Sanibel, FL"}
  ],
  "address": { "@type": "PostalAddress", "addressLocality": "North Port", "addressRegion": "FL", "addressCountry": "US" },
  "priceRange": "`$`$",
  "aggregateRating": { "@type": "AggregateRating", "ratingValue": "5", "reviewCount": "42" },
  "review": [
    {"@type": "Review", "author": {"@type": "Person", "name": "James A."}, "reviewRating": {"@type": "Rating", "ratingValue": "5", "bestRating": "5"}, "reviewBody": "We were nervous about remodeling our kitchen, but the team at Tropical Bay Builders made the process so smooth and enjoyable. Their communication was excellent, and they completed the project on time and within budget. Our kitchen looks amazing!"},
    {"@type": "Review", "author": {"@type": "Person", "name": "Jacki J."}, "reviewRating": {"@type": "Rating", "ratingValue": "5", "bestRating": "5"}, "reviewBody": "Just a fantastic experience. Elijah was quick to get to my house almost immediately after I called for help. Top quality work and above average customer service. I will use Tropical Bay Builders over and over again!"},
    {"@type": "Review", "author": {"@type": "Person", "name": "Toni P."}, "reviewRating": {"@type": "Rating", "ratingValue": "5", "bestRating": "5"}, "reviewBody": "Exceptional quality and attention to detail. Not the cheapest quote I received, but the work was well worth the extra dollars. Neighbors also hired Tropical Bay Builders after seeing the quality of their work."},
    {"@type": "Review", "author": {"@type": "Person", "name": "Kevin D."}, "reviewRating": {"@type": "Rating", "ratingValue": "5", "bestRating": "5"}, "reviewBody": "When it came time for the work to be done, they were on target with the estimated start date on my contract. Al kept me informed as to when the material and dumpster would be coming and verified the morning start time with me prior to their arrival. While here his men were very professional and courteous. They kept my yard very clean during the process and were very careful not to damage any of my shrubs and planting around my house. I will call Tropical Bay Builders for any future home repairs or renovations."},
    {"@type": "Review", "author": {"@type": "Person", "name": "Jessica L."}, "reviewRating": {"@type": "Rating", "ratingValue": "5", "bestRating": "5"}, "reviewBody": "They are very punctual, they are very good. The price is competitive and I wasn't disappointed with the service. They gave a due date and were able to make it. They did everything for just 14 hours."}
  ]
}
</script>
"@
}

function Get-FaqSchema {
    param([array]$Faqs)
    $entities = ($Faqs | ForEach-Object {
@"
    { "@type": "Question", "name": "$($_.Q)", "acceptedAnswer": { "@type": "Answer", "text": "$($_.A)" } }
"@
    }) -join ",`n"
@"
<script type="application/ld+json">
{ "@context": "https://schema.org", "@type": "FAQPage", "mainEntity": [
$entities
] }
</script>
"@
}

function Get-ServiceSchema {
    param([string]$ServiceType, [string]$AreaServed = "North Port, FL")
@"
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Service",
  "serviceType": "$ServiceType",
  "provider": {"@type": "HomeAndConstructionBusiness", "name": "Tropical Bay Builders", "telephone": "+1-941-336-6255"},
  "areaServed": "$AreaServed"
}
</script>
"@
}

function Get-LocationSchema {
    param([string]$City, [string]$Canonical)
@"
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "HomeAndConstructionBusiness",
  "name": "Tropical Bay Builders",
  "telephone": "+1-941-336-6255",
  "url": "$SiteUrl/$Canonical",
  "areaServed": {"@type": "City", "name": "$City, FL"},
  "priceRange": "`$`$",
  "openingHoursSpecification": {"@type": "OpeningHoursSpecification", "dayOfWeek": ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"], "opens": "07:00", "closes": "19:00"}
}
</script>
"@
}

function Get-CtaStrip {
    param([string]$Heading, [string]$Text, [string]$Label = "Free Estimate", [string]$EventLabel = "strip_phone_button")
@"
    <div class="cta-strip-wrap" style="padding-bottom:0; margin:32px 0;">
      <div class="cta-strip">
        <div class="cta-strip-text">
          <strong>$Heading</strong>
          <span>$Text</span>
        </div>
        <div class="cta-strip-actions">
          <a href="$PhoneTel" class="btn btn-outline-dark" onclick="gtag('event','call_click',{'event_category':'engagement','event_label':'$EventLabel'})">Call Now</a>
          <a href="/#quote" class="btn btn-primary">$Label</a>
        </div>
      </div>
    </div>
"@
}
