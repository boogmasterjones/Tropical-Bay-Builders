. "$PSScriptRoot\parts.ps1"
$root = Split-Path -Parent $PSScriptRoot

# ---------- our-services.html ----------
$serviceCards = @(
  @{Slug="kitchen-remodeling"; Name="Kitchen Remodeling"; Img="https://images.unsplash.com/photo-1556911220-e15b29be8c8f?q=80&w=900&auto=format&fit=crop"; Desc="Full and partial kitchen renovations - cabinetry, countertops, layout changes, and finishes built for Florida living."},
  @{Slug="bathroom-remodeling"; Name="Bathroom Remodeling"; Img="https://images.unsplash.com/photo-1620626011761-996317b8d101?q=80&w=900&auto=format&fit=crop"; Desc="Walk-in showers, tub conversions, vanities, and full bathroom overhauls done right the first time."},
  @{Slug="new-construction"; Name="New Construction"; Img="https://images.unsplash.com/photo-1503387762-592deb58ef4e?q=80&w=900&auto=format&fit=crop"; Desc="Ground-up builds and major additions managed from permitting through final walkthrough."},
  @{Slug="exterior-remodel-additions"; Name="Exterior Remodel &amp; Additions"; Img="https://images.unsplash.com/photo-1600585154526-990dced4db0d?q=80&w=900&auto=format&fit=crop"; Desc="Room additions, lanais, and exterior updates that add real living space and curb appeal."},
  @{Slug="roofing"; Name="Roofing"; Img="https://images.unsplash.com/photo-1632759145351-1d592919f522?q=80&w=900&auto=format&fit=crop"; Desc="Roof replacement and repair built for Florida's wind and rain, from shingle to metal."},
  @{Slug="fences"; Name="Fences"; Img="https://images.unsplash.com/photo-1621905251189-08b45d6a269e?q=80&w=900&auto=format&fit=crop"; Desc="Privacy, pool-code, and decorative fencing in wood, vinyl, and aluminum."},
  @{Slug="driveways-patios"; Name="Driveways &amp; Patios"; Img="https://images.unsplash.com/photo-1761637823407-ef47925c2714?q=80&w=900&auto=format&fit=crop"; Desc="Concrete, paver, and stamped-concrete driveways and patios built to handle Florida heat and rain."},
  @{Slug="epoxy-flooring"; Name="Epoxy Flooring"; Img="https://images.unsplash.com/photo-1771531072574-af6ed6b954c0?q=80&w=900&auto=format&fit=crop"; Desc="Durable, easy-to-clean epoxy floor coatings for garages, lanais, and commercial spaces."},
  @{Slug="woodworking"; Name="Custom Woodworking"; Img="https://images.unsplash.com/photo-1601058268499-e52658b8bb88?q=80&w=900&auto=format&fit=crop"; Desc="Built-ins, trim carpentry, and custom cabinetry crafted to fit your space exactly."}
)
$serviceCardsHtml = ($serviceCards | ForEach-Object {
"        <a href=`"/services/$($_.Slug).html`" class=`"work-card`">
          <img src=`"$($_.Img)`" alt=`"$($_.Name) in North Port FL`" loading=`"lazy`">
          <div class=`"work-card-body`"><h3>$($_.Name)</h3><p>$($_.Desc)</p></div>
        </a>"
}) -join "`n"

$servicesBody = @"
<div class="page-header">
  <div class="container">
    <p class="breadcrumb"><a href="/">Home</a> / Our Services</p>
    <h1>General Contracting Services in <em>North Port</em> &amp; Southwest Florida</h1>
    <p>From kitchen and bathroom remodeling to new construction, roofing, and outdoor living spaces, Tropical Bay Builders handles the full scope of residential and light-commercial construction under one accountable crew. Every service below is backed by the same licensed, insured team and the same free, honest estimate process.</p>
    <div class="hero-actions">
      <a href="$PhoneTel" class="btn btn-primary" onclick="gtag('event','call_click',{'event_category':'engagement','event_label':'services_hub_phone_button'})">Call $Phone</a>
      <a href="/#quote" class="btn btn-outline-dark">Request a Free Estimate</a>
    </div>
  </div>
</div>

<section>
  <div class="container">
    <div class="section-head">
      <h2>Remodeling &amp; Construction Services</h2>
      <p>Click any service below for full details, pricing factors, and frequently asked questions.</p>
    </div>
    <div class="grid-3">
$serviceCardsHtml
    </div>
  </div>
</section>

