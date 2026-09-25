. "$PSScriptRoot\parts.ps1"
$root = Split-Path -Parent $PSScriptRoot

$faqSchema = Get-FaqSchema -Faqs @(
  @{Q="How much does a remodel or repair cost?"; A="It depends on scope, materials, and access, which is why we give every property a straightforward free estimate rather than a flat rate - a bathroom refresh and a full kitchen gut are not the same job."},
  @{Q="Do you serve areas outside North Port?"; A="Yes - we regularly serve Port Charlotte, Punta Gorda, Venice, Englewood, Sarasota, Bradenton, Fort Myers, and Boca Grande, FL."},
  @{Q="Can you handle both remodeling and storm damage restoration?"; A="Yes. We're a full general contractor, so we handle planned remodeling and new construction as well as storm, water, and fire damage restoration, with the same crew from start to finish."}
)
$schema = (Get-BizSchema) + "`n" + $faqSchema

$workSlides = @(
  @{Img="https://images.unsplash.com/photo-1600489000022-c2086d79f9d4?q=80&w=800&auto=format&fit=crop"; Alt="Remodeled kitchen with custom cabinetry and island"; Title="Kitchen Remodeling"; Sub="Full renovation, North Port"},
  @{Img="https://images.unsplash.com/photo-1620626011761-996317b8d101?q=80&w=800&auto=format&fit=crop"; Alt="Remodeled bathroom with walk-in shower"; Title="Bathroom Remodeling"; Sub="Walk-in shower conversion"},
  @{Img="https://images.unsplash.com/photo-1541976590-713941681591?q=80&w=800&auto=format&fit=crop"; Alt="New home construction site framing"; Title="New Construction"; Sub="Ground-up build, Southwest Florida"},
  @{Img="https://images.unsplash.com/photo-1635424825057-7fb6dcd651ef?q=80&w=800&auto=format&fit=crop"; Alt="Roofer fastening shingles during a roof replacement"; Title="Roofing"; Sub="Full roof replacement"},
  @{Img="https://images.unsplash.com/photo-1780838446281-9394772d07a8?q=80&w=800&auto=format&fit=crop"; Alt="Finished paver patio with stone retaining wall"; Title="Driveways &amp; Patios"; Sub="Paver patio installation"},
  @{Img="https://images.unsplash.com/photo-1772305595483-6b058aff40f9?q=80&w=800&auto=format&fit=crop"; Alt="Crew rolling epoxy coating onto a concrete floor"; Title="Epoxy Flooring"; Sub="Floor coating application"}
)
$workSlidesHtml = ($workSlides | ForEach-Object {
"        <div class=`"work-slide`">
          <div class=`"work-slide-media`">
            <img src=`"$($_.Img)`" alt=`"$($_.Alt)`" loading=`"lazy`" width=`"480`" height=`"360`">
          </div>
          <div class=`"work-slide-caption`">
            <strong>$($_.Title)</strong>
            <span>$($_.Sub)</span>
          </div>
        </div>"
}) -join "`n"

