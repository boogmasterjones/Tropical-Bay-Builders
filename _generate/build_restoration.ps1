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
    <p class="breadcrumb"><a href="/">Home</a> / <a href="/restoration.html">Disaster Restoration</a> / $($s.Name)</p>
    <h1>$($s.H1)</h1>
    <p>$($s.Lead)</p>
    <div class="hero-actions">
      <a href="$PhoneTel" class="btn btn-primary" onclick="gtag('event','call_click',{'event_category':'engagement','event_label':'$($s.Slug)_page_phone_button'})">Call $Phone</a>
      <a href="/#quote" class="btn btn-outline-dark">Request Help Now</a>
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
        <p>Because we're a full general contractor, we can also handle the rebuild once damage is stabilized:</p>
        <ul class="addon-list">
$addonItems
        </ul>
        <p style="margin-top:16px;">Just mention it when you call or fill out the estimate form and we'll include it in your assessment.</p>
      </div>
    </div>
$(Get-CtaStrip -Heading "Dealing With This Right Now?" -Text "Reach out and we'll assess the damage and walk you through next steps." -Label "Request Help Now" -EventLabel "strip_phone_button")
  </div>
</section>

<section class="section-green">
  <div class="container">
    <div class="section-head">
      <span class="eyebrow-dark">Why Homeowners Call Us</span>
      <h2>General Contracting Experience, Applied to Restoration</h2>
    </div>
    <div class="grid-3">
      <div class="card"><h3>Licensed &amp; Insured</h3><p>Work with confidence knowing our crew is licensed and insured for restoration and rebuild work.</p></div>
      <div class="card"><h3>One Accountable Crew</h3><p>Once the damage is assessed and stabilized, we're also the ones who can rebuild it right - no handoff to a separate contractor.</p></div>
      <div class="card"><h3>Insurance Documentation</h3><p>We provide clear damage documentation to support your claim, though the claim itself is handled between you and your insurer.</p></div>
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

        $(Get-CtaStrip -Heading "Need Help Right Now?" -Text "Reach out and we'll assess the damage and walk you through next steps." -Label "Request Help Now" -EventLabel "strip_phone_button_mid")

        <h3>$($s.H3a)</h3>
        <p>$($s.Content3)</p>
        <div class="callout"><p>"$($s.Callout)"</p></div>

        <h3>$($s.H3b)</h3>
        <p>$($s.Content4)</p>

        <h3>Frequently Asked Questions</h3>
        <div class="faq-list">
$faqHtml
        </div>

        <p>Looking for "$($s.SearchPhrase)"? We're a phone call away, and since we're already serving North Port and the rest of Southwest Florida, response is usually fast.</p>
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
      <h2>Dealing With $($s.Name)?</h2>
      <p>Reach out and we'll assess the damage and walk you through next steps - no obligation.</p>
      <div class="cta-actions">
        <a href="$PhoneTel" class="btn btn-outline" onclick="gtag('event','call_click',{'event_category':'engagement','event_label':'$($s.Slug)_cta_phone_button'})">Call $Phone</a>
        <a href="/#quote" class="btn btn-primary">Request Help Now</a>
      </div>
    </div>
  </div>
</section>
"@
}