$(Get-CtaStrip -Heading "Not sure which service you need?" -Text "Tell us what you're picturing and we'll help you scope it - free estimate, no pressure." -EventLabel "services_hub_strip_phone")

<section class="section-orange">
  <div class="container">
    <div class="section-head">
      <h2>Need Storm or Water Damage Restoration?</h2>
      <p>We also handle disaster restoration - storm, water, and fire damage - as part of the same accountable, one-contractor approach.</p>
    </div>
    <div class="cta-band">
      <h2>Visit Our Disaster Restoration Services</h2>
      <p>Storm damage, water extraction, fire restoration, and storm mitigation - handled start to finish.</p>
      <div class="cta-actions">
        <a href="/restoration.html" class="btn btn-outline">View Restoration Services</a>
        <a href="$PhoneTel" class="btn btn-primary" onclick="gtag('event','call_click',{'event_category':'engagement','event_label':'services_hub_restoration_phone'})">Call $Phone</a>
      </div>
    </div>
  </div>
</section>
"@
New-Page -Path (Join-Path $root "our-services.html") -Title "General Contracting Services | Tropical Bay Builders" -Desc "Kitchen and bathroom remodeling, new construction, roofing, fencing, driveways, epoxy flooring, and custom woodworking in North Port, FL and Southwest Florida." -Canonical "our-services.html" -Body $servicesBody

# ---------- restoration.html ----------
$restCards = @(
  @{Slug="storm-damage-restoration"; Name="Storm Damage Restoration"; Img="https://images.unsplash.com/photo-1600585152220-90363fe7e115?q=80&w=900&auto=format&fit=crop"; Desc="Roof, siding, and structural repair after high winds and tropical storms."},
  @{Slug="water-damage-extraction"; Name="Water Damage &amp; Extraction"; Img="https://images.unsplash.com/photo-1585421514738-01798e348b17?q=80&w=900&auto=format&fit=crop"; Desc="Fast water extraction and drying to limit damage and prevent mold growth."},
  @{Slug="fire-damage-restoration"; Name="Fire Damage Restoration"; Img="https://images.unsplash.com/photo-1621905251918-48416bd8575a?q=80&w=900&auto=format&fit=crop"; Desc="Smoke, soot, and structural fire damage repair from assessment through rebuild."},
  @{Slug="storm-mitigation"; Name="Storm Mitigation"; Img="https://images.unsplash.com/photo-1523217582562-09d0def993a6?q=80&w=900&auto=format&fit=crop"; Desc="Impact windows, roof strapping, and wind mitigation upgrades before the next storm hits."}
)
$restCardsHtml = ($restCards | ForEach-Object {
"        <a href=`"/restoration/$($_.Slug).html`" class=`"work-card`">
          <img src=`"$($_.Img)`" alt=`"$($_.Name) in North Port FL`" loading=`"lazy`">
          <div class=`"work-card-body`"><h3>$($_.Name)</h3><p>$($_.Desc)</p></div>
        </a>"
}) -join "`n"

$restBody = @"
<div class="page-header">
  <div class="container">
    <p class="breadcrumb"><a href="/">Home</a> / Disaster Restoration</p>
    <h1>Disaster Restoration in <em>North Port</em> &amp; Southwest Florida</h1>
    <p>Florida weather doesn't wait, and neither should your repairs. Tropical Bay Builders handles storm damage, water extraction, fire restoration, and storm mitigation upgrades as a single accountable contractor - from initial assessment through full rebuild.</p>
    <div class="hero-actions">
      <a href="$PhoneTel" class="btn btn-primary" onclick="gtag('event','call_click',{'event_category':'engagement','event_label':'restoration_hub_phone_button'})">Call $Phone</a>
      <a href="/#quote" class="btn btn-outline-dark">Request Help Now</a>
    </div>
  </div>
</div>

<section>
  <div class="container">
    <div class="section-head">
      <h2>Restoration Services</h2>
      <p>Click any service below for full details on what's involved and what to expect.</p>
    </div>
    <div class="grid-2">
$restCardsHtml
    </div>
  </div>
</section>

$(Get-CtaStrip -Heading "Dealing with storm or water damage right now?" -Text "Call us and we'll walk you through the next steps." -Label "Request Help Now" -EventLabel "restoration_hub_strip_phone")