$reviews = @(
  @{Name="James A."; Quote="We were nervous about remodeling our kitchen, but the team at Tropical Bay Builders made the process so smooth and enjoyable. Their communication was excellent, and they completed the project on time and within budget. Our kitchen looks amazing!"},
  @{Name="Jacki J."; Quote="Just a fantastic experience. Elijah was quick to get to my house almost immediately after I called for help. Top quality work and above average customer service. I will use Tropical Bay Builders over and over again!"},
  @{Name="Toni P."; Quote="Exceptional quality and attention to detail. Not the cheapest quote I received, but the work was well worth the extra dollars. Neighbors also hired Tropical Bay Builders after seeing the quality of their work."},
  @{Name="Kevin D."; Quote="When it came time for the work to be done, they were on target with the estimated start date on my contract. Al kept me informed as to when the material and dumpster would be coming and verified the morning start time with me prior to their arrival. While here his men were very professional and courteous. They kept my yard very clean during the process and were very careful not to damage any of my shrubs and planting around my house. I will call Tropical Bay Builders for any future home repairs or renovations."},
  @{Name="Jessica L."; Quote="They are very punctual, they are very good. The price is competitive and I wasn't disappointed with the service. They gave a due date and were able to make it. They did everything for just 14 hours."}
)
$starsSvg = '<svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l2.9 6.6 7.1.6-5.4 4.7 1.7 7-6.3-3.8L6 21l1.7-7L2.3 9.2l7.1-.6z"/></svg>'
$starsRow = ($starsSvg * 5)
$reviewsHtml = ($reviews | ForEach-Object {
"      <div class=`"review-card`">
        <span class=`"stars`" aria-label=`"5 star rating`">$starsRow</span>
        <p class=`"review-quote`">$($_.Quote)</p>
        <div class=`"review-meta`">
          <strong class=`"review-author`">$($_.Name)</strong>
          <span class=`"review-source`">Google Review</span>
        </div>
      </div>"
}) -join "`n"

$body = @"
<section class="hero">
  <div class="container hero-inner">
    <div>
      <span class="eyebrow">North Port &amp; Southwest Florida</span>
      <h1>Remodeling &amp; Construction in <em>North Port</em>, FL</h1>
      <p class="lead">We're Tropical Bay Builders, a locally owned general contractor based in North Port and serving the Gulf Coast from Bradenton down to Sanibel Island. Kitchen and bathroom remodeling, new construction, and full exterior upgrades - plus storm, water, and fire damage restoration - done right the first time.</p>
      <div class="hero-actions">
        <a href="$PhoneTel" class="btn btn-outline" onclick="gtag('event','call_click',{'event_category':'engagement','event_label':'hero_phone_button'})">Call $Phone</a>
        <a href="/#quote" class="btn btn-primary">Get a Free Estimate</a>
      </div>
      <div class="hero-trust">
        <span class="item"><span class="check-mark">&#10003;</span> Licensed &amp; Insured</span>
        <span class="item"><span class="check-mark">&#10003;</span> Free, No-Obligation Estimates</span>
        <span class="item"><span class="check-mark">&#10003;</span> 10+ Years in Business</span>
        <span class="item stars-inline">
          <span class="stars" aria-label="5 star rating">$starsRow</span>
          5.0 Stars, 42 Reviews
        </span>
      </div>
    </div>
    <div class="hero-visual">
      <div class="hero-visual-grid">
        <div class="hero-visual-card">
          <svg width="34" height="34" viewBox="0 0 24 24" fill="none" stroke="#7fe0c4" stroke-width="1.8"><rect x="3" y="3" width="18" height="18" rx="2"/><line x1="12" y1="3" x2="12" y2="21"/><line x1="3" y1="12" x2="21" y2="12"/></svg>
          <strong>Remodeling</strong>
          <span>Kitchens &amp; bathrooms</span>
        </div>
        <div class="hero-visual-card">
          <svg width="34" height="34" viewBox="0 0 24 24" fill="none" stroke="#7fe0c4" stroke-width="1.8"><path d="M3 21h18M5 21V7l7-4 7 4v14M9 21v-6h6v6"/></svg>
          <strong>New Construction</strong>
          <span>Ground-up builds</span>
        </div>
        <div class="hero-visual-card">
          <svg width="34" height="34" viewBox="0 0 24 24" fill="none" stroke="#7fe0c4" stroke-width="1.8"><path d="M12 3l2.5 5.5L20 9l-4 4 1 6-5-3-5 3 1-6-4-4 5.5-.5z"/></svg>
          <strong>Restoration</strong>
          <span>Storm, water &amp; fire</span>
        </div>
        <div class="hero-visual-card">
          <svg width="34" height="34" viewBox="0 0 24 24" fill="none" stroke="#7fe0c4" stroke-width="1.8"><circle cx="12" cy="12" r="9"/><path d="M9 12l2 2 4-4"/></svg>
          <strong>Satisfaction</strong>
          <span>Guaranteed results</span>
        </div>
      </div>
    </div>
  </div>