$items = @(
  @{
    Slug="storm-damage-restoration"; Name="Storm Damage Restoration"
    H1="<em>Storm</em> Damage Restoration in Southwest Florida"
    Lead="Roof, structural, and property damage repair after tropical storms and hurricanes, managed by a licensed general contractor from stabilization through full rebuild."
    WhatsIncludedIntro="Southwest Florida's storm season can leave homes with roof damage, structural issues, and downed debris damage. We assess the damage and manage the repair as a general contractor, from tarping and stabilization through full rebuild."
    Included=@("Roof and structural storm damage repair","Debris cleanup and property stabilization","Coordination with your insurance documentation","Full rebuild capability under one contractor","Emergency tarping and board-up","Post-storm damage assessment")
    AddOns=@(@{Href="/services/roofing.html";Label="Roofing"}, @{Href="/restoration/water-damage-extraction.html";Label="Water Damage & Extraction"}, @{Href="/restoration/storm-mitigation.html";Label="Storm Mitigation"})
    ContentH2="Storm Damage Restoration Near Me in North Port"
    Content1="Once it's safe to do so, the priority is stopping further damage before it compounds. A tarped roof or boarded-up window today can be the difference between a repair and a full room rebuild in two weeks once rain has kept getting in. Photograph everything before you touch or move anything - your insurer will want that documentation. Debris removal should also wait until the damage is fully documented, since clearing storm debris too quickly can inadvertently remove evidence your claim adjuster needs to see."
    Content2="If you're searching 'storm damage repair near me' or 'hurricane damage contractor North Port,' here's what matters most: speed and verification. Be cautious of anyone going door to door immediately after a storm offering to start work on the spot without verifiable licensing. A legitimate contractor will give you a written estimate and won't pressure you to sign a contract on the spot before you've had a chance to review it."
    IconListTitle="What to Do in the First 24-48 Hours"
    IconList=@("Photograph all visible damage before cleanup begins, for your insurance claim","Arrange temporary tarping or board-up to stop ongoing water intrusion","Avoid signing a contract with a door-to-door crew you can't verify","Keep receipts for any emergency mitigation you pay for out of pocket","Contact your insurer early - claims often have reporting time limits")
    H3a="Avoiding Post-Storm Scams"
    Content3="Legitimate contractors are usually swamped with existing calls in the days right after a major weather event, and high-pressure, same-day sign-up pitches from unfamiliar names are one of the most common scams that follow Florida storms. Verify licensing before anyone gets on your roof. Asking for a physical business address and checking that the license is active with the state takes only a few minutes and can save you from a much larger headache."
    Callout="Because we're a full general contractor, we're able to take a property from storm damage through complete restoration and remodeling - not just the initial repair."
    H3b="From Repair to Full Rebuild"
    Content4="Because we're a licensed general contractor first, we're able to take a property from storm damage through full restoration without handing the rebuild off to a separate company. That means one point of contact from the first tarp to the final walkthrough, and it also means the crew doing your final finish work has full context on what happened during the original damage - not a fresh team starting from a written report. That continuity also matters for warranty purposes - if a repair issue comes up later, there's no ambiguity about which contractor is responsible for which part of the work."
    Faqs=@(
      @{Q="How quickly can you respond after a storm?"; A="Reach out as soon as it's safe to do so and we'll get back to you promptly to assess the damage and schedule next steps."},
      @{Q="Do you work with insurance companies?"; A="We provide clear damage documentation to support your claim; the claim itself is handled between you and your insurer."},
      @{Q="Can you handle the full rebuild, not just the initial repair?"; A="Yes - as a general contractor, we can take a property from storm damage through complete restoration and remodeling."},
      @{Q="How do I avoid post-storm contractor scams?"; A="Verify licensing before signing anything, be wary of same-day pressure to sign, and ask for a physical business address you can confirm."},
      @{Q="What should I do with debris after a storm before you arrive?"; A="Photograph it in place first if possible, and avoid discarding anything until the damage has been documented for your insurance claim."}
    )
    Facts=@(
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><path d="M21 10c0 6-9 12-9 12s-9-6-9-12a9 9 0 1 1 18 0z"/><circle cx="12" cy="10" r="3"/></svg>'; Label="Service Area"; Value="North Port &amp; Southwest FL"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><circle cx="12" cy="12" r="9"/><path d="M12 7v5l3 3"/></svg>'; Label="Response"; Value="Same/next business day"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><rect x="3" y="4" width="18" height="18" rx="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/></svg>'; Label="Scope"; Value="Assessment through rebuild"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><circle cx="12" cy="12" r="9"/><line x1="12" y1="8" x2="12" y2="16"/><line x1="8" y1="12" x2="16" y2="12"/></svg>'; Label="Insurance"; Value="Documentation provided"}
    )
    SearchPhrase="storm damage restoration contractor near me"
  },
  @{
    Slug="water-damage-extraction"; Name="Water Damage & Extraction"
    H1="<em>Water</em> Damage &amp; Extraction Services"
    Lead="Water extraction and property repair after flooding, storm surge, or plumbing failures, from initial cleanup through structural and finish repairs."
    WhatsIncludedIntro="Water damage from flooding, storm surge, or plumbing failure needs to be addressed quickly to limit further damage to a property. We handle extraction and the repair work that follows, from flooring and drywall to structural repairs."
    Included=@("Water extraction from flooding and plumbing failures","Damaged flooring, drywall, and structural repair","Property assessment and repair planning","Full rebuild capability under one contractor","Moisture assessment beyond visible surfaces","Coordination with insurance documentation")
    AddOns=@(@{Href="/restoration/storm-damage-restoration.html";Label="Storm Damage Restoration"}, @{Href="/services/epoxy-flooring.html";Label="Epoxy Flooring"}, @{Href="/services/kitchen-remodeling.html";Label="Kitchen Remodeling"})
    ContentH2="Water Damage Restoration Near Me in North Port"
    Content1="Standing water and elevated humidity start affecting building materials within hours, not days. Drywall wicks moisture upward, wood flooring can begin cupping, and the conditions for mold growth start forming within roughly 24-48 hours in Florida's warm, humid climate. The longer extraction is delayed, the more of the structure typically needs to be removed rather than simply dried and repaired. Even after visible water is gone, moisture often remains trapped inside wall cavities and under flooring, which is why extraction alone isn't the finish line - proper drying and moisture verification matter just as much."
    Content2="If you're searching 'water damage cleanup near me' or 'flood repair contractor North Port,' here's what matters most: how fast you call. Not all water damage is treated the same by insurance either - a sudden event like a burst pipe is usually covered differently than a slow, ongoing leak. We document the source and extent of the damage as part of the assessment, which supports whichever category your claim falls into."
    IconListTitle="Why Response Time Matters"
    IconList=@("Mold growth conditions can begin forming within 24-48 hours","Drywall and wood flooring absorb moisture faster than they show visible signs","Sudden water events are typically covered differently than long-term leaks by insurance","Extraction equipment needs to reach subfloor and wall cavities, not just visible surfaces","Odor after drying often signals moisture still trapped inside a wall or floor")
    H3a="Sudden Events vs. Slow Leaks"
    Content3="Sudden events like a burst pipe are usually covered by insurance, while damage from a slow, ongoing leak that went unaddressed for months is often treated as a maintenance issue and may not be. If you notice a slow leak, addressing it quickly protects both your home and your claim. A small water stain that keeps reappearing after cleaning is one of the more common early warning signs of a slow leak worth investigating before it becomes a larger claim."
    Callout="As a general contractor, we're positioned to manage the full repair process after water is removed, not just the initial cleanup."
    H3b="From Extraction to Finished Repair"
    Content4="We handle extraction and the repair work that follows, from flooring and drywall to structural repairs, as one project rather than handing you off to a separate remodeling company once the water is gone. That includes verifying moisture levels have returned to normal before closing up any wall or subfloor, so a repair isn't sealing in a problem that resurfaces months later. We also inspect cabinetry and baseboards that sat in standing water, since swelling and delamination aren't always visible right away but tend to worsen over the following weeks."
    Faqs=@(
      @{Q="What causes water damage you typically repair?"; A="Storm surge, flooding, and plumbing failures are the most common causes we respond to across Southwest Florida."},
      @{Q="Do you handle both the extraction and the repair work?"; A="Yes - we manage the process from initial water removal through the structural and finish repairs that follow."},
      @{Q="How fast should I call after discovering water damage?"; A="As soon as possible - the longer water sits, the more it can affect flooring, drywall, and structural materials."},
      @{Q="How do you verify a space is fully dry before repairs are closed up?"; A="We check moisture levels in the affected materials before finishing any repair, rather than assuming a space is dry once it looks dry on the surface."},
      @{Q="Will cabinetry that got wet need to be replaced?"; A="It depends on the material and how long it sat in water - we inspect for swelling and delamination before deciding whether repair or replacement makes more sense."}
    )
    Facts=@(
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><path d="M21 10c0 6-9 12-9 12s-9-6-9-12a9 9 0 1 1 18 0z"/><circle cx="12" cy="10" r="3"/></svg>'; Label="Service Area"; Value="North Port &amp; Southwest FL"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><circle cx="12" cy="12" r="9"/><path d="M12 7v5l3 3"/></svg>'; Label="Mold Risk Window"; Value="24-48 hours"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><rect x="3" y="4" width="18" height="18" rx="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/></svg>'; Label="Scope"; Value="Extraction through rebuild"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><circle cx="12" cy="12" r="9"/><line x1="12" y1="8" x2="12" y2="16"/><line x1="8" y1="12" x2="16" y2="12"/></svg>'; Label="Common Causes"; Value="Storm surge, plumbing, flooding"}
    )
    SearchPhrase="water damage restoration contractor near me"
  },
  @{
    Slug="fire-damage-restoration"; Name="Fire Damage Restoration"
    H1="<em>Fire</em> Damage Restoration Services"
    Lead="Structural repair and full rebuild after fire damage, managed by a licensed general contractor from initial damage assessment through finished remodeling."
    WhatsIncludedIntro="Fire damage is rarely limited to what actually burned. Smoke residue travels through HVAC ductwork and settles into materials throughout the home, and water used to fight the fire can cause its own separate damage."
    Included=@("Structural damage assessment and repair","Smoke and fire-damaged material removal","Full rebuild and remodeling of affected areas","Coordination with your insurance documentation","HVAC inspection and cleaning after fire","Water damage repair from firefighting efforts")
    AddOns=@(@{Href="/services/new-construction.html";Label="New Construction"}, @{Href="/services/woodworking.html";Label="Custom Woodworking"}, @{Href="/restoration/water-damage-extraction.html";Label="Water Damage & Extraction"})
    ContentH2="Fire Damage Restoration Near Me in North Port"
    Content1="A thorough assessment covers all three areas fire touches - structural fire damage, smoke and soot contamination, and any water intrusion from suppression efforts - before rebuild work starts. Smoke and soot damage often extends well beyond the visibly burned area, which is why a full assessment matters more than a quick look at the obvious damage. Soot is also acidic and continues to degrade surfaces the longer it sits, so materials that look salvageable right after a fire can develop permanent damage if cleanup is delayed."
    Content2="If you're searching 'fire damage repair near me' or 'fire restoration contractor North Port,' here's what sets our approach apart: because we're a general contractor rather than a restoration-only company, we're able to carry a property from that initial assessment through the full rebuild without switching companies partway through. That continuity matters when it comes time to match trim, cabinetry, or flooring to what was there before - decisions that are much easier for a team that documented the original space firsthand."
    IconListTitle="What Fire Damage Restoration Actually Involves"
    IconList=@("Smoke and soot damage often extends well beyond the visibly burned area","HVAC systems typically need inspection and cleaning after any structure fire","Water used in firefighting can cause separate damage requiring its own repair","A full damage assessment should precede any demolition or rebuild work","One contractor managing assessment through rebuild avoids handoff gaps")
    H3a="Why One Contractor Matters"
    Content3="That matters for consistency: the same team that documented the original damage is the one making sure the finished space matches what was there before, or improves on it where you want it to - not a different crew picking up mid-project with no context. It also means fewer gaps in the paper trail your insurer needs, since the documentation carries through from initial assessment to final invoice under one contractor."
    Callout="Fire damage assessment should always precede demolition - removing materials before documenting the full extent of smoke and structural damage can complicate an insurance claim."
    H3b="From Assessment to Finished Rebuild"
    Content4="We manage the project from structural repair through the finish work that follows, including matching or upgrading trim, cabinetry, and finishes to what was there before - or better, if that's what you want. HVAC inspection is part of our standard process too, since smoke residue drawn through ductwork during a fire can continue circulating odor throughout the home long after visible repairs are finished if the system isn't properly cleaned. Belongings that survived the fire itself can still carry smoke odor deep into fabric and porous materials, which is worth mentioning to your insurer separately from the structural claim."
    Faqs=@(
      @{Q="Do you handle both structural repair and finish rebuild?"; A="Yes - as a general contractor, we manage the project from structural repair through the finish work that follows."},
      @{Q="Can you help document fire damage for an insurance claim?"; A="We can provide a clear assessment of the damage to support your claim; the claim itself is handled between you and your insurer."},
      @{Q="How long does fire damage restoration usually take?"; A="It depends heavily on the extent of the damage - we'll give you a project-specific timeline once we've assessed the property."},
      @{Q="Will you check the HVAC system after a fire?"; A="Yes - HVAC inspection and cleaning is part of our standard process, since smoke residue can circulate through ductwork long after visible repairs are complete."},
      @{Q="Can smoke damage affect areas that weren't near the fire?"; A="Yes - smoke residue travels through ductwork and settles in materials throughout the home, which is why a full assessment covers more than just the visibly burned area."}
    )
    Facts=@(
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><path d="M21 10c0 6-9 12-9 12s-9-6-9-12a9 9 0 1 1 18 0z"/><circle cx="12" cy="10" r="3"/></svg>'; Label="Service Area"; Value="North Port &amp; Southwest FL"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><circle cx="12" cy="12" r="9"/><path d="M12 7v5l3 3"/></svg>'; Label="Timeline"; Value="Varies by damage extent"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><rect x="3" y="4" width="18" height="18" rx="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/></svg>'; Label="Scope"; Value="Assessment through rebuild"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><circle cx="12" cy="12" r="9"/><line x1="12" y1="8" x2="12" y2="16"/><line x1="8" y1="12" x2="16" y2="12"/></svg>'; Label="Includes"; Value="HVAC &amp; water damage check"}
    )
    SearchPhrase="fire damage restoration contractor near me"
  },
  @{
    Slug="storm-mitigation"; Name="Storm Mitigation"
    H1="<em>Storm</em> Mitigation Services"
    Lead="Preventive upgrades that help protect your property before the next storm season, from roofing reinforcement to drainage and water-intrusion prevention."
    WhatsIncludedIntro="Storm mitigation is about reducing damage before it happens - reinforcing weak points, upgrading materials, and addressing issues that tend to fail first during high winds and heavy rain."
    Included=@("Property vulnerability assessment","Roofing and exterior reinforcement upgrades","Drainage and water-intrusion prevention","Recommendations prioritized by risk and budget","Roof strapping and fastener upgrades","Wind mitigation inspection coordination")
    AddOns=@(@{Href="/services/roofing.html";Label="Roofing"}, @{Href="/services/exterior-remodel-additions.html";Label="Exterior Remodel & Additions"}, @{Href="/restoration/storm-damage-restoration.html";Label="Storm Damage Restoration"})
    ContentH2="Storm Mitigation Near Me in North Port"
    Content1="Not every mitigation upgrade delivers the same return, and budget usually means picking priorities rather than doing everything at once. Roof-level improvements - secondary water barriers, upgraded fasteners, and proper strapping - tend to prevent the most catastrophic damage per dollar spent, since roof failure is often what allows everything else to cascade during a storm. Once wind gets under a compromised roof edge, the pressure difference it creates can do far more damage to the rest of the structure than the wind alone would have."
    Content2="If you're searching 'storm mitigation contractor near me' or 'hurricane prep North Port,' here's what to know: several wind mitigation upgrades can also qualify for homeowners insurance discounts in Florida, sometimes meaningful ones. Getting a formal wind mitigation inspection on record with your insurer is a separate step from the upgrades themselves, and it's worth doing even if you're only planning partial improvements this year."
    IconListTitle="Mitigation Upgrades Worth Prioritizing"
    IconList=@("Roof strapping and upgraded fasteners reduce the risk of catastrophic failure","Impact-rated windows and doors protect the building envelope during high winds","Proper yard drainage reduces flooding risk around the foundation","A wind mitigation inspection can identify insurance discount opportunities","Secondary water barriers add protection if shingles are compromised")
    H3a="Insurance Discounts for Wind Mitigation"
    Content3="A wind mitigation inspection documents what your home already has and what would qualify if upgraded, which is worth doing before you decide what to prioritize rather than after. Many homeowners are surprised how much these upgrades can offset insurance premiums over time. The inspection itself is a relatively quick process, and having it on file gives you a clear baseline to work from as you decide what to tackle first."
    Callout="Roof failure is often what allows everything else to cascade during a storm - which is why roof-level mitigation tends to deliver the most protection per dollar spent."
    H3b="Prioritizing on a Budget"
    Content4="If you can't do everything before the next storm season, we'll help you prioritize based on your specific property's vulnerabilities - not a generic checklist. A property near open water has different priorities than one further inland. Impact windows and doors are often the next priority after the roof, since a breach in the building envelope during high winds is one of the most common ways interior damage escalates quickly. Garage doors are also frequently overlooked in mitigation planning, but a garage door that fails under wind pressure can pressurize the entire structure and cause damage well beyond the garage itself."
    Faqs=@(
      @{Q="When should I have storm mitigation work done?"; A="Before storm season, ideally - it's much easier to reinforce a property proactively than to repair it after damage occurs."},
      @{Q="What does a mitigation assessment look like?"; A="We walk the property, identify the areas most likely to fail under storm conditions, and give you a prioritized list of recommendations."},
      @{Q="Can mitigation upgrades lower my insurance costs?"; A="Certain wind mitigation upgrades can qualify for insurance discounts - check with your insurer on the specifics for your policy."},
      @{Q="What should I prioritize if I can't do everything at once?"; A="Roof-level upgrades typically deliver the most protection per dollar, followed by impact windows and doors for properties with exposed glazing."},
      @{Q="Is my garage door a storm mitigation concern?"; A="Often overlooked, yes. A garage door that fails under wind pressure can pressurize the whole structure, so a wind-rated garage door is worth including in a mitigation plan."}
    )
    Facts=@(
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><path d="M21 10c0 6-9 12-9 12s-9-6-9-12a9 9 0 1 1 18 0z"/><circle cx="12" cy="10" r="3"/></svg>'; Label="Service Area"; Value="North Port &amp; Southwest FL"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><circle cx="12" cy="12" r="9"/><path d="M12 7v5l3 3"/></svg>'; Label="Best Timing"; Value="Before storm season"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><rect x="3" y="4" width="18" height="18" rx="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/></svg>'; Label="Focus"; Value="Roof, windows, drainage"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><circle cx="12" cy="12" r="9"/><line x1="12" y1="8" x2="12" y2="16"/><line x1="8" y1="12" x2="16" y2="12"/></svg>'; Label="Bonus"; Value="Possible insurance discounts"}
    )
    SearchPhrase="storm mitigation contractor near me"
  }
)

foreach ($s in $items) {
    $body = Get-ServiceBody -s $s
    $schema = (Get-ServiceSchema -ServiceType $s.Name) + "`n" + (Get-FaqSchema -Faqs $s.Faqs)
    New-Page -Path (Join-Path $root "restoration\$($s.Slug).html") -Title "$($s.Name) in North Port, FL | Tropical Bay Builders" -Desc "$($s.Lead)" -Canonical "restoration/$($s.Slug).html" -Body $body -SchemaBlocks $schema
}

Write-Output "$($items.Count) restoration pages built"
