. "$PSScriptRoot\parts.ps1"
$root = Split-Path -Parent $PSScriptRoot

function Get-LocationBody {
    param($s)
    $iconListItems = ($s.IconList | ForEach-Object {
"          <li><svg width=`"18`" height=`"18`" viewBox=`"0 0 24 24`" fill=`"none`" stroke=`"currentColor`" stroke-width=`"2.2`"><path d=`"M20 6L9 17l-5-5`"/></svg> $_</li>"
    }) -join "`n"
    $faqHtml = ($s.Faqs | ForEach-Object {
"          <details class=`"faq-item`"><summary>$($_.Q)<span class=`"faq-icon`"><svg width=`"14`" height=`"14`" viewBox=`"0 0 24 24`" fill=`"none`" stroke=`"currentColor`" stroke-width=`"2.5`"><line x1=`"12`" y1=`"5`" x2=`"12`" y2=`"19`"/><line x1=`"5`" y1=`"12`" x2=`"19`" y2=`"12`"/></svg></span></summary><p>$($_.A)</p></details>"
    }) -join "`n"
    $factsHtml = ($s.Facts | ForEach-Object {
"          <div class=`"fact`"><div class=`"fact-icon`">$($_.Icon)</div><div><dt>$($_.Label)</dt><dd>$($_.Value)</dd></div></div>"
    }) -join "`n"

@"
<div class="page-header">
  <div class="container">
    <p class="breadcrumb"><a href="/">Home</a> / $($s.Name) General Contractor</p>
    <h1>General Contractor in <em>$($s.Name)</em>, FL</h1>
    <p>$($s.HeaderLead)</p>
    <div class="hero-actions">
      <a href="$PhoneTel" class="btn btn-primary" onclick="gtag('event','call_click',{'event_category':'engagement','event_label':'location_page_phone_button'})">Call $Phone</a>
      <a href="/#quote" class="btn btn-outline-dark">Request a Free Estimate</a>
    </div>
  </div>
</div>

<section>
  <div class="container content-section" style="border-top:none; margin-top:0; padding-top:0;">
    <p>$($s.PopIntro)</p>
    <h2>$($s.H2a)</h2>
    <p>$($s.Content1)</p>
    <h2>$($s.H2b)</h2>
    <p>$($s.Content2)</p>
    <p>$($s.Content3)</p>

    <div class="content-layout">
      <div class="content-main">
        <h3>What We Build &amp; Repair in $($s.Name)</h3>
        <ul class="icon-list">
$iconListItems
        </ul>

        $(Get-CtaStrip -Heading "Ready to Book in $($s.Name)?" -Text "Get a free, no-obligation estimate today." -EventLabel "strip_phone_button")

        <h3>$($s.H3a)</h3>
        <p>$($s.Content4)</p>
        <div class="callout"><p>"$($s.Callout)"</p></div>

        <h3>$($s.H3b)</h3>
        <p>$($s.Content5)</p>

        <h3>Frequently Asked Questions</h3>
        <div class="faq-list">
$faqHtml
        </div>

        <p>Looking for "general contractor near me" or a "$($s.Name) remodeling contractor"? We're a phone call away, and since we're already serving $($s.NearbyLink1) and $($s.NearbyLink2) nearby, scheduling is usually easy to fit in.</p>
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

<section class="section-green">
  <div class="container">
    <div class="cta-band">
      <h2>Get a Free Estimate in $($s.Name)</h2>
      <p>Call today or request an estimate online - we'll give you a straightforward price for your home or business.</p>
      <div class="cta-actions">
        <a href="$PhoneTel" class="btn btn-outline" onclick="gtag('event','call_click',{'event_category':'engagement','event_label':'location_cta_phone_button'})">Call $Phone</a>
        <a href="/#quote" class="btn btn-primary">Request a Free Estimate</a>
      </div>
    </div>
  </div>
</section>
"@
}

$locations = @(
  @{
    Slug="port-charlotte"; Name="Port Charlotte"
    HeaderLead="Tropical Bay Builders brings the same North Port standard of care just up the road to Port Charlotte - remodeling, new construction, and storm restoration, done right."
    PopIntro="Port Charlotte is home to roughly 60,000 residents spread across a grid of canal-front streets, retirement communities, and a growing stretch of retail along US-41 and Kings Highway. It's one of the larger communities in Charlotte County, and it's a short drive north from our home base in North Port - close enough that we're out there regularly for both remodeling projects and storm response."
    H2a="Remodeling &amp; New Construction in Port Charlotte"
    Content1="A lot of Port Charlotte homes sit directly on one of the area's many canals, which brings its own set of considerations for any remodel or addition - flood elevation requirements, dock and seawall permitting handled separately from the main project, and materials that hold up to constant humidity. Our remodeling and new construction work handles kitchens, bathrooms, additions, and full builds with those realities built in from the start, not discovered mid-project."
    H2b="Storm &amp; Water Damage Restoration in Port Charlotte"
    Content2="Charlotte Harbor's salt air works on exterior materials year-round, not just after a storm, and many Port Charlotte homes near Port Charlotte Beach Park or along the waterfront sections of the Harbor see faster wear on roofing, siding, and exterior finishes than homes a few miles inland. When storm or water damage does hit, we handle assessment, stabilization, and full rebuild as one contractor."
    Content3="Because we're based just down the road in North Port, Port Charlotte is one of the areas we visit most often - which means tighter scheduling windows and a crew that already knows the difference between a Harbor-facing canal home and one set back on a dry lot."
    IconList=@("Canal-front home remodels and additions","Kitchen &amp; bathroom renovations","Storm and water damage restoration","New construction and structural additions","Roofing, fencing &amp; driveway work")
    H3a="Dealing with Charlotte Harbor's Salt Air"
    Content4="Because so much of Port Charlotte sits along canals feeding into Charlotte Harbor, exterior materials here fight a constant, low-grade salt exposure that most inland Florida homes never deal with. Left unaddressed, that exposure accelerates wear on roofing, siding, and fencing far faster than the manufacturer's rated lifespan would suggest. Homes in the older sections near Edgewater Drive and the newer construction around Peachland Boulevard both deal with it, just at slightly different rates depending on proximity to open water."
    Callout="Waterfront properties in Port Charlotte aren't harder to build on because they're difficult - they're harder because the salt exposure gets a head start if materials aren't chosen with that in mind from day one."
    H3b="What to Expect on Your First Project"
    Content5="For a first-time project in Port Charlotte, we typically start with a full walkthrough to understand not just your goals but your specific lot's exposure and any existing issues from age or salt air. That upfront assessment is what lets us give you an accurate estimate instead of a number that grows once work is underway."
    Faqs=@(
      @{Q="How often do canal-front homes in Port Charlotte need exterior maintenance?"; A="Most waterfront and canal-front homes benefit from an exterior inspection every year or two. Salt air off the Harbor accelerates wear on roofing and siding faster than a few miles inland."},
      @{Q="Do you serve businesses along US-41 in Port Charlotte?"; A="Yes, we take on commercial remodeling and repair projects for retail centers, medical offices, and professional buildings along the US-41 and Tamiami Trail corridor."},
      @{Q="Will my first project take longer to estimate than a routine one?"; A="Often, yes. If your property is on a canal or has storm damage, we spend more time on the initial assessment to understand exposure and existing conditions before quoting."},
      @{Q="Do you work on both retirement community and canal-front homes in Port Charlotte?"; A="Yes - we take on projects across Port Charlotte's mix of retirement communities, canal-front lots, and standard inland homes, each scoped for its specific conditions."}
    )
    Facts=@(
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><path d="M17 20h5v-2a4 4 0 0 0-3-3.87M9 20H4v-2a4 4 0 0 1 3-3.87m5-1.13a4 4 0 1 0-4-4M13 8a4 4 0 1 1 0 5.29"/></svg>'; Label="Population"; Value="~60,000"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><circle cx="12" cy="12" r="9"/><path d="M12 7v5l3 3"/></svg>'; Label="Drive from North Port"; Value="~15 minutes"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><path d="M21 10c0 6-9 12-9 12s-9-6-9-12a9 9 0 1 1 18 0z"/><circle cx="12" cy="10" r="3"/></svg>'; Label="Key Areas"; Value="Port Charlotte Beach Park, Charlotte Harbor"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><path d="M3 12h18M3 6h18M3 18h18"/></svg>'; Label="Local Challenge"; Value="Canal &amp; salt-air exposure"}
    )
    NearbyLink1='<a href="/">North Port</a>'
    NearbyLink2='<a href="/locations/punta-gorda.html">Punta Gorda</a>'
  },
  @{
    Slug="punta-gorda"; Name="Punta Gorda"
    HeaderLead="From historic downtown to the canal-front homes of Punta Gorda Isles, we bring general contracting Punta Gorda homeowners can count on."
    PopIntro="Punta Gorda is home to roughly 19,000 residents, with a mix of waterfront homes in Punta Gorda Isles (PGI) and Burnt Store Isles alongside a walkable historic downtown near Fishermen's Village. It's one of the more distinct communities in our service area, and one where remodeling and restoration work each carry their own local considerations. Rebuilt largely after Hurricane Charley in 2004, much of the city's housing stock is newer than what you'll find in some neighboring communities, which shapes what a remodel or addition typically involves here compared to an older inland home."
    H2a="Remodeling &amp; New Construction in Punta Gorda"
    Content1="Unlike most of Charlotte County, Punta Gorda is an incorporated city, so permitting for projects inside city limits runs through the City of Punta Gorda's building department rather than the county directly. Homes in PGI and Burnt Store Isles, both largely built on filled canal-front lots, also carry flood elevation requirements we check before finalizing scope. The historic downtown district has its own character considerations too - some homes fall within a designated historic area, which can affect what's allowed for exterior changes visible from the street."
    H2b="Storm &amp; Water Damage Restoration in Punta Gorda"
    Content2="Punta Gorda's canal-front neighborhoods see the same salt-air and storm-surge exposure common throughout our coastal service area, and Charlotte Harbor's open water puts PGI and Burnt Store Isles properties at real risk during major storms. When storm or water damage hits, we handle assessment and stabilization, then carry the project through full rebuild as one contractor."
    Content3="We check which jurisdiction applies - city or county - before submitting any permit paperwork, since Punta Gorda's rules don't always match unincorporated Charlotte County exactly."
    IconList=@("PGI &amp; Burnt Store Isles remodels and additions","Historic downtown exterior projects","Storm and water damage restoration","New construction on canal-front lots","Kitchen, bathroom &amp; whole-home renovations")
    H3a="Building Within City Limits"
    Content4="Permitting inside Punta Gorda's city limits runs through the city's own building department, which is worth knowing since it can run on a different timeline and process than unincorporated Charlotte County. We confirm which jurisdiction applies to your specific address before any paperwork goes in."
    Callout="A historic downtown property and a canal-front PGI home face two completely different sets of considerations - we scope each on its own terms rather than applying a one-size-fits-all approach."
    H3b="Historic District Considerations"
    Content5="Some homes in Punta Gorda's historic downtown district fall within a designated historic review area, which can affect what's allowed for exterior changes visible from the street. We flag this early if your property is in that zone so it doesn't surprise you mid-project."
    Faqs=@(
      @{Q="Does Punta Gorda have different permitting than the rest of Charlotte County?"; A="Yes - Punta Gorda is an incorporated city, so permits inside city limits go through the City of Punta Gorda's building department, not Charlotte County directly."},
      @{Q="Do PGI and Burnt Store Isles homes need special flood documentation?"; A="Often, yes. Properties on filled canal-front lots in these neighborhoods commonly require flood elevation documentation as part of permitting."},
      @{Q="Can you work on homes in the historic downtown district?"; A="Yes, though some properties there fall within a historic review area that can affect exterior changes visible from the street - we check this before finalizing scope."},
      @{Q="Is Punta Gorda's housing stock mostly newer construction?"; A="A lot of it, yes - much of the city was rebuilt after Hurricane Charley in 2004, so many homes are newer than in some neighboring communities. We scope each property based on its actual age and condition rather than assuming."},
      @{Q="Do you handle commercial projects around Fishermen's Village or downtown Punta Gorda?"; A="Yes, we take on light-commercial remodeling and repair projects in the downtown and waterfront commercial areas as well as residential work."}
    )
    Facts=@(
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><path d="M17 20h5v-2a4 4 0 0 0-3-3.87M9 20H4v-2a4 4 0 0 1 3-3.87m5-1.13a4 4 0 1 0-4-4M13 8a4 4 0 1 1 0 5.29"/></svg>'; Label="Population"; Value="~19,000"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><circle cx="12" cy="12" r="9"/><path d="M12 7v5l3 3"/></svg>'; Label="Drive from North Port"; Value="~20 minutes"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><path d="M21 10c0 6-9 12-9 12s-9-6-9-12a9 9 0 1 1 18 0z"/><circle cx="12" cy="10" r="3"/></svg>'; Label="Key Areas"; Value="PGI, Burnt Store Isles, historic downtown"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><path d="M3 12h18M3 6h18M3 18h18"/></svg>'; Label="Local Challenge"; Value="City permitting &amp; flood zones"}
    )
    NearbyLink1='<a href="/">North Port</a>'
    NearbyLink2='<a href="/locations/port-charlotte.html">Port Charlotte</a>'
  },
  @{
    Slug="venice"; Name="Venice"
    HeaderLead="From the historic island downtown to Golden Beach, we handle remodeling, new construction, and restoration for Venice homeowners."
    PopIntro="Venice is home to roughly 25,000 residents, with beachfront homes on Venice Island alongside a walkable, brick-paved historic downtown and neighborhoods spreading east toward Venice East and I-75. It's an incorporated city within Sarasota County, which shapes how projects here get permitted. The city is also known locally as the 'Shark Tooth Capital of the World,' a reminder of just how close to the Gulf much of the community actually sits."
    H2a="Remodeling &amp; New Construction in Venice"
    Content1="Venice Island, in particular, has architectural review considerations for exterior work given the historic character of the downtown and near-beach areas. Homes further from the island, including areas near Venice East, fall under more standard suburban zoning without the same downtown review layer, but still carry the same wind-load and flood elevation code baseline as the rest of Sarasota County. We confirm which set of rules applies before scoping your project. Homes closer to the historic district also tend to have older electrical and plumbing systems that need to be assessed before any remodel starts, since bringing those systems up to current code is often part of the scope even when the visible finish work is the main goal."
    H2b="Storm &amp; Water Damage Restoration in Venice"
    Content2="Venice's Gulf-front exposure on the island means storm surge and wind-driven rain are real considerations for waterfront properties, while inland neighborhoods deal more with drainage and roof damage from heavy seasonal rain. Whichever the case, we handle assessment, stabilization, and full rebuild as one accountable contractor."
    Content3="Most projects within Venice city limits go through the City of Venice's own building department, which is worth knowing since it runs on a separate timeline and process from unincorporated Sarasota County."
    IconList=@("Venice Island remodels &amp; additions","Historic downtown exterior projects","Storm and water damage restoration","Kitchen &amp; bathroom renovations","New construction near Venice East")
    H3a="Venice Island Architectural Review"
    Content4="Exterior projects on Venice Island - especially those visible from the historic downtown or near-beach areas - may face additional architectural review beyond standard permitting. We flag this during the initial walkthrough so it's factored into your timeline from the start, not discovered partway through."
    Callout="A brick-paved historic downtown and a newer subdivision near I-75 aren't held to the same review standard - we confirm which applies to your property before submitting anything."
    H3b="Coastal Exposure on the Island"
    Content5="Homes directly on Venice Island see more direct Gulf exposure - salt air, wind-driven rain, and in some cases storm surge risk - than properties further inland near Venice East. We account for this in material selection for any exterior work, roofing, or restoration project on the island."
    Faqs=@(
      @{Q="Does Venice have different permitting than the rest of Sarasota County?"; A="Yes - Venice is an incorporated city, so permits inside city limits go through the City of Venice, not unincorporated Sarasota County."},
      @{Q="Do Venice Island homes need special exterior review?"; A="Often, yes. Properties in the historic downtown and near-beach areas may face additional architectural review for exterior changes."},
      @{Q="Do you handle storm damage on Venice Island specifically?"; A="Yes - island properties see more direct Gulf exposure, and we account for that in both restoration work and any new exterior materials."},
      @{Q="Do older Venice homes near downtown need extra electrical or plumbing work during a remodel?"; A="Often, yes. Homes closer to the historic district tend to have older systems that need assessment, and bringing them up to current code is frequently part of the project scope."},
      @{Q="Do you work on homes near Venice East and I-75, not just the island?"; A="Yes - we take on projects across Venice, from the historic island to newer neighborhoods near Venice East, each scoped for its own zoning and construction era."}
    )
    Facts=@(
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><path d="M17 20h5v-2a4 4 0 0 0-3-3.87M9 20H4v-2a4 4 0 0 1 3-3.87m5-1.13a4 4 0 1 0-4-4M13 8a4 4 0 1 1 0 5.29"/></svg>'; Label="Population"; Value="~25,000"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><circle cx="12" cy="12" r="9"/><path d="M12 7v5l3 3"/></svg>'; Label="Drive from North Port"; Value="~20 minutes"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><path d="M21 10c0 6-9 12-9 12s-9-6-9-12a9 9 0 1 1 18 0z"/><circle cx="12" cy="10" r="3"/></svg>'; Label="Key Areas"; Value="Venice Island, historic downtown, Venice East"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><path d="M3 12h18M3 6h18M3 18h18"/></svg>'; Label="Local Challenge"; Value="Island architectural review"}
    )
    NearbyLink1='<a href="/locations/englewood.html">Englewood</a>'
    NearbyLink2='<a href="/locations/sarasota.html">Sarasota</a>'
  },
  @{
    Slug="englewood"; Name="Englewood"
    HeaderLead="Coastal-ready remodeling, construction, and storm restoration for Englewood and the Manasota Key area."
    PopIntro="Englewood is home to roughly 30,000 residents and is unusual in that it straddles the Sarasota-Charlotte county line - the northern part falls under Sarasota County, while south Englewood is in Charlotte County. Which jurisdiction handles your permit depends on your specific address. It's a quieter, more residential community than some of its neighbors, without a dense downtown core, which means most of our work here is centered on individual homes rather than commercial or mixed-use buildings."
    H2a="Remodeling &amp; New Construction in Englewood"
    Content1="Coastal exposure is the bigger practical factor for most Englewood projects. Homes near Manasota Key and the immediate Lemon Bay waterfront see more direct salt air and wind-driven rain than inland properties just a few miles away, which affects everything from fastener choice to how we detail window and door flashing on any remodel or addition. Many homes in the area were built in stages over the decades as the community grew, so it's common to find additions or updates from different eras on the same property - something we account for when planning a new remodel so it ties together with what's already there instead of creating another visible patchwork layer."
    H2b="Storm &amp; Water Damage Restoration in Englewood"
    Content2="Manasota Key's barrier-island position makes it one of the more storm-exposed areas in our service territory, and Lemon Bay waterfront homes see faster wear on exterior materials than inland Englewood properties. When storm or water damage hits here, we handle assessment and stabilization, then carry the project through full rebuild as one contractor."
    Content3="We confirm which county jurisdiction applies to your specific address before any paperwork goes in, since Sarasota and Charlotte counties don't always apply identical requirements. That's a step worth confirming even for homeowners who've lived in Englewood for years, since county lines here don't always follow an obvious landmark or main road the way you might expect."
    IconList=@("Manasota Key &amp; Lemon Bay waterfront projects","Storm and water damage restoration","Kitchen &amp; bathroom renovations","Corrosion-resistant materials for coastal exposure","New construction and additions")
    H3a="Building on a County Line"
    Content4="Which jurisdiction handles your permit depends on your specific address, and the two counties don't always apply identical requirements, so we confirm this before any paperwork goes in rather than assuming based on the town name alone."
    Callout="A home two streets apart in Englewood can fall under two different counties - getting the jurisdiction right the first time avoids a permitting headache later."
    H3b="Materials for Barrier Island Exposure"
    Content5="Corrosion-resistant fasteners and hardware matter more here than almost anywhere else in our service area, particularly for homes near Manasota Key. Wind-driven rain resistance is also a bigger factor for barrier island exposure than for a comparable inland project."
    Faqs=@(
      @{Q="Which county handles permitting for my Englewood address?"; A="It depends on your specific location - Englewood straddles the Sarasota-Charlotte county line, so we confirm which jurisdiction applies before submitting any permit."},
      @{Q="Do Manasota Key homes need special materials?"; A="Yes, corrosion-resistant fasteners and hardware, along with wind-driven rain resistant detailing, matter more for barrier island exposure than for inland properties."},
      @{Q="Do you handle storm restoration on Lemon Bay waterfront homes?"; A="Yes - waterfront homes here see faster wear from salt air and storm exposure, and we account for that in both restoration and any new construction materials."},
      @{Q="Do older Englewood homes often have mismatched past additions?"; A="It's common, yes - many properties were built up in stages over the years. We plan new work to tie in with the existing structure rather than adding another visibly separate layer."},
      @{Q="Is Englewood mostly single-family homes?"; A="Yes, it's a predominantly residential community without a dense commercial core, so most of our work here is centered on individual homes rather than mixed-use buildings."}
    )
    Facts=@(
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><path d="M17 20h5v-2a4 4 0 0 0-3-3.87M9 20H4v-2a4 4 0 0 1 3-3.87m5-1.13a4 4 0 1 0-4-4M13 8a4 4 0 1 1 0 5.29"/></svg>'; Label="Population"; Value="~30,000"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><circle cx="12" cy="12" r="9"/><path d="M12 7v5l3 3"/></svg>'; Label="Drive from North Port"; Value="~20 minutes"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><path d="M21 10c0 6-9 12-9 12s-9-6-9-12a9 9 0 1 1 18 0z"/><circle cx="12" cy="10" r="3"/></svg>'; Label="Key Areas"; Value="Manasota Key, Lemon Bay"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><path d="M3 12h18M3 6h18M3 18h18"/></svg>'; Label="Local Challenge"; Value="Barrier-island exposure"}
    )
    NearbyLink1='<a href="/locations/venice.html">Venice</a>'
    NearbyLink2='<a href="/locations/boca-grande.html">Boca Grande</a>'
  },
  @{
    Slug="sarasota"; Name="Sarasota"
    HeaderLead="From downtown condo towers to Siesta Key beach homes, we handle remodeling, new construction, and restoration throughout Sarasota."
    PopIntro="Sarasota is home to roughly 57,000 residents citywide, with downtown condo towers, bayfront properties near St. Armands Circle, and a wide range of residential neighborhoods extending toward Lakewood Ranch. It covers more jurisdictional ground than most of our service area. Sarasota is also the largest and most diverse market in our territory, ranging from high-rise condo renovations downtown to single-family remodels in neighborhoods that look nothing alike a few miles apart."
    H2a="Remodeling &amp; New Construction in Sarasota"
    Content1="Properties within the City of Sarasota limits go through the city's building department, while surrounding areas including parts near Lakewood Ranch fall under unincorporated Sarasota County. Siesta Key carries additional coastal construction control line considerations given its Gulf-front location, which affects what's allowed for additions and exterior work closest to the beach. Condo and townhome projects downtown also frequently involve an association review layer on top of standard city permitting, which is worth flagging early since it can add time to a schedule that a single-family home project wouldn't need to account for."
    H2b="Storm &amp; Water Damage Restoration in Sarasota"
    Content2="Downtown and near-downtown neighborhoods like Southside Village also see more mixed lot sizes and older housing stock than the newer developments further east, which usually means more variables to check - existing electrical capacity, foundation condition, and whether prior work was permitted correctly - before we finalize a restoration scope. Storm response for downtown high-rises also looks different than for a single-family home, since condo association boards and building management are usually involved in coordinating access and scope alongside the individual unit owner."
    Content3="Siesta Key's coastal construction control line review adds a step for beachfront restoration work that inland Sarasota properties don't face, which we factor into project timelines from the start."
    IconList=@("Siesta Key coastal remodels &amp; restoration","Downtown &amp; Southside Village renovations","Storm and water damage restoration","New construction near Lakewood Ranch","Kitchen, bathroom &amp; whole-home projects")
    H3a="Navigating City vs. County Jurisdiction"
    Content4="City of Sarasota and unincorporated county projects follow different permitting paths, and knowing which applies to your address before you start planning saves real time. We confirm the applicable jurisdiction before any permit is submitted."
    Callout="Siesta Key's coastal construction control line review is a step most inland Sarasota projects never encounter - factoring it in early keeps a beachfront project on schedule."
    H3b="Older Housing Stock Downtown"
    Content5="Older Southside Village and downtown-adjacent homes often need added scoping care - checking existing electrical capacity, foundation condition, and whether prior renovations were permitted correctly - before we finalize a remodel or restoration plan. Unpermitted work from a previous owner is more common in these older neighborhoods than homeowners often expect, and catching it during our initial assessment is far better than discovering it mid-project once walls are already open."
    Faqs=@(
      @{Q="Does Sarasota have different permitting rules depending on location?"; A="Yes - City of Sarasota and unincorporated Sarasota County projects follow different permitting paths. We confirm which applies to your specific address."},
      @{Q="Do Siesta Key properties face extra review for construction?"; A="Often, yes. Siesta Key's Gulf-front location can trigger coastal construction control line review for additions and exterior work near the beach."},
      @{Q="Do you work on older homes near downtown Sarasota?"; A="Yes - older Southside Village and downtown-adjacent homes are a regular part of our work, and we scope them with extra care for existing conditions."},
      @{Q="Do you handle condo and townhome projects downtown, not just single-family homes?"; A="Yes, though condo and townhome projects typically involve an association review step alongside standard city permitting, which we factor into your timeline."},
      @{Q="What if a previous owner did unpermitted work on my home?"; A="It's more common than you'd think in older Sarasota neighborhoods. We check for it during our initial assessment so it's addressed as part of the project rather than discovered mid-renovation."}
    )
    Facts=@(
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><path d="M17 20h5v-2a4 4 0 0 0-3-3.87M9 20H4v-2a4 4 0 0 1 3-3.87m5-1.13a4 4 0 1 0-4-4M13 8a4 4 0 1 1 0 5.29"/></svg>'; Label="Population"; Value="~57,000"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><circle cx="12" cy="12" r="9"/><path d="M12 7v5l3 3"/></svg>'; Label="Drive from North Port"; Value="~35 minutes"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><path d="M21 10c0 6-9 12-9 12s-9-6-9-12a9 9 0 1 1 18 0z"/><circle cx="12" cy="10" r="3"/></svg>'; Label="Key Areas"; Value="Siesta Key, downtown, Southside Village"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><path d="M3 12h18M3 6h18M3 18h18"/></svg>'; Label="Local Challenge"; Value="Mixed city/county jurisdiction"}
    )
    NearbyLink1='<a href="/locations/venice.html">Venice</a>'
    NearbyLink2='<a href="/locations/bradenton.html">Bradenton</a>'
  },
  @{
    Slug="fort-myers"; Name="Fort Myers"
    HeaderLead="From the historic McGregor Boulevard corridor to the River District, we bring general contracting Fort Myers homeowners can rely on."
    PopIntro="Fort Myers is home to roughly 92,000 residents and falls under Lee County - a different permitting authority than the Sarasota and Charlotte County jurisdictions that cover most of our other service areas. It's the farthest reach of our service territory, and one we serve regularly for both remodeling and restoration. Fort Myers also serves as a gateway to Sanibel Island and the barrier islands further south, and we take on projects at that end of our territory as well when the scope fits."
    H2a="Remodeling &amp; New Construction in Fort Myers"
    Content1="The historic McGregor Boulevard corridor includes homes with genuine architectural character, and exterior work there is scoped to respect that rather than defaulting to a generic modern spec. Downtown's River District has its own mix of older and newer construction, each with different considerations for additions and remodeling work. McGregor Boulevard's famous canopy of royal palms is a protected feature of the corridor, and any exterior project near it needs to account for root systems and canopy clearance during planning, not just the usual setback and zoning requirements."
    H2b="Storm &amp; Water Damage Restoration in Fort Myers"
    Content2="Properties closer to the Caloosahatchee River and the routes toward the Sanibel Causeway see similar coastal exposure considerations to our other waterfront service areas - salt air, wind-driven rain, and in some cases flood elevation requirements that affect ground-level additions and any storm repair work. Fort Myers also sits closer to the direct path of major storm systems moving in from the Gulf than some of our more northern service areas, which is worth factoring into any storm mitigation conversation for a property here."
    Content3="Because Fort Myers permits are processed through Lee County - a separate authority from our other service areas - we track its requirements independently rather than assuming they line up with what applies elsewhere in our territory."
    IconList=@("McGregor Boulevard-area remodels &amp; additions","River District renovations","Storm and water damage restoration","Waterfront &amp; causeway-adjacent projects","New construction and kitchen/bath remodeling")
    H3a="Lee County Permitting"
    Content4="Fort Myers permits are processed through Lee County, which runs a different process than the Sarasota and Charlotte County jurisdictions covering the rest of our service area. We handle this permitting process directly so you don't have to learn a new system for one project."
    Callout="A historic McGregor Boulevard home and new construction near the River District call for genuinely different approaches - we scope each on the property's own terms."
    H3b="Coastal Exposure Near the Causeway"
    Content5="River and causeway-adjacent properties carry added coastal exposure considerations similar to our other waterfront service areas. Flood elevation certificates may be required for ground-level additions near the water, which we check before finalizing any project scope."
    Faqs=@(
      @{Q="Is Fort Myers permitting different from your other service areas?"; A="Yes - Fort Myers falls under Lee County, a separate permitting authority from the Sarasota and Charlotte County jurisdictions covering most of our other locations."},
      @{Q="Do you work on historic homes near McGregor Boulevard?"; A="Yes, and we scope exterior work there to respect the area's architectural character rather than defaulting to a generic modern approach."},
      @{Q="Do waterfront Fort Myers properties need special documentation?"; A="Often, yes. Properties near the Caloosahatchee River or Sanibel Causeway may need flood elevation certificates for ground-level additions."},
      @{Q="Do you take on projects toward Sanibel Island as well?"; A="Fort Myers is our southernmost regular service area and serves as a gateway to Sanibel and the barrier islands - reach out and we can confirm whether your specific project fits within our range."},
      @{Q="Do you work on historic homes as well as newer River District properties?"; A="Yes - we scope each property based on its actual construction era, whether that's a historic McGregor Boulevard home or newer construction downtown."}
    )
    Facts=@(
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><path d="M17 20h5v-2a4 4 0 0 0-3-3.87M9 20H4v-2a4 4 0 0 1 3-3.87m5-1.13a4 4 0 1 0-4-4M13 8a4 4 0 1 1 0 5.29"/></svg>'; Label="Population"; Value="~92,000"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><circle cx="12" cy="12" r="9"/><path d="M12 7v5l3 3"/></svg>'; Label="Drive from North Port"; Value="~40 minutes"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><path d="M21 10c0 6-9 12-9 12s-9-6-9-12a9 9 0 1 1 18 0z"/><circle cx="12" cy="10" r="3"/></svg>'; Label="Key Areas"; Value="McGregor Blvd, River District"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><path d="M3 12h18M3 6h18M3 18h18"/></svg>'; Label="Local Challenge"; Value="Separate Lee County permitting"}
    )
    NearbyLink1='<a href="/locations/punta-gorda.html">Punta Gorda</a>'
    NearbyLink2='<a href="/">North Port</a>'
  },
  @{
    Slug="bradenton"; Name="Bradenton"
    HeaderLead="From the Riverwalk district to Palma Sola, we bring general contracting Bradenton homeowners can count on - at the northern edge of our Gulf Coast service area."
    PopIntro="Bradenton is home to roughly 57,000 residents and serves as the seat of Manatee County, sitting along the Manatee River with a redeveloped downtown Riverwalk district and neighborhoods ranging from historic bungalows near downtown to newer construction further east. It's the northernmost city we serve regularly, and a different county jurisdiction than the Sarasota and Charlotte County areas that make up most of our territory."
    H2a="Remodeling &amp; New Construction in Bradenton"
    Content1="Manatee County runs its own permitting process, separate from the Sarasota and Charlotte County systems that cover most of our other service areas, so we track its specific requirements independently rather than assuming they line up with what applies elsewhere in our territory. Downtown Bradenton's Riverwalk redevelopment has also brought a wave of renewed interest in older homes nearby, many of which need updated electrical and plumbing brought up to current code as part of any meaningful remodel."
    H2b="Storm &amp; Water Damage Restoration in Bradenton"
    Content2="Homes along the Manatee River and toward Palma Sola Bay see the same salt-air and storm-surge exposure common throughout our coastal service area, while inland Bradenton neighborhoods deal more with drainage and roof damage from heavy seasonal rain. Bradenton is also the gateway to Anna Maria Island, and we occasionally take on storm-response and restoration work on the barrier island itself when the scope fits."
    Content3="We confirm which permitting authority applies to your specific address - City of Bradenton or unincorporated Manatee County - before submitting any paperwork, since the two don't always apply identical requirements."
    IconList=@("Riverwalk-area and downtown remodels &amp; additions","Palma Sola and waterfront property renovations","Storm and water damage restoration","New construction on Manatee County lots","Kitchen, bathroom &amp; whole-home projects")
    H3a="Manatee County Permitting"
    Content4="Bradenton permits are processed through Manatee County or the city, depending on your specific address - a different authority than the Sarasota and Charlotte County jurisdictions covering the rest of our service area. We handle this permitting process directly so you don't have to learn a new system for one project."
    Callout="Bradenton being our northernmost regular stop means we plan scheduling around the drive - which is exactly why we confirm scope and timeline clearly upfront rather than squeezing your project into a rushed window."
    H3b="Older Homes Near Downtown"
    Content5="Homes near downtown and the Riverwalk district are often older than what you'll find in Bradenton's newer eastern neighborhoods, which means more variables to check - existing electrical capacity, foundation condition, and whether prior renovations were permitted correctly - before we finalize a remodel or restoration plan."
    Faqs=@(
      @{Q="Is Bradenton part of your regular service area?"; A="Yes - Bradenton is our northernmost regular stop, and we take on remodeling, new construction, and restoration projects there just as we do closer to North Port."},
      @{Q="Does Bradenton have different permitting than Sarasota or Charlotte County?"; A="Yes - Bradenton falls under Manatee County or city permitting depending on your address, a separate authority from our other service areas."},
      @{Q="Do you take on projects near Anna Maria Island?"; A="Occasionally, yes, depending on scope - Bradenton serves as the gateway to Anna Maria Island and we can confirm whether your specific project fits within our range."},
      @{Q="Do older homes near downtown Bradenton need extra assessment before a remodel?"; A="Often, yes. Homes near the Riverwalk district tend to be older, and checking electrical capacity and prior permitting history is a regular part of our initial walkthrough."}
    )
    Facts=@(
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><path d="M17 20h5v-2a4 4 0 0 0-3-3.87M9 20H4v-2a4 4 0 0 1 3-3.87m5-1.13a4 4 0 1 0-4-4M13 8a4 4 0 1 1 0 5.29"/></svg>'; Label="Population"; Value="~57,000"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><circle cx="12" cy="12" r="9"/><path d="M12 7v5l3 3"/></svg>'; Label="Drive from North Port"; Value="~50 minutes"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><path d="M21 10c0 6-9 12-9 12s-9-6-9-12a9 9 0 1 1 18 0z"/><circle cx="12" cy="10" r="3"/></svg>'; Label="Key Areas"; Value="Riverwalk, Palma Sola, downtown"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><path d="M3 12h18M3 6h18M3 18h18"/></svg>'; Label="Local Challenge"; Value="Separate Manatee County permitting"}
    )
    NearbyLink1='<a href="/locations/sarasota.html">Sarasota</a>'
    NearbyLink2='<a href="/">North Port</a>'
  },
  @{
    Slug="boca-grande"; Name="Boca Grande"
    HeaderLead="From historic Banyan Street to the causeway, we bring careful, code-aware general contracting to Boca Grande's island homes and vacation properties."
    PopIntro="Boca Grande is a small historic village on Gasparilla Island, with a year-round population of roughly 1,000 that swells seasonally with vacation homeowners drawn to its beaches, tarpon fishing, and preserved old-Florida character. It's a different kind of project environment than our mainland service areas - lower density, higher-end construction, and real environmental and historic-review sensitivity given the island's protected status."
    H2a="Remodeling &amp; New Construction in Boca Grande"
    Content1="Gasparilla Island carries some of the most detailed architectural and environmental review of anywhere in our service area, given its status as a historic district and barrier island with protected dune and coastal construction control lines. Projects here typically take longer to permit than a comparable mainland project, and we build that into your timeline from the very first conversation rather than after work has already been scheduled."
    H2b="Storm &amp; Water Damage Restoration in Boca Grande"
    Content2="As a barrier island community, Boca Grande sees more direct Gulf exposure - storm surge, wind-driven rain, and salt air - than almost anywhere else in our territory, and access itself can be a factor during and after a major storm given the island's single causeway connection to the mainland. When storm or water damage hits, we handle assessment, stabilization, and full rebuild as one contractor, coordinating around island access as needed."
    Content3="We confirm coastal construction control line and historic district requirements early for any Boca Grande project, since those reviews shape what's allowed before a design is even finalized."
    IconList=@("Historic district-compliant remodels and additions","Coastal construction control line new builds","Storm and water damage restoration","High-end finish work for vacation properties","Corrosion-resistant materials for direct Gulf exposure")
    H3a="Historic District &amp; Environmental Review"
    Content4="Boca Grande's historic district status means exterior changes - even ones that would be routine on the mainland - often require additional review before permitting. We flag this during the initial walkthrough so it's factored into your timeline from the start, not discovered partway through design."
    Callout="Island access and review timelines both run differently in Boca Grande than on the mainland - we plan around both rather than promising a mainland-speed schedule for an island project."
    H3b="Building for Direct Gulf Exposure"
    Content5="Corrosion-resistant fasteners and hardware, wind-driven rain resistant detailing, and materials rated for constant salt exposure matter more here than almost anywhere else in our service area. We account for that in every material choice, not just the ones facing directly toward the water."
    Faqs=@(
      @{Q="Do you take on projects in Boca Grande, or is it too far from North Port?"; A="Yes, Boca Grande is part of our regular service area, though as an island community with detailed review requirements, projects there typically run on a longer timeline than a comparable mainland job."},
      @{Q="Does Boca Grande have stricter permitting than your other service areas?"; A="Yes - the island's historic district status and coastal construction control line requirements mean more review than a typical mainland project, which we factor into your schedule from the start."},
      @{Q="Can you work on vacation and seasonal properties, not just full-time residences?"; A="Yes, a large share of our Boca Grande work is on seasonal and vacation properties, coordinated around the owner's schedule."},
      @{Q="How does storm response work on an island with one causeway?"; A="We coordinate around island access as needed - it can affect timing right after a major storm, which is something we communicate clearly rather than promising a mainland-speed response."}
    )
    Facts=@(
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><path d="M17 20h5v-2a4 4 0 0 0-3-3.87M9 20H4v-2a4 4 0 0 1 3-3.87m5-1.13a4 4 0 1 0-4-4M13 8a4 4 0 1 1 0 5.29"/></svg>'; Label="Population"; Value="~1,000 (seasonal swell)"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><circle cx="12" cy="12" r="9"/><path d="M12 7v5l3 3"/></svg>'; Label="Drive from North Port"; Value="~50 minutes"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><path d="M21 10c0 6-9 12-9 12s-9-6-9-12a9 9 0 1 1 18 0z"/><circle cx="12" cy="10" r="3"/></svg>'; Label="Key Areas"; Value="Banyan Street, Gasparilla Island"},
      @{Icon='<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><path d="M3 12h18M3 6h18M3 18h18"/></svg>'; Label="Local Challenge"; Value="Historic &amp; coastal construction review"}
    )
    NearbyLink1='<a href="/locations/englewood.html">Englewood</a>'
    NearbyLink2='<a href="/locations/port-charlotte.html">Port Charlotte</a>'
  }
)

foreach ($s in $locations) {
    $body = Get-LocationBody -s $s
    $schema = (Get-LocationSchema -City $s.Name -Canonical "locations/$($s.Slug).html") + "`n" + (Get-FaqSchema -Faqs $s.Faqs)
    New-Page -Path (Join-Path $root "locations\$($s.Slug).html") -Title "General Contractor in $($s.Name), FL | Tropical Bay Builders" -Desc "$($s.HeaderLead)" -Canonical "locations/$($s.Slug).html" -Body $body -SchemaBlocks $schema
}

Write-Output "$($locations.Count) location pages built"