</section>

<section class="section-green">
  <div class="container">
    <div class="section-head">
      <span class="eyebrow-dark">See Our Work</span>
      <h2>Real Results</h2>
      <p>A sample of the remodeling, construction, and restoration work we do across North Port and Southwest Florida.</p>
    </div>
    <div class="work-gallery">
      <div class="work-track">
$workSlidesHtml
      </div>
      <div class="work-controls">
        <button class="work-arrow prev" aria-label="Previous photos"><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.4"><path d="M15 18l-6-6 6-6"/></svg></button>
        <button class="work-arrow next" aria-label="Next photos"><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.4"><path d="M9 18l6-6-6-6"/></svg></button>
      </div>
    </div>
  </div>
</section>

<section>
  <div class="container">
    <div class="section-head">
      <span class="eyebrow-dark">Reviews</span>
      <h2>What Our Customers Are Saying</h2>
      <p>Real feedback from our Google Business Profile.</p>
    </div>
    <div class="reviews-grid">
$reviewsHtml
    </div>
    <div class="reviews-controls">
      <button class="work-arrow prev" id="reviews-prev" aria-label="Previous reviews"><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.4"><path d="M15 18l-6-6 6-6"/></svg></button>
      <button class="work-arrow next" id="reviews-next" aria-label="Next reviews"><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.4"><path d="M9 18l6-6-6-6"/></svg></button>
    </div>
  </div>
$(Get-CtaStrip -Heading "Ready to Join Our Happy Customers?" -Text "Get a free, no-obligation estimate for your home or property." -EventLabel "strip_phone_button_reviews")
</section>

