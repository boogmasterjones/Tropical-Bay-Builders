. "$PSScriptRoot\parts.ps1"
$root = Split-Path -Parent $PSScriptRoot

function Get-ServiceBody {
    param($s)
    $includedItems = ($s.Included | ForEach-Object { "          <li>$_</li>" }) -join "`n"
    $iconListItems = ($s.IconList | ForEach-Object {
"          <li><svg width=`"18`" height=`"18`" viewBox=`"0 0 24 24`" fill=`"none`" stroke=`"currentColor`" stroke-width=`"2.2`"><path d=`"M20 6L9 17l-5-5`"/></svg> $_</li>"
    }) -join "`n"
    $faqHtml = ($s.Faqs | ForEach-Object {
"          <details class=`"faq-item`"><summary>$($_.Q)<span class=`"faq-icon`"><svg width=`"14`" height=`"14`" viewBox=`"0 0 24 24`" fill=`"none`" stroke=`"currentColor`" stroke-width=`"2.5`"><line x1=`"12`" y1=`"5`" x2=`"12`" y2=`"19`"/><line x1=`"5`" y1=`"12`" x2=`"19`" y2=`"12`"/></svg></span></summary><p>$($_.A)</p></details>"
    }) -join "`n"
    $factsHtml = ($s.Facts | ForEach-Object {
"          <div class=`"fact`"><div class=`"fact-icon`">$($_.Icon)</div><div><dt>$($_.Label)</dt><dd>$($_.Value)</dd></div></div>"
    }) -join "`n"
    $addonItems = ($s.AddOns | ForEach-Object { "          <li><a href=`"$($_.Href)`">$($_.Label)</a></li>" }) -join "`n"

@"
<div class="page-header">
  <div class="container">
    <p class="breadcrumb"><a href="/">Home</a> / $($s.Name)</p>
    <h1>$($s.H1)</h1>
    <p>$($s.Lead)</p>
    <div class="hero-actions">
      <a href="$PhoneTel" class="btn btn-primary" onclick="gtag('event','call_click',{'event_category':'engagement','event_label':'$($s.Slug)_page_phone_button'})">Call $Phone</a>
      <a href="/#quote" class="btn btn-outline-dark">Request a Free Estimate</a>
    </div>
  </div>
</div>

<section>
  <div class="container">
    <div class="grid-2">
      <div>
        <h2>What's Included</h2>
        <p>$($s.WhatsIncludedIntro)</p>
        <ul>
$includedItems
        </ul>
      </div>
      <div>
        <h2>Related Services</h2>
        <p>Since we're already on-site, many homeowners bundle in one of our other services for the same project:</p>
        <ul class="addon-list">
$addonItems
        </ul>
        <p style="margin-top:16px;">Just mention it when you call or fill out the estimate form and we'll include it in your quote.</p>
      </div>
    </div>
$(Get-CtaStrip -Heading "Ready to Get Started?" -Text "Get a free estimate for your home or business in North Port or nearby." -EventLabel "strip_phone_button")
  </div>
</section>

<section class="section-green">
  <div class="container">
    <div class="section-head">
      <span class="eyebrow-dark">Why Homeowners Choose Us</span>
      <h2>A Careful, Local Approach</h2>
    </div>
    <div class="grid-3">
      <div class="card"><h3>Licensed &amp; Insured</h3><p>Work with confidence knowing our crew is licensed and insured for residential and commercial work.</p></div>
      <div class="card"><h3>Free, Honest Estimates</h3><p>No pressure, no gimmicks - just a clear price based on your property's actual scope.</p></div>
      <div class="card"><h3>Satisfaction Guaranteed</h3><p>If something's not right after we leave, tell us and we'll make it right.</p></div>
    </div>
  </div>
</section>

<section>
  <div class="container content-section">
    <h2>$($s.ContentH2)</h2>
    <p>$($s.Content1)</p>
    <p>$($s.Content2)</p>

    <div class="content-layout">
      <div class="content-main">
        <h3>$($s.IconListTitle)</h3>
        <ul class="icon-list">
$iconListItems
        </ul>

        $(Get-CtaStrip -Heading "Ready to Book This Project?" -Text "Get a free, no-obligation estimate today." -EventLabel "strip_phone_button_mid")

        <h3>$($s.H3a)</h3>
        <p>$($s.Content3)</p>
        <div class="callout"><p>"$($s.Callout)"</p></div>

        <h3>$($s.H3b)</h3>
        <p>$($s.Content4)</p>

        <h3>Frequently Asked Questions</h3>
        <div class="faq-list">
$faqHtml
        </div>

        <p>Looking for "$($s.SearchPhrase)"? We're a phone call away, and since we're already serving North Port and the rest of Southwest Florida, scheduling is usually easy to fit in.</p>
      </div>

      <aside class="quick-facts">
        <h3>At a Glance</h3>
        <dl>
$factsHtml
        </dl>
      </aside>
    </div>
  </div>
</section>

<section class="section-orange">
  <div class="container">
    <div class="cta-band">
      <h2>Get a Free $($s.Name) Estimate</h2>
      <p>Tell us about your project and we'll get back to you with a straightforward price - no obligation.</p>
      <div class="cta-actions">
        <a href="$PhoneTel" class="btn btn-outline" onclick="gtag('event','call_click',{'event_category':'engagement','event_label':'$($s.Slug)_cta_phone_button'})">Call $Phone</a>
        <a href="/#quote" class="btn btn-primary">Request a Free Estimate</a>
      </div>
    </div>
  </div>
</section>
"@
}

$services = @(
  @{
    Slug="kitchen-remodeling"; Name="Kitchen Remodeling"
    H1="<em>Kitchen</em> Remodeling in North Port, FL"
    Lead="Custom cabinetry, layouts built for real cooking and entertaining, and finishes that hold up to Florida living - from full gut renovations to targeted refreshes."
    WhatsIncludedIntro="Every kitchen project is priced to your home, but our standard approach covers the full job - not just new cabinet doors. We manage layout, cabinetry, countertops, and finish work as one project instead of a string of separate subcontractors."
    Included=@("Custom and semi-custom cabinetry","Countertop replacement (quartz, granite, butcher block)","Layout changes, island additions, and open-concept conversions","Backsplash, lighting, and plumbing fixture upgrades","Full gut renovations and targeted refreshes","Electrical and plumbing coordination")
    AddOns=@(@{Href="/services/epoxy-flooring.html";Label="Epoxy Flooring"}, @{Href="/services/woodworking.html";Label="Custom Woodworking"}, @{Href="/services/bathroom-remodeling.html";Label="Bathroom Remodeling"})
    ContentH2="Kitchen Remodeling Near Me in North Port"
    Content1="A kitchen remodel is one of the highest-impact projects you can do to a home, and it's also one of the easiest to get wrong. We start with how you actually cook, store, and entertain, then build the layout, cabinetry, and finishes around that - not the other way around. Homes near Wellen Park and the established neighborhoods off Sumter Boulevard often have kitchens from the original build that no longer fit how the space is used today. A layout designed decades ago for a single cook and a closed-off floor plan rarely matches how families actually live now, with open sightlines to the living area and enough counter space for more than one person to work at once."
    Content2="If you've searched 'kitchen remodel near me,' 'kitchen remodeling contractor North Port,' or simply want a straight answer on what a full gut renovation actually costs, here's what to expect from Tropical Bay Builders: a real walkthrough of your kitchen, a written estimate before anything starts, and a crew that manages electrical, plumbing, and finish work as one accountable project. We also flag structural questions early - whether a wall you want removed is load-bearing, for instance - so your design doesn't need to be reworked mid-project once the real conditions behind the drywall are visible."
    IconListTitle="Signs It's Time for a Kitchen Remodel"
    IconList=@("Swelling, warped, or misaligned cabinet doors","Countertop material that's cracked, stained, or dated","A layout that doesn't fit how you actually cook or entertain","Outdated or insufficient lighting and electrical outlets","Visible water damage near the sink, dishwasher, or refrigerator line")
    H3a="How Long Does a Kitchen Remodel Take?"
    Content3="Most full kitchen remodels take four to eight weeks depending on scope, material lead times, and whether we're changing the layout. A cabinet and countertop refresh moves faster; a full gut renovation that relocates plumbing and electrical takes longer. We'll give you a project-specific timeline as part of your estimate, not a generic range. Material lead times can shift that window too - custom cabinetry in particular often has a longer order-to-delivery cycle than the construction work itself, so we build that into your schedule up front rather than letting it surprise you mid-project."
    Callout="Budget is usually the first question homeowners ask, and it's a fair one. We walk every kitchen in person before giving a number, because a phone estimate on a project like this is rarely accurate enough to plan around."
    H3b="What Drives the Cost of a Kitchen Remodel"
    Content4="Cabinetry and countertop material are usually the biggest line items, followed by whether the layout changes (which means moving plumbing and electrical) versus staying in place. Custom cabinetry costs more than semi-custom, and quartz or granite countertops cost more than laminate - but they also hold up better to Florida's humidity over time. We walk through these tradeoffs with you before you commit to anything. Appliance upgrades, lighting packages, and backsplash tile are smaller line items individually, but they add up - we itemize each of these separately in your estimate so you can see exactly where the budget is going and adjust before work starts, not after."
    Faqs=@(
      @{Q="How long does a kitchen remodel take?"; A="Most full kitchen remodels take 4-8 weeks depending on scope, material lead times, and whether we're changing the layout. We'll give you a project-specific timeline as part of your estimate."},
      @{Q="Can I stay in my home during the remodel?"; A="In most cases, yes. We'll walk you through what to expect week to week so you can plan around the work."},
      @{Q="Do you handle permitting?"; A="Yes - we handle the permitting process for any work that requires it, so you don't have to navigate the county process yourself."},
      @{Q="Can you work around a tight budget without cutting corners?"; A="Yes - we'll walk through where semi-custom cabinetry or laminate countertops can stretch your budget further without sacrificing durability, and where it's worth spending more."},
      @{Q="Do you help with design, or just the construction?"; A="Both - we'll talk through layout and material options with you as part of the estimate process, not just show up to build a plan you had to figure out on your own."}
    )
    Facts=@(
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><path d="M21 10c0 6-9 12-9 12s-9-6-9-12a9 9 0 1 1 18 0z"/><circle cx="12" cy="10" r="3"/></svg>'; Label="Service Area"; Value="North Port &amp; Southwest FL"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><circle cx="12" cy="12" r="9"/><path d="M12 7v5l3 3"/></svg>'; Label="Typical Timeline"; Value="4-8 weeks"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><rect x="3" y="4" width="18" height="18" rx="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/></svg>'; Label="Scope"; Value="Full gut or targeted refresh"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><circle cx="12" cy="12" r="9"/><line x1="12" y1="8" x2="12" y2="16"/><line x1="8" y1="12" x2="16" y2="12"/></svg>'; Label="Add-Ons Available"; Value="Epoxy flooring, woodworking"}
    )
    SearchPhrase="kitchen remodeling contractor near me"
  },
  @{
    Slug="bathroom-remodeling"; Name="Bathroom Remodeling"
    H1="<em>Bathroom</em> Remodeling in North Port, FL"
    Lead="Full bathroom renovations - showers, tubs, vanities, and tile - built with proper waterproofing and ventilation for Florida's humidity."
    WhatsIncludedIntro="Every bathroom project is priced to your home, but our standard approach covers tile, vanities, and full layout changes with licensed plumbing and electrical work as part of the same project - not a separate call."
    Included=@("Walk-in shower and tub-to-shower conversions","Custom vanities, tile, and lighting","Proper waterproofing and ventilation for Florida humidity","Accessibility-focused layouts on request","Full layout changes and plumbing relocation","Mold-resistant grout and finish materials")
    AddOns=@(@{Href="/services/kitchen-remodeling.html";Label="Kitchen Remodeling"}, @{Href="/services/epoxy-flooring.html";Label="Epoxy Flooring"}, @{Href="/services/woodworking.html";Label="Custom Woodworking"})
    ContentH2="Bathroom Remodeling Near Me in North Port"
    Content1="Florida's humidity is unforgiving on a poorly-built bathroom. We use proper waterproofing, ventilation, and materials suited to the climate, whether you're updating a guest bath or converting a primary bathroom into a spa-style retreat. Bathrooms fail quietly here before they fail visibly - grout that's discolored, a shower pan that feels soft, or a persistent musty smell are usually signs moisture has already gotten past the surface finish. By the time those signs show up, there's a good chance the substrate underneath has already been compromised, which is why we check for hidden moisture damage before starting any demo, not after."
    Content2="If you're searching 'bathroom remodel near me' or 'walk-in shower conversion North Port,' here's what to expect: a real walkthrough, a written estimate, and a crew that catches waterproofing issues before they become a bigger problem down the line - not after the tile is already up. We also talk through layout early, since even a modest bathroom can often gain real usable space just by rethinking where the vanity, shower, and storage sit relative to each other."
    IconListTitle="What to Think About Before You Remodel"
    IconList=@("Musty odors or discoloration around tile grout lines","A shower pan or floor that feels soft or uneven","Fixtures and vanities that are original to an older home","Interest in a curbless shower or aging-in-place features","Poor ventilation causing lingering condensation on mirrors or walls")
    H3a="Tub-to-Shower Conversions"
    Content3="Tub-to-shower conversions are one of our most requested bathroom projects. We handle the plumbing, waterproofing, and tile work as one job, and can build in features like a curbless entry or grab bar blocking if you're planning ahead for aging in place - details that are far easier to build in from the start than retrofit later. We also size the shower valve and drainage correctly for the new footprint, since a conversion that simply drops a shower pan into an old tub opening without adjusting for it often ends up with slower drainage than the room deserves."
    Callout="If you're planning to age in place or want the bathroom to work for family members with different mobility needs, that's worth raising early - it doesn't have to look institutional to be functional."
    H3b="Moisture &amp; Mold Prevention"
    Content4="We use proper waterproofing membranes, correct slope-to-drain tile work, and adequate ventilation - details that matter more in Florida's climate than almost anywhere else. Skipping any one of these is usually what causes a bathroom remodel to fail within a few years instead of lasting a decade or more. Exhaust fans are also frequently undersized relative to the room, which sounds minor but is one of the most common reasons a otherwise well-built bathroom still develops mildew along the ceiling line within a year or two."
    Faqs=@(
      @{Q="Can you convert my tub into a walk-in shower?"; A="Yes, tub-to-shower conversions are one of our most requested bathroom projects - we handle the plumbing, waterproofing, and tile work as one job."},
      @{Q="Do you replace vanities and fixtures only, without a full remodel?"; A="Yes, we take on smaller-scope updates as well as full renovations - let us know your goals and budget and we'll scope it accordingly."},
      @{Q="How do you handle moisture and mold prevention?"; A="We use proper waterproofing membranes, correct slope-to-drain tile work, and adequate ventilation - details that matter more in Florida's climate than almost anywhere else."},
      @{Q="How long does a bathroom remodel typically take?"; A="Most bathroom remodels run 2-5 weeks depending on scope. A vanity and fixture refresh moves faster; a full layout change with new plumbing runs longer."},
      @{Q="Do you handle secondary and guest bathrooms, not just primary suites?"; A="Yes - guest bath and secondary bathroom updates are a regular part of our work, whether as a standalone project or bundled with a larger remodel."}
    )
    Facts=@(
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><path d="M21 10c0 6-9 12-9 12s-9-6-9-12a9 9 0 1 1 18 0z"/><circle cx="12" cy="10" r="3"/></svg>'; Label="Service Area"; Value="North Port &amp; Southwest FL"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><circle cx="12" cy="12" r="9"/><path d="M12 7v5l3 3"/></svg>'; Label="Typical Timeline"; Value="2-5 weeks"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><rect x="3" y="4" width="18" height="18" rx="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/></svg>'; Label="Popular Upgrade"; Value="Tub-to-shower conversion"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><circle cx="12" cy="12" r="9"/><line x1="12" y1="8" x2="12" y2="16"/><line x1="8" y1="12" x2="16" y2="12"/></svg>'; Label="Add-Ons Available"; Value="Epoxy flooring, woodworking"}
    )
    SearchPhrase="bathroom remodeling contractor near me"
  },
  @{
    Slug="new-construction"; Name="New Construction"
    H1="<em>New</em> Home Construction in Southwest Florida"
    Lead="Ground-up builds and major additions managed by one accountable general contractor, permitting and site work included start to finish."
    WhatsIncludedIntro="New construction is the most involved project a homeowner can take on, which is why it matters who's managing it. We oversee the full process as one accountable general contractor - not a rotating cast of subcontractors."
    Included=@("Full ground-up residential construction","Permitting and inspections management","Additions and structural expansions","Site work coordination from foundation to finish","Framing, systems rough-in, and finish-out","Regular progress updates through completion")
    AddOns=@(@{Href="/services/exterior-remodel-additions.html";Label="Exterior Remodel & Additions"}, @{Href="/services/roofing.html";Label="Roofing"}, @{Href="/services/driveways-patios.html";Label="Driveways & Patios"})
    ContentH2="New Home Construction Near Me in North Port"
    Content1="New construction moves through a fairly predictable sequence: site prep and permitting, foundation, framing, dried-in (roof and exterior sealed), then rough-in for plumbing, electrical, and HVAC, followed by insulation, drywall, and finish work. Permitting timelines vary by county and can be one of the longer waits in the process, which is why we start that paperwork as early as possible. Soil conditions and flood elevation requirements also factor into the foundation phase more in this part of Florida than in many other markets, and we account for that during site prep rather than treating it as an afterthought once the slab is already planned."
    Content2="If you're searching 'new home builder near me' or 'general contractor for new construction North Port,' here's what matters most: who's actually managing your project day to day, and whether they coordinate the trades directly or just hand you a list of subcontractors to call yourself. We do the former. That distinction matters most when something doesn't go according to plan mid-build - a single accountable contractor can adjust the schedule and resolve the issue directly, where a homeowner managing separate subcontractors is often left coordinating the fix themselves."
    IconListTitle="How a New Build Timeline Actually Works"
    IconList=@("Site work and permitting, including county-specific requirements","Foundation and framing, weather-dependent scheduling","Dried-in stage: roof and exterior sealed against the elements","Rough-in for plumbing, electrical, and HVAC systems","Insulation, drywall, and finish work through final walkthrough")
    H3a="Weather &amp; Realistic Timelines"
    Content3="Florida's rainy season can push back site work and exterior phases, and a contractor who tells you an exact move-in date before permits are even pulled is usually setting an expectation they can't control. We give you a realistic range up front and keep you updated as each phase closes out, rather than a single date that's likely to slip. Inspections at each stage - foundation, framing, rough-in, and final - also add scheduled checkpoints into the timeline, and a failed inspection at any one of those stages can add days or weeks, which is exactly why we build in buffer rather than promising a razor-thin schedule."
    Callout="A contractor who manages the work directly - rather than handing you off between subcontractors - is generally in a better position to catch problems early and stand behind the finished result."
    H3b="Additions &amp; Structural Expansions"
    Content4="Whether it's a new home, a guest house, or a major structural addition, we coordinate the trades and keep you informed at every stage instead of leaving you to manage subcontractors yourself. Additions follow much of the same permitting and inspection process as a full new build, just at a smaller scale. Tying new structural work into an existing foundation and roofline also takes more care than it might seem from the outside, since the new and old systems need to work together rather than just sit side by side."
    Faqs=@(
      @{Q="Do you build custom homes from scratch?"; A="Yes - we manage new construction from permitting through final finish-out, working with your plans or helping coordinate design."},
      @{Q="How involved will I be in the process?"; A="As much or as little as you'd like. We provide regular updates and are available to walk the site with you at key milestones."},
      @{Q="Do you handle additions as well as full new builds?"; A="Yes, structural additions and expansions are a regular part of our new construction work."},
      @{Q="What causes new construction timelines to slip most often?"; A="Permitting delays and failed inspections are the two most common causes. We build buffer into our estimated timeline to account for both rather than promising an overly tight schedule."},
      @{Q="Do you handle site work like clearing and grading?"; A="Yes - site work is part of the new construction process we manage, coordinated alongside permitting and foundation work rather than treated as a separate project."}
    )
    Facts=@(
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><path d="M21 10c0 6-9 12-9 12s-9-6-9-12a9 9 0 1 1 18 0z"/><circle cx="12" cy="10" r="3"/></svg>'; Label="Service Area"; Value="North Port &amp; Southwest FL"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><circle cx="12" cy="12" r="9"/><path d="M12 7v5l3 3"/></svg>'; Label="Typical Timeline"; Value="6-12+ months"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><rect x="3" y="4" width="18" height="18" rx="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/></svg>'; Label="Scope"; Value="Full builds &amp; additions"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><circle cx="12" cy="12" r="9"/><line x1="12" y1="8" x2="12" y2="16"/><line x1="8" y1="12" x2="16" y2="12"/></svg>'; Label="Permitting"; Value="Fully managed for you"}
    )
    SearchPhrase="new construction general contractor near me"
  },
  @{
    Slug="exterior-remodel-additions"; Name="Exterior Remodel & Additions"
    H1="<em>Exterior</em> Remodeling &amp; Home Additions"
    Lead="Siding, room additions, lanai enclosures, and outdoor living upgrades that boost curb appeal and everyday livability."
    WhatsIncludedIntro="Your home's exterior takes the brunt of Florida's sun, humidity, and storm seasons. We handle exterior remodels and additions with materials and construction methods built for the local climate."
    Included=@("Room additions and lanai/outdoor living enclosures","Siding, exterior paint, and trim replacement","Structural expansions tied into existing framing","Outdoor living spaces built for entertaining","Matching new construction to existing exterior","Permitting for structural changes")
    AddOns=@(@{Href="/services/new-construction.html";Label="New Construction"}, @{Href="/services/roofing.html";Label="Roofing"}, @{Href="/services/fences.html";Label="Fences"})
    ContentH2="Exterior Remodeling Near Me in North Port"
    Content1="An addition changes your home's structure, which means it almost always requires a permit and, in many cases, an updated survey or engineering review, especially if it affects your roofline or foundation footprint. Setback requirements from your property line vary by municipality, so what's possible on one lot isn't automatically possible on the one next door. Corner lots and waterfront-adjacent properties often carry additional restrictions beyond a standard interior lot, which is another reason we confirm what's actually buildable before you fall in love with a specific design."
    Content2="If you're searching 'home addition contractor near me' or 'lanai enclosure North Port,' here's what to expect: we check zoning and setback constraints early, so you're not designing around a problem that shows up after the fact. Exterior material choices matter just as much as the structural plan - Florida's sun and humidity are hard on paint, siding, and trim, and we default to materials rated for that exposure rather than whatever looks best in a showroom that isn't dealing with year-round heat and moisture."
    IconListTitle="Planning an Addition or Exterior Remodel"
    IconList=@("Setback and zoning requirements specific to your property","Whether an updated survey or engineering review is needed","Matching siding, trim, and roofline to the existing structure","Tying new electrical and HVAC into existing systems","Realistic sequencing so the rest of the home stays livable during work")
    H3a="Lanai &amp; Porch Enclosures"
    Content3="Lanai and porch enclosures are a common project for us, including tying in electrical and matching existing rooflines. Matching new construction to an existing home is as much about the details as the big strokes - siding profile, trim reveal, paint sheen, and roofline pitch all need to line up closely enough that the addition reads as part of the house. We also check that the enclosure's new HVAC load doesn't overwork your existing system, since converting an open lanai into conditioned living space changes the square footage your air conditioning has to cover."
    Callout="We take measurements and photograph existing materials before ordering anything new, so the finished addition doesn't read as an obvious add-on."
    H3b="Permitting for Additions"
    Content4="Most structural additions require a permit - we handle the permitting process as part of the project so you don't have to navigate the county process yourself. Timelines vary depending on your specific municipality and the scope of the addition. We also confirm your homeowners insurance carrier is aware of any structural changes before final walkthrough, since an unreported addition can occasionally complicate a future claim. That's true even for what looks like a modest exterior project - a full siding replacement or a new roofline detail can still require permitting depending on scope, which is another reason we confirm requirements before finalizing your estimate rather than after."
    Faqs=@(
      @{Q="Can you enclose my existing lanai or porch?"; A="Yes, lanai and porch enclosures are a common project for us, including tying in electrical and matching existing rooflines."},
      @{Q="Do additions require a permit?"; A="Most structural additions do - we handle the permitting process as part of the project."},
      @{Q="Can you match new construction to my home's existing exterior?"; A="Yes, matching siding, trim, and rooflines to your existing structure is standard practice on every addition we build."},
      @{Q="Will an enclosed lanai need additional HVAC capacity?"; A="Often, yes, if you're converting it to conditioned space. We check your existing system's capacity as part of the planning process so it isn't overworked after the addition is complete."},
      @{Q="Does a full siding replacement require a permit?"; A="Often, yes, depending on the scope and your specific municipality. We confirm this as part of your estimate so there are no surprises once work is scheduled."}
    )
    Facts=@(
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><path d="M21 10c0 6-9 12-9 12s-9-6-9-12a9 9 0 1 1 18 0z"/><circle cx="12" cy="10" r="3"/></svg>'; Label="Service Area"; Value="North Port &amp; Southwest FL"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><circle cx="12" cy="12" r="9"/><path d="M12 7v5l3 3"/></svg>'; Label="Typical Timeline"; Value="4-10 weeks"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><rect x="3" y="4" width="18" height="18" rx="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/></svg>'; Label="Popular Project"; Value="Lanai enclosures"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><circle cx="12" cy="12" r="9"/><line x1="12" y1="8" x2="12" y2="16"/><line x1="8" y1="12" x2="16" y2="12"/></svg>'; Label="Permitting"; Value="Fully managed for you"}
    )
    SearchPhrase="home addition contractor near me"
  },
  @{
    Slug="roofing"; Name="Roofing"
    H1="<em>Roofing</em> Services in North Port, FL"
    Lead="Roof repairs, full replacements, and storm-ready installations built to handle Southwest Florida's wind and rain."
    WhatsIncludedIntro="Your roof is your home's first line of defense during Southwest Florida's storm season. We handle repairs and full replacements using materials and installation methods rated for local wind and rain conditions."
    Included=@("Roof repair and full replacement","Shingle, tile, and metal roofing options","Storm-related roof damage assessment","Coordination with insurance documentation","Wind-load rated installation methods","Post-storm emergency tarping")
    AddOns=@(@{Href="/restoration/storm-damage-restoration.html";Label="Storm Damage Restoration"}, @{Href="/services/exterior-remodel-additions.html";Label="Exterior Remodel & Additions"}, @{Href="/services/fences.html";Label="Fences"})
    ContentH2="Roofing Near Me in North Port"
    Content1="Not every roof issue means a full replacement, but ignoring small signs tends to turn a repair into one anyway. Missing or curling shingles, granules collecting in gutters, and small ceiling stains are often repairable if caught early. A roof nearing the end of its rated lifespan, widespread shingle damage after a storm, or soft spots in the decking usually point toward replacement being the more cost-effective long-term call. Waiting on a marginal roof rarely saves money in the long run - what starts as a contained leak can spread into decking and framing damage that costs far more to repair than the roof work would have on its own."
    Content2="If you're searching 'roof repair near me' or 'roofing contractor North Port,' here's what to expect: a straightforward assessment, clear documentation if you're filing an insurance claim, and a crew that tells you honestly whether you need a repair or a replacement. We also check attic ventilation as part of any roofing assessment, since inadequate airflow shortens shingle life regardless of how well the roofing material itself was installed. That assessment also includes checking flashing around vents, chimneys, and skylights, since those transition points are where the majority of roof leaks actually originate rather than the field of the roof itself."
    IconListTitle="Signs You Need a Repair vs. a Full Replacement"
    IconList=@("Curling, cracked, or missing shingles in multiple areas","Granules collecting in gutters or at downspouts","Ceiling stains or visible daylight through the attic","A roof approaching or past its rated lifespan","Soft spots or sagging in the roof deck")
    H3a="How Long Does a Florida Roof Last?"
    Content3="Most asphalt shingle roofs in Florida are rated for 20-25 years, but the real-world lifespan is often shorter given the sun exposure and storm frequency here. If your roof is past that window and you're facing a major repair, it's worth getting a straight answer on whether that money is better spent on a full replacement instead. Metal and tile roofs generally outlast shingle by a wide margin, though the upfront cost is higher, which is a tradeoff worth weighing if you're already looking at a full replacement rather than a repair."
    Callout="A roof repair after storm damage is one of our most common calls - see our Storm Damage Restoration page for the broader storm-response process if your issue goes beyond just the roof."
    H3b="Materials: Shingle, Tile &amp; Metal"
    Content4="We work with shingle, tile, and metal roofing systems and can advise on the best fit for your home and budget. Metal holds up longest against wind and requires the least maintenance; tile is common in this region and pairs well with certain architectural styles; shingle remains the most budget-friendly option for most homes. Whichever material you choose, proper installation - correct nailing pattern, underlayment, and flashing around penetrations - matters more to how the roof performs in a storm than the material choice alone."
    Faqs=@(
      @{Q="Do you repair storm-damaged roofs?"; A="Yes - roof repair after storm damage is one of our most common calls. See our Storm Damage Restoration page for the broader storm-response process."},
      @{Q="What roofing materials do you install?"; A="We work with shingle, tile, and metal roofing systems and can advise on the best fit for your home and budget."},
      @{Q="Can you help document damage for an insurance claim?"; A="We can provide a clear damage assessment to support your claim, though the claim itself is handled between you and your insurer."},
      @{Q="Does a new roof qualify for a wind mitigation insurance discount?"; A="Often, yes - many insurers offer a discount for a roof built to current wind mitigation standards. Ask us for documentation of the installation to submit to your insurer."},
      @{Q="Can you give me a straight answer on repair vs. replacement?"; A="Yes - we assess the roof in person and tell you honestly which makes more financial sense, rather than defaulting to whichever job pays more."}
    )
    Facts=@(
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><path d="M21 10c0 6-9 12-9 12s-9-6-9-12a9 9 0 1 1 18 0z"/><circle cx="12" cy="10" r="3"/></svg>'; Label="Service Area"; Value="North Port &amp; Southwest FL"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><circle cx="12" cy="12" r="9"/><path d="M12 7v5l3 3"/></svg>'; Label="Typical Lifespan"; Value="20-25 years (shingle)"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><rect x="3" y="4" width="18" height="18" rx="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/></svg>'; Label="Materials"; Value="Shingle, tile, metal"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><circle cx="12" cy="12" r="9"/><line x1="12" y1="8" x2="12" y2="16"/><line x1="8" y1="12" x2="16" y2="12"/></svg>'; Label="Emergency Tarping"; Value="Available after storms"}
    )
    SearchPhrase="roofing contractor near me"
  },
  @{
    Slug="fences"; Name="Fences"
    H1="<em>Fence</em> Installation in Southwest Florida"
    Lead="Privacy, picket, and pool-code-compliant fencing in vinyl, aluminum, and wood, installed to hold up through Southwest Florida's heat, salt air, and storm-force wind."
    WhatsIncludedIntro="A fence in Southwest Florida has to handle sun, salt air, and storm-force wind - not just look good on install day. We install fencing using materials and hardware suited to the local climate."
    Included=@("Privacy, picket, and pool-code-compliant fencing","Vinyl, aluminum, and wood fencing options","Property-line surveys coordination","Gate and hardware installation","Pool safety code compliance","Corrosion-resistant hardware for coastal exposure")
    AddOns=@(@{Href="/services/driveways-patios.html";Label="Driveways & Patios"}, @{Href="/services/exterior-remodel-additions.html";Label="Exterior Remodel & Additions"}, @{Href="/services/new-construction.html";Label="New Construction"})
    ContentH2="Fence Installation Near Me in North Port"
    Content1="Vinyl, aluminum, and wood each hold up differently against Florida's sun, humidity, and salt air, and the right choice usually comes down to what you're prioritizing. Vinyl resists moisture and doesn't need repainting, but can become brittle with extended UV exposure over many years. Aluminum handles coastal salt air well and works especially well for pool enclosures since it doesn't obstruct sightlines. Wood offers a look that vinyl and aluminum can't fully replicate, but it needs more regular upkeep - sealing and occasional board replacement - to hold up against Florida's humidity and insect pressure over time."
    Content2="If you're searching 'fence installation near me' or 'pool fence contractor North Port,' here's what matters most: getting the material choice and the pool safety code requirements right the first time, since redoing a fence is a lot more expensive than doing it correctly up front. We also check HOA restrictions where applicable before finalizing material and height, since some communities have their own fencing guidelines layered on top of county code."
    IconListTitle="Choosing the Right Fence Material for Florida"
    IconList=@("Vinyl: low maintenance, resists moisture, can become brittle over decades of UV exposure","Aluminum: strong against salt air, doesn't obstruct pool sightlines","Wood: traditional look, needs more upkeep against rot and insects in humidity","Pool fencing must meet Florida height and self-latching gate code requirements","Property-line accuracy matters more than most homeowners expect")
    H3a="Pool Fencing &amp; Florida Code"
    Content3="Pool fencing specifically has to meet Florida's safety code requirements for height, gate self-closing and self-latching hardware, and gaps between pickets. These aren't optional upgrades - they're inspected, and getting them wrong can hold up your pool's certificate of completion. We build every pool fence to pass inspection on the first try, checking gate hardware and picket spacing against the current code before the job is called finished, not after an inspector flags it."
    Callout="We build to code from the start so pool fencing isn't something you have to revisit later after a failed inspection."
    H3b="Property Lines &amp; Surveys"
    Content4="We coordinate to your existing property survey, or can advise on getting one if it's not current. Building on an inaccurate assumption about where the property line sits is one of the most common - and most expensive - fencing mistakes homeowners make. A fence built even a foot over the line can turn into a dispute with a neighbor or a required removal down the road, which is a far more costly problem than the small delay of confirming the survey first. Underground utility lines are another thing worth confirming before any post holes go in - we call for a utility locate ahead of installation so a fence line doesn't end up cutting through a buried cable or irrigation line."
    Faqs=@(
      @{Q="Do you install pool-code-compliant fencing?"; A="Yes, we install fencing that meets Florida pool safety code requirements for height and gate latching."},
      @{Q="What fencing materials hold up best in Florida?"; A="Vinyl and aluminum tend to handle humidity and salt air with the least maintenance; we'll walk you through the tradeoffs for your property."},
      @{Q="Can you match a fence to an existing property line survey?"; A="Yes - we coordinate to your existing survey, or can advise on getting one if it's not current."},
      @{Q="Do you check HOA rules before installing a fence?"; A="Where applicable, yes - we confirm any HOA material or height restrictions before finalizing your fence design."},
      @{Q="Do you call for a utility locate before digging post holes?"; A="Yes - we schedule a utility locate ahead of any fence installation so post holes don't risk hitting a buried line."}
    )
    Facts=@(
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><path d="M21 10c0 6-9 12-9 12s-9-6-9-12a9 9 0 1 1 18 0z"/><circle cx="12" cy="10" r="3"/></svg>'; Label="Service Area"; Value="North Port &amp; Southwest FL"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><circle cx="12" cy="12" r="9"/><path d="M12 7v5l3 3"/></svg>'; Label="Typical Timeline"; Value="1-2 weeks"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><rect x="3" y="4" width="18" height="18" rx="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/></svg>'; Label="Materials"; Value="Vinyl, aluminum, wood"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><circle cx="12" cy="12" r="9"/><line x1="12" y1="8" x2="12" y2="16"/><line x1="8" y1="12" x2="16" y2="12"/></svg>'; Label="Pool Code"; Value="Built to Florida code"}
    )
    SearchPhrase="fence installation contractor near me"
  },
  @{
    Slug="driveways-patios"; Name="Driveways & Patios"
    H1="<em>Driveways</em> &amp; Patios in Southwest Florida"
    Lead="Concrete and paver driveways, patios, and outdoor living hardscaping, built with proper base prep and drainage for Southwest Florida's heat and heavy rain."
    WhatsIncludedIntro="Driveways and patios take constant sun exposure and heavy rain in Florida, so proper base preparation and drainage matter as much as the finished surface. We handle both the groundwork and the finish work as one project."
    Included=@("Concrete and paver driveway installation","Patio and outdoor living hardscaping","Proper base prep and drainage planning","Repair and resurfacing of existing driveways","Sealing for concrete and pavers","Grading to prevent pooling")
    AddOns=@(@{Href="/services/fences.html";Label="Fences"}, @{Href="/services/epoxy-flooring.html";Label="Epoxy Flooring"}, @{Href="/services/exterior-remodel-additions.html";Label="Exterior Remodel & Additions"})
    ContentH2="Driveways &amp; Patios Near Me in North Port"
    Content1="Concrete is typically the more budget-friendly option upfront and installs faster, but it's a single continuous slab, so a crack usually means patching a visible repair or replacing a section. Pavers cost more initially but offer more design flexibility in pattern and color, and because they're individual units, a damaged paver can be popped out and replaced without disturbing the rest of the surface. Stamped and decorative concrete finishes can close some of that design gap for homeowners who prefer concrete's lower cost but still want a more distinctive look than a plain broom finish."
    Content2="If you're searching 'driveway installation near me' or 'paver patio contractor North Port,' here's what matters most: proper base compaction and drainage, which is what actually determines whether your new surface lasts or starts sinking and cracking within a few years. We also grade every new driveway and patio to direct water away from your foundation, since standing water against a slab edge is a common cause of long-term cracking that has nothing to do with the surface material itself."
    IconListTitle="Concrete vs. Pavers: Which Is Right for You"
    IconList=@("Concrete: lower upfront cost, faster install, repairs are more visible","Pavers: higher design flexibility, individual units are easier to spot-repair","Proper base compaction prevents sinking and cracking over time","Drainage planning matters as much as the surface material in Florida's rain","Sealing extends the life and appearance of both concrete and pavers")
    H3a="Why Base Prep Matters Most"
    Content3="Whichever material you choose, the base preparation underneath matters more than the surface material itself for how the job holds up. Florida's sandy soil and heavy seasonal rain mean proper compaction and drainage planning are what actually prevent the sinking, pooling, and cracking that shorten a driveway or patio's life. We compact the base in stages rather than all at once, which is a slower process but produces a far more stable foundation than compacting a thick layer of fill in a single pass."
    Callout="We don't cut corners on base prep even though it's invisible once the job is done - it's the single biggest factor in whether your investment lasts 5 years or 25."
    H3b="Repairing an Existing Driveway"
    Content4="We assess and repair or resurface existing driveways in addition to new installations. A cracked or sinking driveway doesn't always need full replacement - sometimes a section repair or resurfacing extends its life for years at a fraction of the cost. We'll tell you honestly when a repair makes sense versus when the underlying base has failed broadly enough that a repair would just be a short-term fix."
    Faqs=@(
      @{Q="Do you repair cracked or sinking driveways?"; A="Yes, we assess and repair or resurface existing driveways in addition to new installations."},
      @{Q="What's the difference between concrete and pavers?"; A="Concrete is typically more budget-friendly upfront; pavers offer more design flexibility and easier spot repairs. We'll help you weigh the tradeoffs for your project and budget."},
      @{Q="Can you build a patio as part of a larger outdoor living project?"; A="Yes - patios are often paired with our exterior remodel and addition work for a full outdoor living upgrade."},
      @{Q="Do you offer stamped or decorative concrete finishes?"; A="Yes, stamped and decorative concrete is available for homeowners who want more visual interest than a standard broom finish without the cost of pavers."},
      @{Q="How do you handle drainage on a sloped or low-lying lot?"; A="We grade and plan drainage specific to your lot's actual conditions - a low-lying property needs a different approach than a lot with natural fall away from the house."}
    )
    Facts=@(
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><path d="M21 10c0 6-9 12-9 12s-9-6-9-12a9 9 0 1 1 18 0z"/><circle cx="12" cy="10" r="3"/></svg>'; Label="Service Area"; Value="North Port &amp; Southwest FL"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><circle cx="12" cy="12" r="9"/><path d="M12 7v5l3 3"/></svg>'; Label="Typical Timeline"; Value="3-7 days"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><rect x="3" y="4" width="18" height="18" rx="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/></svg>'; Label="Materials"; Value="Concrete, pavers"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><circle cx="12" cy="12" r="9"/><line x1="12" y1="8" x2="12" y2="16"/><line x1="8" y1="12" x2="16" y2="12"/></svg>'; Label="Repairs"; Value="Resurfacing available"}
    )
    SearchPhrase="driveway and patio contractor near me"
  },
  @{
    Slug="epoxy-flooring"; Name="Epoxy Flooring"
    H1="<em>Epoxy</em> Floor Coating in Southwest Florida"
    Lead="Durable, low-maintenance epoxy floor coatings for garages, workshops, patios, and interior floors, installed with proper surface prep so the finish actually lasts."
    WhatsIncludedIntro="Epoxy floor coatings hold up to heat, moisture, and heavy use better than bare concrete - and they look sharp doing it. We install epoxy coatings for garages, workshops, patios, and select interior spaces."
    Included=@("Garage and workshop floor coatings","Patio and lanai epoxy and coating systems","Decorative flake and solid-color finishes","Proper surface grinding and prep included","UV-stable topcoat options for sun exposure","Crack and moisture assessment before coating")
    AddOns=@(@{Href="/services/driveways-patios.html";Label="Driveways & Patios"}, @{Href="/services/kitchen-remodeling.html";Label="Kitchen Remodeling"}, @{Href="/services/woodworking.html";Label="Custom Woodworking"})
    ContentH2="Epoxy Flooring Near Me in North Port"
    Content1="Epoxy performs best on garage floors, workshops, and covered patios or lanais where it's protected from direct, prolonged UV exposure, which can cause standard epoxy to yellow or degrade over time outdoors. For fully exposed outdoor surfaces, we'll talk through UV-stable topcoat options or whether a different material might actually serve you better long-term. Garages in particular benefit from epoxy's resistance to oil, road salt, and the general wear of daily vehicle traffic - conditions that break down bare, unsealed concrete far faster than most homeowners expect."
    Content2="If you're searching 'epoxy garage floor near me' or 'epoxy flooring contractor North Port,' here's what matters most: surface prep. The single biggest factor in how long an epoxy floor lasts is what happens before the coating ever goes down. We test for moisture vapor coming up through the slab before starting, since epoxy applied over a slab with an active moisture problem is one of the most common causes of coating failure - regardless of how well the coating itself is applied."
    IconListTitle="Where Epoxy Flooring Makes the Most Sense"
    IconList=@("Best suited for garages, workshops, and covered patios or lanais","Direct sun exposure requires UV-stable topcoat options to prevent yellowing","Proper surface grinding is the biggest factor in how long the coating lasts","Existing cracks or moisture issues need to be addressed before coating","Decorative flake finishes hide minor surface imperfections better than solid color")
    H3a="How Long Does Epoxy Flooring Last?"
    Content3="A properly prepped and installed epoxy floor can last many years with normal use - proper surface prep is the biggest factor in longevity. Concrete needs to be properly ground to open the surface pores, any cracks or moisture issues need to be addressed, and the slab needs adequate cure time. We grind rather than acid-etch before coating, since mechanical grinding produces a more consistent surface profile for the epoxy to bond to than a chemical etch alone."
    Callout="Skipping surface prep is why some epoxy jobs peel or bubble within a year or two - it's the step we spend the most time on regardless of how straightforward the finish coat looks."
    H3b="Decorative Flake vs. Solid Color"
    Content4="We offer both solid-color and decorative flake epoxy systems depending on your look and budget. Flake finishes tend to hide minor surface imperfections and daily wear better than solid color, which is why they're popular for garage floors that see heavy use. Solid color gives a cleaner, more uniform look that some homeowners prefer for workshop or showroom-style spaces where hiding wear is less of a priority than a polished appearance."
    Faqs=@(
      @{Q="How long does epoxy flooring last?"; A="A properly prepped and installed epoxy floor can last many years with normal use - proper surface prep is the biggest factor in longevity."},
      @{Q="Can epoxy be applied over an existing damaged floor?"; A="It depends on the condition - we assess the slab first and grind/repair as needed before coating."},
      @{Q="Do you offer decorative flake finishes?"; A="Yes, we offer both solid-color and decorative flake epoxy systems depending on your look and budget."},
      @{Q="Will you test for moisture in the slab before coating?"; A="Yes - we test for moisture vapor coming up through the concrete before starting, since coating over an active moisture issue is one of the most common causes of epoxy failure."},
      @{Q="How long before I can use the space after coating?"; A="Light foot traffic is usually fine within a day or two, but full cure for heavy use like vehicle traffic typically takes closer to a week - we'll give you a specific timeline for your project."}
    )
    Facts=@(
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><path d="M21 10c0 6-9 12-9 12s-9-6-9-12a9 9 0 1 1 18 0z"/><circle cx="12" cy="10" r="3"/></svg>'; Label="Service Area"; Value="North Port &amp; Southwest FL"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><circle cx="12" cy="12" r="9"/><path d="M12 7v5l3 3"/></svg>'; Label="Typical Timeline"; Value="1-3 days"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><rect x="3" y="4" width="18" height="18" rx="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/></svg>'; Label="Best For"; Value="Garages, workshops, lanais"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><circle cx="12" cy="12" r="9"/><line x1="12" y1="8" x2="12" y2="16"/><line x1="8" y1="12" x2="16" y2="12"/></svg>'; Label="Finishes"; Value="Solid color or flake"}
    )
    SearchPhrase="epoxy garage floor contractor near me"
  },
  @{
    Slug="woodworking"; Name="Custom Woodworking"
    H1="<em>Custom</em> Woodworking in Southwest Florida"
    Lead="Custom cabinetry, built-in shelving, closet systems, and trim work finished to a fine standard, built with materials suited to Florida's humidity."
    WhatsIncludedIntro="Custom woodworking covers a wide range, from a single built-in bookshelf to a full kitchen's worth of cabinetry. The common thread is that it's built to fit your specific space exactly."
    Included=@("Custom cabinetry and built-in shelving","Trim, millwork, and crown molding","Closet and pantry built-ins","Furniture-grade finish work","Materials chosen for Florida humidity","Standalone projects or bundled with remodels")
    AddOns=@(@{Href="/services/kitchen-remodeling.html";Label="Kitchen Remodeling"}, @{Href="/services/bathroom-remodeling.html";Label="Bathroom Remodeling"}, @{Href="/services/new-construction.html";Label="New Construction"})
    ContentH2="Custom Woodworking Near Me in North Port"
    Content1="Custom woodworking is where a remodel goes from 'done' to 'done right.' We build custom cabinetry, built-in shelving, trim, and millwork as part of a larger remodel or as standalone projects. That matters especially in older Florida homes, where walls and floors are rarely perfectly square, and off-the-shelf cabinetry often leaves gaps that a custom build simply doesn't. Prefabricated cabinetry is built to standard dimensions that assume a perfectly level, square space - a rare thing in a home that's settled over a few decades - so filler panels and visible gaps are common with off-the-shelf options in a way they simply aren't with a custom-built piece."
    Content2="If you're searching 'custom cabinetry near me' or 'built-in shelving contractor North Port,' here's what sets our work apart: materials chosen specifically for Florida's humidity, not just appearance. We also build with future maintenance in mind - hardware that can be re-tightened rather than replaced, and finishes that can be touched up rather than fully refinished when normal wear shows up years down the line."
    IconListTitle="What's Possible in a Florida Home"
    IconList=@("Built-in shelving, media centers, and closet systems","Custom kitchen and bathroom cabinetry to exact dimensions","Trim, crown molding, and millwork matched to existing profiles","Materials chosen for Florida humidity, not just appearance","Standalone projects welcome, not just add-ons to larger remodels")
    H3a="Materials That Handle Florida Humidity"
    Content3="We favor sealed hardwoods and marine-grade plywood over particleboard for anything near a kitchen, bathroom, or exterior wall, since Florida's humidity will find and exploit any weak point in a cheaper material over time. It costs more upfront but saves you from watching cabinetry swell and warp within a few years. We also seal all six sides of every panel, including the edges and back that installers commonly skip, since an unsealed edge is often where moisture first gets in even on an otherwise well-built piece."
    Callout="Off-the-shelf cabinetry rarely accounts for the fact that older homes are almost never perfectly square - a custom build solves that problem instead of leaving visible gaps."
    H3b="Matching Existing Cabinetry"
    Content4="We can match existing cabinetry style and finish, or design something entirely new. Closet and pantry built-ins are also a regular part of our woodworking projects, whether as a standalone job or bundled into a larger remodel. Trim and millwork matching is one of the trickier parts of an older-home renovation, since profiles that were common decades ago aren't always available off the shelf today - we can often replicate a discontinued profile rather than forcing a mismatched modern substitute throughout the room. Hardware selection matters too - hinges, drawer slides, and pulls rated for frequent use hold up far better over years of daily opening and closing than the budget hardware that sometimes comes standard with lower-cost cabinetry."
    Faqs=@(
      @{Q="Can you build custom cabinetry to match an existing kitchen?"; A="Yes, we can match existing cabinetry style and finish, or design something entirely new."},
      @{Q="Do you build closet and pantry systems?"; A="Yes, custom closet and pantry built-ins are a regular part of our woodworking projects."},
      @{Q="Is custom woodworking only available as part of a full remodel?"; A="No - we take on standalone woodworking projects as well as work bundled into larger remodels."},
      @{Q="Can you match trim profiles in an older home?"; A="In most cases, yes. We can often replicate a discontinued trim or molding profile rather than forcing a mismatched modern substitute."},
      @{Q="Do you use commercial-grade hardware on custom cabinetry?"; A="Yes - we use hinges, slides, and pulls rated for frequent daily use rather than budget hardware, since that's usually the first thing to fail on lower-cost cabinetry."}
    )
    Facts=@(
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><path d="M21 10c0 6-9 12-9 12s-9-6-9-12a9 9 0 1 1 18 0z"/><circle cx="12" cy="10" r="3"/></svg>'; Label="Service Area"; Value="North Port &amp; Southwest FL"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><circle cx="12" cy="12" r="9"/><path d="M12 7v5l3 3"/></svg>'; Label="Typical Timeline"; Value="1-4 weeks"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><rect x="3" y="4" width="18" height="18" rx="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/></svg>'; Label="Materials"; Value="Sealed hardwood, marine plywood"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><circle cx="12" cy="12" r="9"/><line x1="12" y1="8" x2="12" y2="16"/><line x1="8" y1="12" x2="16" y2="12"/></svg>'; Label="Scope"; Value="Standalone or bundled"}
    )
    SearchPhrase="custom cabinetry contractor near me"
  }
)

foreach ($s in $services) {
    $body = Get-ServiceBody -s $s
    $schema = (Get-ServiceSchema -ServiceType $s.Name) + "`n" + (Get-FaqSchema -Faqs $s.Faqs)
    New-Page -Path (Join-Path $root "services\$($s.Slug).html") -Title "$($s.Name) in North Port, FL | Tropical Bay Builders" -Desc "$($s.Lead)" -Canonical "services/$($s.Slug).html" -Body $body -SchemaBlocks $schema
}

Write-Output "$($services.Count) service pages built"