<section class="section-alt">
  <div class="container content-section" style="border-top:none;">
    <h2>Why Choose One Contractor for Restoration and Rebuild</h2>
    <p>A lot of restoration companies stop at drying out a property or tarping a roof, leaving homeowners to find a separate contractor for the actual rebuild - new drywall, flooring, cabinetry, or structural repair. That handoff is where a lot of restoration projects lose time, and where miscommunication between two companies can leave gaps in the final result.</p>
    <p>Tropical Bay Builders handles both halves as one job. The same crew that assesses and stabilizes the damage carries the project through to a finished, livable space, which means fewer scheduling gaps, one point of contact, and a final result that's built to the same standard as our remodeling and new construction work.</p>
  </div>
</section>
"@
New-Page -Path (Join-Path $root "restoration.html") -Title "Disaster Restoration Services | Tropical Bay Builders" -Desc "Storm damage, water extraction, fire restoration, and storm mitigation in North Port, FL and Southwest Florida. Licensed general contractor, one crew from assessment to rebuild." -Canonical "restoration.html" -Body $restBody

# ---------- service-areas.html ----------
$areas = @(
  @{Slug=""; Name="North Port"; Pop="~82,000"; Desc="Our home base - remodeling, new construction, and restoration throughout North Port and Wellen Park."},
  @{Slug="locations/port-charlotte.html"; Name="Port Charlotte"; Pop="~60,000"; Desc="Canal-front remodels, new construction, and storm restoration just up the road."},
  @{Slug="locations/punta-gorda.html"; Name="Punta Gorda"; Pop="~19,000"; Desc="From historic downtown to Punta Gorda Isles waterfront homes."},
  @{Slug="locations/venice.html"; Name="Venice"; Pop="~25,000"; Desc="Venice Island, historic downtown, and neighborhoods toward Venice East."},
  @{Slug="locations/englewood.html"; Name="Englewood"; Pop="~30,000"; Desc="Manasota Key and Lemon Bay waterfront remodeling and restoration."},
  @{Slug="locations/sarasota.html"; Name="Sarasota"; Pop="~57,000"; Desc="Siesta Key, downtown, and neighborhoods toward Lakewood Ranch."},
  @{Slug="locations/bradenton.html"; Name="Bradenton"; Pop="~57,000"; Desc="Riverwalk, Palma Sola, and downtown - our northernmost regular service area."},
  @{Slug="locations/fort-myers.html"; Name="Fort Myers"; Pop="~92,000"; Desc="McGregor Boulevard and the River District, toward the Sanibel Causeway."},
  @{Slug="locations/boca-grande.html"; Name="Boca Grande"; Pop="~1,000"; Desc="Historic Gasparilla Island - high-end vacation homes and careful coastal review."}
)
$areaCardsHtml = ($areas | ForEach-Object {
    $href = if ($_.Slug -eq "") { "/" } else { "/$($_.Slug)" }
"        <a href=`"$href`" class=`"location-chip`">
          <h3>$($_.Name), FL</h3>
          <p>Population $($_.Pop)</p>
          <p>$($_.Desc)</p>
        </a>"
}) -join "`n"

$areasBody = @"
<div class="page-header">
  <div class="container">
    <p class="breadcrumb"><a href="/">Home</a> / Service Areas</p>
    <h1>Where We <em>Work</em></h1>
    <p>Tropical Bay Builders is based in North Port, FL and serves homeowners and businesses along the Gulf Coast stretch from Bradenton and Sarasota down through Fort Myers and toward Sanibel Island. Below are the communities where we work most often.</p>
  </div>
</div>

<section>
  <div class="container">
    <div class="locations-grid">
$areaCardsHtml
    </div>
  </div>
</section>

$(Get-CtaStrip -Heading "Don't see your city listed?" -Text "Give us a call - we may still be able to help depending on the project." -EventLabel "areas_hub_strip_phone")
"@
New-Page -Path (Join-Path $root "service-areas.html") -Title "Service Areas | Tropical Bay Builders" -Desc "Tropical Bay Builders serves North Port, Port Charlotte, Punta Gorda, Venice, Englewood, Sarasota, and Fort Myers, FL." -Canonical "service-areas.html" -Body $areasBody

# ---------- about.html ----------
$aboutBody = @"
<div class="page-header">
  <div class="container">
    <p class="breadcrumb"><a href="/">Home</a> / About &amp; Contact</p>
    <h1>About <em>Tropical Bay Builders</em></h1>
    <p>Tropical Bay Builders is a licensed and insured general contractor based in North Port, FL, with more than 10 years of combined experience in remodeling, new construction, and disaster restoration along the Gulf Coast from Bradenton to Sanibel Island.</p>
  </div>