<section class="section-orange" id="quote">
  <div class="container">
    <div class="section-head">
      <span class="eyebrow-dark">Free Estimate</span>
      <h2>Request A Quote Today!</h2>
    </div>
    <div class="quote-layout">
      <div class="quote-card">
        <form class="quote-form" name="estimate-request" method="POST" action="https://formsubmit.co/$Email">
          <input type="hidden" name="_subject" value="New Free Estimate Request - Tropical Bay Builders">
          <input type="hidden" name="_next" value="https://www.tropicalbaybuilders.com/thank-you.html">
          <input type="hidden" name="_captcha" value="false">
          <input type="hidden" name="_template" value="table">
          <p style="display:none"><label>Leave this field blank: <input name="_honey"></label></p>

          <span class="field-label" style="margin-top:0;">Full Name *</span>
          <div class="field-row">
            <input type="text" name="name" placeholder="Full Name" required>
            <input type="tel" name="phone" placeholder="Phone (or email below)">
          </div>

          <div class="quote-stage" data-stage="2">
          <span class="field-label">Email &amp; Service Area *</span>
          <p class="field-hint">Phone or email required so we can reach you.</p>
          <div class="field-row">
            <input type="email" name="email" placeholder="Email (or phone above)">
            <select name="service-area" required>
              <option value="" disabled selected>City / Service Area</option>
              <option>North Port</option>
              <option>Port Charlotte</option>
              <option>Punta Gorda</option>
              <option>Venice</option>
              <option>Englewood</option>
              <option>Sarasota</option>
              <option>Bradenton</option>
              <option>Fort Myers</option>
              <option>Boca Grande</option>
              <option>Other</option>
            </select>
          </div>

          <span class="field-label">Select a Service *</span>
          <div class="check-grid">
            <label class="check-item"><input type="checkbox" name="service[]" value="Kitchen Remodeling"> Kitchen Remodeling</label>
            <label class="check-item"><input type="checkbox" name="service[]" value="Bathroom Remodeling"> Bathroom Remodeling</label>
            <label class="check-item"><input type="checkbox" name="service[]" value="New Construction"> New Construction</label>
            <label class="check-item"><input type="checkbox" name="service[]" value="Exterior Remodel/Additions"> Exterior Remodel / Additions</label>
            <label class="check-item"><input type="checkbox" name="service[]" value="Roofing"> Roofing</label>
            <label class="check-item"><input type="checkbox" name="service[]" value="Fences"> Fences</label>
            <label class="check-item"><input type="checkbox" name="service[]" value="Driveways/Patios"> Driveways / Patios</label>
            <label class="check-item"><input type="checkbox" name="service[]" value="Epoxy Flooring"> Epoxy Flooring</label>
            <label class="check-item"><input type="checkbox" name="service[]" value="Woodworking"> Custom Woodworking</label>
            <label class="check-item"><input type="checkbox" name="service[]" value="Storm/Water/Fire Restoration"> Storm / Water / Fire Restoration</label>
            <label class="check-item"><input type="checkbox" name="service[]" value="Other"> Other</label>
          </div>
          </div>

          <div class="quote-stage" data-stage="3">
          <span class="field-label">When Would You Like This Completed?</span>
          <div class="radio-grid">
            <label class="radio-item"><input type="radio" name="timing" value="Timing is flexible"> Timing is Flexible</label>
            <label class="radio-item"><input type="radio" name="timing" value="Within 2 months"> Within 2 Months</label>
            <label class="radio-item"><input type="radio" name="timing" value="More than 2 months"> More Than 2 Months</label>
          </div>

          <span class="field-label">Project Status</span>
          <div class="radio-grid">
            <label class="radio-item"><input type="radio" name="status" value="Ready to hire"> Ready to Hire</label>
            <label class="radio-item"><input type="radio" name="status" value="Planning & budgeting"> Planning &amp; Budgeting</label>
          </div>

          <span class="field-label">Tell Us About Your Project</span>
          <textarea name="message" id="message" placeholder="Property type, project scope, timeline, etc."></textarea>

          <button type="submit" class="btn btn-primary">Submit</button>
          </div>
        </form>
      </div>

      <div class="quote-chat">
        <span class="eyebrow-dark">Let's Chat</span>
        <h2>Let's Get in Touch!</h2>
        <p>Contact us today to receive a free estimate for your project. Fill out the form or call now, and we'll be happy to help with scheduling, pricing, or any questions about the process.</p>
        <a href="$PhoneTel" class="btn btn-primary" onclick="gtag('event','call_click',{'event_category':'engagement','event_label':'quote_section_phone_button'})">Call $Phone</a>
        <div class="quote-trust">
          <span class="item"><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M9 12l2 2 4-4"/><circle cx="12" cy="12" r="9"/></svg> Licensed &amp; Insured</span>
          <span class="item"><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="9"/><line x1="12" y1="8" x2="12" y2="16"/><line x1="8" y1="12" x2="16" y2="12"/></svg> Free, No-Obligation Estimates</span>
          <span class="item">$starsSvg 5.0 Stars, 42 Reviews</span>
        </div>
      </div>
    </div>
  </div>
</section>

<section>
  <div class="container">
    <div class="section-head">
      <span class="eyebrow-dark">What We Do</span>
      <h2>Remodeling &amp; Construction for North Port Homes &amp; Businesses</h2>
      <p>From a single-room refresh to full new construction, we bring the same careful, accountable approach to every job.</p>
    </div>
    <div class="grid-3">
      <div class="card">
        <div class="icon-badge"><svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="#ffffff" stroke-width="2"><rect x="3" y="3" width="18" height="18" rx="2"/><line x1="12" y1="3" x2="12" y2="21"/><line x1="3" y1="12" x2="21" y2="12"/></svg></div>
        <h3>Kitchen Remodeling</h3>
        <p>Custom cabinetry, layouts built for real cooking and entertaining, and finishes that hold up to Florida living.</p>
        <a href="/services/kitchen-remodeling.html" class="card-link">Learn more &rarr;</a>
      </div>
      <div class="card">
        <div class="icon-badge"><svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="#ffffff" stroke-width="2"><path d="M4 4h16v16H4zM8 4v16M16 4v16"/></svg></div>
        <h3>Bathroom Remodeling</h3>
        <p>Full bathroom renovations - showers, tubs, vanities, and tile - built with proper waterproofing for Florida's humidity.</p>
        <a href="/services/bathroom-remodeling.html" class="card-link">Learn more &rarr;</a>
      </div>
      <div class="card">
        <div class="icon-badge"><svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="#ffffff" stroke-width="2"><path d="M3 21h18M5 21V7l7-4 7 4v14M9 21v-6h6v6"/></svg></div>
        <h3>New Construction</h3>
        <p>Ground-up builds and major additions managed by one accountable general contractor, permitting included.</p>
        <a href="/services/new-construction.html" class="card-link">Learn more &rarr;</a>
      </div>
      <div class="card">
        <div class="icon-badge"><svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="#ffffff" stroke-width="2"><path d="M4 21V8l8-5 8 5v13M9 21v-7h6v7"/></svg></div>
        <h3>Exterior Remodel &amp; Additions</h3>
        <p>Siding, room additions, lanai enclosures, and outdoor living upgrades that boost curb appeal and value.</p>
        <a href="/services/exterior-remodel-additions.html" class="card-link">Learn more &rarr;</a>
      </div>
      <div class="card">
        <div class="icon-badge"><svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="#ffffff" stroke-width="2"><path d="M3 7h18M5 7l1 13h12l1-13M9 11v5M15 11v5"/></svg></div>
        <h3>Roofing</h3>
        <p>Roof repairs, full replacements, and storm-ready installations built to handle Southwest Florida's wind and rain.</p>
        <a href="/services/roofing.html" class="card-link">Learn more &rarr;</a>
      </div>
      <div class="card">
        <div class="icon-badge"><svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="#ffffff" stroke-width="2"><path d="M4 4v16M20 4v16M4 8h16M4 16h16"/></svg></div>
        <h3>Fences</h3>
        <p>Privacy, picket, and pool-code-compliant fencing in vinyl, aluminum, and wood, built for the Florida coast.</p>
        <a href="/services/fences.html" class="card-link">Learn more &rarr;</a>
      </div>
      <div class="card">
        <div class="icon-badge"><svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="#ffffff" stroke-width="2"><path d="M4 4h16v16H4z"/><path d="M4 12h16M12 4v16"/></svg></div>
        <h3>Driveways &amp; Patios</h3>
        <p>Concrete and paver driveways, patios, and outdoor living hardscaping with proper base prep and drainage.</p>
        <a href="/services/driveways-patios.html" class="card-link">Learn more &rarr;</a>
      </div>
      <div class="card">
        <div class="icon-badge"><svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="#ffffff" stroke-width="2"><rect x="3" y="3" width="18" height="18" rx="2"/><circle cx="8.5" cy="8.5" r="1.5"/><path d="M21 15l-5-5L5 21"/></svg></div>
        <h3>Epoxy Flooring</h3>
        <p>Durable, low-maintenance epoxy floor coatings for garages, workshops, patios, and interior floors.</p>
        <a href="/services/epoxy-flooring.html" class="card-link">Learn more &rarr;</a>
      </div>
      <div class="card">
        <div class="icon-badge"><svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="#ffffff" stroke-width="2"><path d="M3 3h18v18H3z"/><path d="M3 9h18M9 21V9"/></svg></div>
        <h3>Custom Woodworking</h3>
        <p>Built-ins, custom cabinetry, and trim work finished to a fine standard, built for Florida's humidity.</p>
        <a href="/services/woodworking.html" class="card-link">Learn more &rarr;</a>
      </div>
    </div>
  </div>
$(Get-CtaStrip -Heading "Ready to See the Difference?" -Text "Get a free, no-obligation estimate for your home or business.")
</section>