</div>

<section>
  <div class="container content-section" style="border-top:none;">
    <div class="content-layout">
      <div class="content-main">
        <h2>Our Story</h2>
        <p>Tropical Bay Builders was built around a simple idea: homeowners shouldn't have to juggle multiple contractors, subcontractors, and restoration specialists to get one project done right. Whether it's a kitchen remodel, a new addition, or storm damage repair, our crew handles the project from first estimate to final walkthrough - one accountable team, start to finish.</p>
        <p>Based in North Port and serving the Gulf Coast from Bradenton and Sarasota down through Fort Myers toward Sanibel Island, we've built our reputation on straightforward estimates, quality craftsmanship, and showing up when we say we will. With a 5.0-star rating across 42 reviews, that reputation is something we work to earn on every single project.</p>

        <h3>What Sets Us Apart</h3>
        <ul class="icon-list">
          <li><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M20 6L9 17l-5-5"/></svg> Licensed &amp; insured general contractor</li>
          <li><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M20 6L9 17l-5-5"/></svg> Free, honest estimates with no pressure</li>
          <li><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M20 6L9 17l-5-5"/></svg> One crew for remodeling, construction &amp; restoration</li>
          <li><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M20 6L9 17l-5-5"/></svg> 5.0-star rating across 42 reviews</li>
          <li><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M20 6L9 17l-5-5"/></svg> Serving North Port &amp; Southwest Florida for 10+ years</li>
        </ul>

        $(Get-CtaStrip -Heading "Ready to start your project?" -Text "Reach out below or give us a call - we'll get back to you quickly." -EventLabel "about_strip_phone")

        <h2 id="contact">Contact Us</h2>
        <p>Have a project in mind, or a question before you commit? Call, email, or send us a message using the form below and we'll follow up as soon as we can.</p>

        <form action="https://formsubmit.co/$Email" method="POST" class="quote-form">
          <input type="hidden" name="_subject" value="New Contact Form Submission - Tropical Bay Builders">
          <input type="hidden" name="_next" value="$SiteUrl/thank-you.html">
          <input type="hidden" name="_captcha" value="true">
          <div class="form-row">
            <div class="form-group"><label for="c-name">Name</label><input type="text" id="c-name" name="Name" required></div>
            <div class="form-group"><label for="c-phone">Phone</label><input type="tel" id="c-phone" name="Phone"></div>
          </div>
          <div class="form-group"><label for="c-email">Email</label><input type="email" id="c-email" name="Email"></div>
          <div class="form-group"><label for="c-message">Message</label><textarea id="c-message" name="Message" rows="4" required></textarea></div>
          <button type="submit" class="btn btn-primary btn-block">Send Message</button>
        </form>
      </div>

      <aside class="quick-facts">
        <h3>Contact Info</h3>
        <dl>
          <div class="fact"><div class="fact-icon"><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72c.127.96.361 1.903.7 2.81a2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45c.907.339 1.85.573 2.81.7A2 2 0 0 1 22 16.92z"/></svg></div><div><dt>Phone</dt><dd><a href="$PhoneTel" onclick="gtag('event','call_click',{'event_category':'engagement','event_label':'about_page_phone_link'})">$Phone</a></dd></div></div>
          <div class="fact"><div class="fact-icon"><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><rect x="2" y="4" width="20" height="16" rx="2"/><path d="M22 6l-10 7L2 6"/></svg></div><div><dt>Email</dt><dd><a href="mailto:$Email">$Email</a></dd></div></div>
          <div class="fact"><div class="fact-icon"><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><path d="M21 10c0 6-9 12-9 12s-9-6-9-12a9 9 0 1 1 18 0z"/><circle cx="12" cy="10" r="3"/></svg></div><div><dt>Based In</dt><dd>North Port, FL</dd></div></div>
          <div class="fact"><div class="fact-icon"><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><circle cx="12" cy="12" r="9"/><path d="M12 7v5l3 3"/></svg></div><div><dt>Hours</dt><dd>Mon-Sat, 7am-7pm</dd></div></div>
        </dl>
      </aside>
    </div>
  </div>
</section>
"@
New-Page -Path (Join-Path $root "about.html") -Title "About &amp; Contact | Tropical Bay Builders" -Desc "Learn about Tropical Bay Builders, a licensed general contractor in North Port, FL, and get in touch for a free estimate." -Canonical "about.html" -Body $aboutBody

Write-Output "Hub pages built: our-services, restoration, service-areas, about"