<section class="section-green">
  <div class="container">
    <div class="section-head">
      <span class="eyebrow-dark">Disaster Restoration</span>
      <h2>Storm, Water &amp; Fire Damage Restoration</h2>
      <p>Because we're a full general contractor, we can take a property from initial damage through complete rebuild - under one accountable crew, not a handoff between separate companies.</p>
    </div>
    <div class="grid-2">
      <div class="card">
        <div class="icon-badge"><svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="#ffffff" stroke-width="2"><path d="M12 3l2.5 5.5L20 9l-4 4 1 6-5-3-5 3 1-6-4-4 5.5-.5z"/></svg></div>
        <h3>Storm Damage Restoration</h3>
        <p>Roof, structural, and property damage repair after tropical storms and hurricanes.</p>
        <a href="/restoration/storm-damage-restoration.html" class="card-link">Learn more &rarr;</a>
      </div>
      <div class="card">
        <div class="icon-badge"><svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="#ffffff" stroke-width="2"><path d="M12 2.5c3 4 6 8 6 12a6 6 0 1 1-12 0c0-4 3-8 6-12z"/></svg></div>
        <h3>Water Damage &amp; Extraction</h3>
        <p>Water extraction and property repair after flooding, storm surge, or plumbing failures.</p>
        <a href="/restoration/water-damage-extraction.html" class="card-link">Learn more &rarr;</a>
      </div>
      <div class="card">
        <div class="icon-badge"><svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="#ffffff" stroke-width="2"><path d="M8 3s-3 3-3 7a4 4 0 0 0 8 0c0-1.5-1-2.5-1-2.5s.5 2-1 3c0 0 1-3-1-5.5C9.5 7 10 9 8 3z"/></svg></div>
        <h3>Fire Damage Restoration</h3>
        <p>Structural repair and full rebuild after fire damage, from assessment through finished remodeling.</p>
        <a href="/restoration/fire-damage-restoration.html" class="card-link">Learn more &rarr;</a>
      </div>
      <div class="card">
        <div class="icon-badge"><svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="#ffffff" stroke-width="2"><path d="M4 4h16v16H4zM4 12h16M12 4v16"/></svg></div>
        <h3>Storm Mitigation</h3>
        <p>Preventive upgrades that help protect your property before the next storm season.</p>
        <a href="/restoration/storm-mitigation.html" class="card-link">Learn more &rarr;</a>
      </div>
    </div>
  </div>
</section>

<section class="section-dark">
  <div class="container">
    <div class="stats-band">
      <div class="stat-tile">
        <div class="stat-icon">$starsSvg</div>
        <div class="stat-num">5-Star</div>
        <div class="stat-label">Rated Service</div>
      </div>
      <div class="stat-tile">
        <div class="stat-icon"><svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/><path d="M9 12l2 2 4-4"/></svg></div>
        <div class="stat-num">Licensed</div>
        <div class="stat-label">&amp; Fully Insured</div>
      </div>
      <div class="stat-tile">
        <div class="stat-icon"><svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 10c0 6-9 12-9 12s-9-6-9-12a9 9 0 1 1 18 0z"/><circle cx="12" cy="10" r="3"/></svg></div>
        <div class="stat-num">7 Cities</div>
        <div class="stat-label">Across Southwest Florida</div>
      </div>
      <div class="stat-tile">
        <div class="stat-icon"><svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M20 6L9 17l-5-5"/></svg></div>
        <div class="stat-num">10+</div>
        <div class="stat-label">Years in Business</div>
      </div>
    </div>
  </div>
</section>

<section class="section-orange">
  <div class="container">
    <div class="section-head">
      <span class="eyebrow-dark">How It Works</span>
      <h2>Booking a Project Is Simple</h2>
    </div>
    <div class="steps">
      <div class="step"><div class="num">1</div><h3>Call or Request a Quote</h3><p>Reach out by phone or the online form and tell us about your property and project.</p></div>
      <div class="step"><div class="num">2</div><h3>Free Estimate</h3><p>We walk the property and give you a straightforward, no-obligation price - no surprises.</p></div>
      <div class="step"><div class="num">3</div><h3>We Build</h3><p>Our crew shows up on schedule and treats your property with care from start to finish.</p></div>
      <div class="step"><div class="num">4</div><h3>Final Walkthrough</h3><p>We review the finished work together and stand behind it after the job is done.</p></div>
    </div>
  </div>
$(Get-CtaStrip -Heading "Questions About Scheduling?" -Text "Call us directly or request a quote and we'll get back to you fast." -EventLabel "strip_phone_button_2")
</section>

<section>
  <div class="container">
    <div class="section-head">
      <span class="eyebrow-dark">Service Area</span>
      <h2>Serving North Port &amp; Southwest Florida</h2>
      <p>Based in North Port, we regularly serve the surrounding communities across Sarasota, Charlotte, Manatee, and Lee counties.</p>
    </div>
    <div class="locations-grid">
      <a href="/" class="location-chip"><strong>North Port, FL</strong><span>Home base</span></a>
      <a href="/locations/port-charlotte.html" class="location-chip"><strong>Port Charlotte, FL</strong><span>~15 min away</span></a>
      <a href="/locations/punta-gorda.html" class="location-chip"><strong>Punta Gorda, FL</strong><span>~20 min away</span></a>
      <a href="/locations/venice.html" class="location-chip"><strong>Venice, FL</strong><span>~20 min away</span></a>
      <a href="/locations/englewood.html" class="location-chip"><strong>Englewood, FL</strong><span>~20 min away</span></a>
      <a href="/locations/sarasota.html" class="location-chip"><strong>Sarasota, FL</strong><span>~35 min away</span></a>
      <a href="/locations/bradenton.html" class="location-chip"><strong>Bradenton, FL</strong><span>~50 min away</span></a>
      <a href="/locations/fort-myers.html" class="location-chip"><strong>Fort Myers, FL</strong><span>~40 min away</span></a>
      <a href="/locations/boca-grande.html" class="location-chip"><strong>Boca Grande, FL</strong><span>~50 min away</span></a>
    </div>
    <p style="text-align:center; margin-top:24px;"><a href="/service-areas.html" class="btn btn-outline-dark">View All Service Areas</a></p>
  </div>
</section>

<section class="section-alt">
  <div class="container">
    <div class="cta-band">
      <h2>Ready to Start Your Project?</h2>
      <p>Call Tropical Bay Builders today or request a free estimate online. We're happy to answer questions about scheduling, pricing, or your specific project.</p>
      <div class="cta-actions">
        <a href="$PhoneTel" class="btn btn-outline" onclick="gtag('event','call_click',{'event_category':'engagement','event_label':'cta_band_phone_button'})">Call $Phone</a>
        <a href="/#quote" class="btn btn-primary">Request a Free Estimate</a>
      </div>
    </div>
  </div>
</section>

<section>
  <div class="container content-section">
    <h2>North Port General Contractor You Can Count On</h2>
    <p>Homeowners across North Port deal with a specific set of building challenges: Florida's humidity and sun that punish poorly-sealed materials, wind-load codes that only keep getting stricter, and a storm season that turns "someday" projects into urgent ones. Tropical Bay Builders is built around solving exactly those problems - real craftsmanship for planned remodels and new construction, and a fast, accountable response when storm, water, or fire damage turns a home upside down.</p>

    <div class="content-layout">
      <div class="content-main">
        <h3>Services We Provide</h3>
        <ul class="icon-list">
          <li><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M20 6L9 17l-5-5"/></svg> Kitchen &amp; bathroom remodeling</li>
          <li><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M20 6L9 17l-5-5"/></svg> New construction &amp; additions</li>
          <li><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M20 6L9 17l-5-5"/></svg> Roofing, fences &amp; hardscaping</li>
          <li><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M20 6L9 17l-5-5"/></svg> Epoxy flooring &amp; custom woodworking</li>
          <li><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M20 6L9 17l-5-5"/></svg> Storm, water &amp; fire damage restoration</li>
        </ul>

        <p>Whether you're searching for "general contractor near me," a "North Port remodeling contractor near me," or you need someone out fast after a storm, we're set up to help. We're licensed and insured, and we manage design, permitting, and construction as one accountable team based right here in North Port.</p>
        <div class="callout">
          <p>"Most of the regret we hear from homeowners starts the same way - hiring based on the lowest number instead of asking who's actually managing the job. That's the exact problem being a real general contractor, not a subcontractor broker, is built to solve."</p>
        </div>

        <h3>Communities We Serve Near North Port</h3>
        <p>In addition to North Port proper - including Wellen Park, North Port Estates, and the neighborhoods along the Toledo Blade corridor - we regularly serve Charlotte County (Port Charlotte, Punta Gorda), Sarasota County (Venice, Englewood, Sarasota), Manatee County (Bradenton), and Lee County (Fort Myers, Boca Grande). If your town isn't listed, give us a call - there's a good chance we still cover it.</p>

        <h3>Frequently Asked Questions</h3>
        <div class="faq-list">
          <details class="faq-item">
            <summary>How much does a remodel or repair cost?<span class="faq-icon"><svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/></svg></span></summary>
            <p>It depends on scope, materials, and access, which is why we give every property a straightforward free estimate rather than a flat rate - a bathroom refresh and a full kitchen gut simply aren't the same job.</p>
          </details>
          <details class="faq-item">
            <summary>Do you serve areas outside North Port?<span class="faq-icon"><svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/></svg></span></summary>
            <p>Yes - we regularly serve Port Charlotte, Punta Gorda, Venice, Englewood, Sarasota, Bradenton, Fort Myers, and Boca Grande. See our <a href="/service-areas.html">full service area list</a> or just give us a call.</p>
          </details>
          <details class="faq-item">
            <summary>Can you handle both remodeling and storm damage restoration?<span class="faq-icon"><svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/></svg></span></summary>
            <p>Yes. We're a full general contractor, so we handle planned remodeling and new construction as well as storm, water, and fire damage restoration, with the same crew from start to finish.</p>
          </details>
        </div>
      </div>

      <aside class="quick-facts">
        <h3>At a Glance</h3>
        <dl>
          <div class="fact">
            <div class="fact-icon"><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><path d="M21 10c0 6-9 12-9 12s-9-6-9-12a9 9 0 1 1 18 0z"/><circle cx="12" cy="10" r="3"/></svg></div>
            <div><dt>Based In</dt><dd>North Port, FL</dd></div>
          </div>
          <div class="fact">
            <div class="fact-icon"><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><path d="M17 20h5v-2a4 4 0 0 0-3-3.87M9 20H4v-2a4 4 0 0 1 3-3.87m5-1.13a4 4 0 1 0-4-4M13 8a4 4 0 1 1 0 5.29"/></svg></div>
            <div><dt>Serving</dt><dd>7 Southwest FL cities</dd></div>
          </div>
          <div class="fact">
            <div class="fact-icon"><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><path d="M9 12l2 2 4-4"/><circle cx="12" cy="12" r="9"/></svg></div>
            <div><dt>Coverage</dt><dd>Remodeling &amp; restoration</dd></div>
          </div>
          <div class="fact">
            <div class="fact-icon"><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#14876f" stroke-width="2"><circle cx="12" cy="12" r="9"/><line x1="12" y1="8" x2="12" y2="16"/><line x1="8" y1="12" x2="16" y2="12"/></svg></div>
            <div><dt>Estimates</dt><dd>Free, no obligation</dd></div>
          </div>
        </dl>
      </aside>
    </div>
$(Get-CtaStrip -Heading "Still Have Questions?" -Text "We're happy to talk through your project before you book." -EventLabel "strip_phone_button_3")
  </div>
</section>
"@

New-Page -Path (Join-Path $root "index.html") -Title "Remodeling & Construction in North Port, FL | Tropical Bay Builders" -Desc "Tropical Bay Builders provides kitchen & bath remodeling, new construction, and disaster restoration in North Port, FL. Licensed & insured, free estimates. Call $Phone." -Canonical "" -Body $body -SchemaBlocks $schema -BodyClass "home"

Write-Output "Homepage built"
