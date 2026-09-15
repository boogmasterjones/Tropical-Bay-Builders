function applyQuotePrefill() {
  try {
    var msg = sessionStorage.getItem('quotePrefill');
    if (msg) {
      var field = document.getElementById('message');
      if (field) {
        field.value = msg;
        sessionStorage.removeItem('quotePrefill');
      }
    }
  } catch (e) { /* sessionStorage unavailable, ignore */ }
}

function goToQuoteForm(prefillMessage) {
  try {
    if (prefillMessage) sessionStorage.setItem('quotePrefill', prefillMessage);
  } catch (e) { /* ignore */ }
  var quoteSection = document.getElementById('quote');
  if (quoteSection) {
    quoteSection.scrollIntoView({ behavior: 'smooth', block: 'start' });
    setTimeout(applyQuotePrefill, 350);
  } else {
    window.location.href = '/#quote';
  }
}

document.addEventListener('DOMContentLoaded', function () {
  applyQuotePrefill();

  // Homepage: reveal the header only after the user scrolls past the hero area
  if (document.body.classList.contains('home')) {
    var header = document.querySelector('.site-header');
    if (header) {
      var revealThreshold = 60;
      var updateHeader = function () {
        if (window.scrollY > revealThreshold) {
          header.classList.add('header-visible');
        } else {
          header.classList.remove('header-visible');
        }
      };
      window.addEventListener('scroll', updateHeader, { passive: true });
      updateHeader();
    }
  }

  var toggle = document.querySelector('.menu-toggle');
  var nav = document.querySelector('.main-nav');
  if (toggle && nav) {
    function closeNav() {
      nav.classList.remove('open');
      toggle.setAttribute('aria-expanded', 'false');
    }

    toggle.addEventListener('click', function (e) {
      e.stopPropagation();
      var isOpen = nav.classList.toggle('open');
      toggle.setAttribute('aria-expanded', isOpen ? 'true' : 'false');
    });

    nav.addEventListener('click', function (e) {
      if (e.target.tagName === 'A') closeNav();
    });

    document.addEventListener('click', function (e) {
      if (!nav.contains(e.target) && !toggle.contains(e.target)) closeNav();
    });

    document.addEventListener('keydown', function (e) {
      if (e.key === 'Escape') closeNav();
    });
  }

  var track = document.querySelector('.work-track');
  var prevBtn = document.querySelector('.work-arrow.prev');
  var nextBtn = document.querySelector('.work-arrow.next');
  if (track && prevBtn && nextBtn) {
    var scrollByAmount = function () {
      var slide = track.querySelector('.work-slide');
      return slide ? slide.getBoundingClientRect().width + 20 : 300;
    };
    prevBtn.addEventListener('click', function () {
      track.scrollBy({ left: -scrollByAmount(), behavior: 'smooth' });
    });
    nextBtn.addEventListener('click', function () {
      track.scrollBy({ left: scrollByAmount(), behavior: 'smooth' });
    });
  }

  // ---- Reviews carousel (mobile horizontal swipe row) ----
  var reviewsTrack = document.querySelector('.reviews-grid');
  var reviewsPrev = document.getElementById('reviews-prev');
  var reviewsNext = document.getElementById('reviews-next');
  if (reviewsTrack && reviewsPrev && reviewsNext) {
    var reviewsScrollByAmount = function () {
      var card = reviewsTrack.querySelector('.review-card');
      return card ? card.getBoundingClientRect().width + 16 : 300;
    };
    reviewsPrev.addEventListener('click', function () {
      reviewsTrack.scrollBy({ left: -reviewsScrollByAmount(), behavior: 'smooth' });
    });
    reviewsNext.addEventListener('click', function () {
      reviewsTrack.scrollBy({ left: reviewsScrollByAmount(), behavior: 'smooth' });
    });
  }

  // ---- Quote form: require phone OR email, not both ----
  var quoteForm = document.querySelector('.quote-form');
  if (quoteForm) {
    var phoneInput = quoteForm.querySelector('input[name="phone"]');
    var emailInput = quoteForm.querySelector('input[name="email"]');
    if (phoneInput && emailInput) {
      var clearContactValidity = function () {
        phoneInput.setCustomValidity('');
        emailInput.setCustomValidity('');
      };
      quoteForm.addEventListener('submit', function (e) {
        if (!phoneInput.value.trim() && !emailInput.value.trim()) {
          e.preventDefault();
          var msg = 'Please enter a phone number or an email so we can reach you.';
          phoneInput.setCustomValidity(msg);
          phoneInput.reportValidity();
        }
      });
      phoneInput.addEventListener('input', clearContactValidity);
      emailInput.addEventListener('input', clearContactValidity);
    }
  }
});

/* =====================================================================
   Chatbot widget — scripted FAQ assistant, not a live agent or real AI.
   Answers common questions from quick-reply chips or simple keyword
   matching, and always offers a path to call or request a free estimate.
   ===================================================================== */
(function () {
  var PHONE_DISPLAY = '(941) 336-6255';
  var PHONE_TEL = 'tel:+19413366255';

  var BOOKING_NUDGE = " The fastest next step is requesting your free estimate — it only takes a minute.";

  var TOPICS = {
    pricing: {
      label: 'Pricing',
      response: 'Every project is different, so we don\'t quote pricing sight-unseen. We walk the property, talk through scope and materials, and give you a clear written estimate before any work starts.' + BOOKING_NUDGE,
      chips: [{ label: 'Get a Free Estimate', action: 'quote' }, { label: 'Call ' + PHONE_DISPLAY, action: 'call' }]
    },
    areas: {
      label: 'Service Areas',
      response: 'We regularly serve North Port, Port Charlotte, Punta Gorda, Venice, Englewood, Sarasota, and Fort Myers, FL. If your town isn\'t listed, there\'s a good chance we still cover it — just ask!' + BOOKING_NUDGE,
      chips: [{ label: 'Get a Free Estimate', action: 'quote' }, { label: 'See All Service Areas', action: 'link', url: '/service-areas.html' }]
    },
    included: {
      label: "What's Included",
      response: 'We handle kitchen and bathroom remodeling, new construction, roofing, fences, driveways and patios, epoxy flooring, custom woodworking, and disaster restoration (storm, water, and fire damage) — all under one accountable crew.' + BOOKING_NUDGE,
      chips: [{ label: 'Get a Free Estimate', action: 'quote' }, { label: 'See All Services', action: 'link', url: '/our-services.html' }]
    },
    insurance: {
      label: 'Licensed & Insured?',
      response: "Yes — Tropical Bay Builders is licensed and insured, and we're happy to provide proof before any job starts." + BOOKING_NUDGE,
      chips: [{ label: 'Get a Free Estimate', action: 'quote' }, { label: 'Why That Matters', action: 'link', url: '/blog/how-to-hire-a-good-general-contractor-in-southwest-florida.html' }]
    },
    callback: {
      label: 'Book a Callback',
      response: "Happy to help! The fastest way is to call us directly at " + PHONE_DISPLAY + ". Or skip the wait and request your free estimate directly — no call needed.",
      chips: [{ label: 'Get a Free Estimate', action: 'quote' }, { label: 'Call ' + PHONE_DISPLAY, action: 'call' }, { label: 'Request a Callback', action: 'quote-callback' }]
    },
    quote: {
      label: 'Get a Free Estimate',
      response: "Let's get your project scoped — just fill out a few quick details and we'll follow up fast with next steps.",
      chips: [{ label: 'Get a Free Estimate', action: 'quote' }]
    }
  };

  var KEYWORD_MAP = [
    { topic: 'pricing', words: ['price', 'pricing', 'cost', 'how much', 'rate', 'estimate cost', 'expensive', 'cheap'] },
    { topic: 'areas', words: ['area', 'areas', 'location', 'city', 'cities', 'serve', 'zip', 'near me', 'north port', 'venice', 'sarasota', 'fort myers', 'englewood', 'punta gorda', 'port charlotte'] },
    { topic: 'included', words: ['include', 'included', 'kitchen', 'bathroom', 'remodel', 'construction', 'roof', 'fence', 'restoration', 'what do you do', 'service include'] },
    { topic: 'insurance', words: ['insur', 'licens', 'liability', 'bonded', 'coi'] },
    { topic: 'callback', words: ['call back', 'callback', 'call me', 'phone me', 'talk to someone', 'speak to'] },
    { topic: 'quote', words: ['quote', 'book', 'schedule', 'appointment', 'estimate', 'sign up', 'hire you'] }
  ];

  var STORAGE_INTERACTED = 'chatbotInteracted';
  var STORAGE_AUTO_SHOWN = 'chatbotAutoShown';

  var panel, messagesEl, chipsEl, toggleBtn, pingEl, inputEl;
  var greeted = false;

  function el(tag, cls, html) {
    var e = document.createElement(tag);
    if (cls) e.className = cls;
    if (html !== undefined) e.innerHTML = html;
    return e;
  }

  function scrollMessagesToBottom() {
    messagesEl.scrollTop = messagesEl.scrollHeight;
  }

  function addMessage(text, sender) {
    var bubble = el('div', 'chatbot-msg ' + sender, text);
    messagesEl.appendChild(bubble);
    scrollMessagesToBottom();
  }

  function renderChips(chips) {
    chipsEl.innerHTML = '';
    chips.forEach(function (chip) {
      var btn = el('button', 'chatbot-chip' + (chip.action === 'quote' || chip.action === 'quote-callback' || chip.action === 'call' ? ' chip-cta' : ''), chip.label);
      btn.type = 'button';
      btn.addEventListener('click', function () { handleChipClick(chip); });
      chipsEl.appendChild(btn);
    });
  }

  function defaultChips() {
    return [
      { label: 'Get a Free Estimate', action: 'quote' },
      { label: 'Pricing', action: 'topic', topic: 'pricing' },
      { label: 'Service Areas', action: 'topic', topic: 'areas' },
      { label: "What's Included", action: 'topic', topic: 'included' },
      { label: 'Book a Callback', action: 'topic', topic: 'callback' }
    ];
  }

  function handleChipClick(chip) {
    if (chip.action === 'topic') {
      var topic = TOPICS[chip.topic];
      addMessage(topic.label, 'user');
      setTimeout(function () {
        addMessage(topic.response, 'bot');
        renderChips(topic.chips.concat([{ label: 'Something Else', action: 'menu' }]));
      }, 350);
      return;
    }
    if (chip.action === 'menu') {
      addMessage('Something else', 'user');
      setTimeout(function () {
        addMessage('Sure — what would you like to know?', 'bot');
        renderChips(defaultChips());
      }, 300);
      return;
    }
    if (chip.action === 'call') {
      window.location.href = PHONE_TEL;
      return;
    }
    if (chip.action === 'quote') {
      addMessage(chip.label || 'Get a Free Estimate', 'user');
      setTimeout(function () {
        addMessage("Great — I'm taking you to our booking form now.", 'bot');
        closePanel();
        goToQuoteForm();
      }, 300);
      return;
    }
    if (chip.action === 'quote-callback') {
      addMessage('Request a Callback', 'user');
      setTimeout(function () {
        addMessage("Perfect — I'm pulling up our form with a note that you'd like a callback.", 'bot');
        closePanel();
        goToQuoteForm("I'd like to request a callback — please call me back at your earliest convenience.");
      }, 300);
      return;
    }
    if (chip.action === 'link') {
      window.location.href = chip.url;
      return;
    }
  }

  function matchKeyword(text) {
    var lower = text.toLowerCase();
    for (var i = 0; i < KEYWORD_MAP.length; i++) {
      var entry = KEYWORD_MAP[i];
      for (var j = 0; j < entry.words.length; j++) {
        if (lower.indexOf(entry.words[j]) !== -1) return entry.topic;
      }
    }
    return null;
  }

  function handleUserText(text) {
    text = text.trim();
    if (!text) return;
    addMessage(text, 'user');
    inputEl.value = '';
    var topicKey = matchKeyword(text);
    setTimeout(function () {
      if (topicKey) {
        var topic = TOPICS[topicKey];
        addMessage(topic.response, 'bot');
        renderChips(topic.chips.concat([{ label: 'Something Else', action: 'menu' }]));
      } else {
        addMessage("I might not have that answer on hand, but our team will! Easiest way to get it sorted is to book your appointment and ask us directly.", 'bot');
        renderChips([
          { label: 'Get a Free Estimate', action: 'quote' },
          { label: 'Call ' + PHONE_DISPLAY, action: 'call' },
          { label: 'Something Else', action: 'menu' }
        ]);
      }
    }, 400);
  }

  function greet() {
    if (greeted) return;
    greeted = true;
    addMessage("Hi! I'm the Tropical Bay Assistant. I can help with quick questions or get you booked — what can I help with?", 'bot');
    renderChips(defaultChips());
  }

  function markInteracted() {
    try { sessionStorage.setItem(STORAGE_INTERACTED, '1'); } catch (e) { /* ignore */ }
  }

  function openPanel() {
    panel.classList.add('open');
    toggleBtn.classList.add('open');
    toggleBtn.setAttribute('aria-expanded', 'true');
    if (pingEl) pingEl.classList.add('hidden');
    markInteracted();
    greet();
    inputEl.focus({ preventScroll: true });
  }

  function closePanel() {
    panel.classList.remove('open');
    toggleBtn.classList.remove('open');
    toggleBtn.setAttribute('aria-expanded', 'false');
  }

  function togglePanel() {
    if (panel.classList.contains('open')) { closePanel(); } else { openPanel(); }
  }

  function buildWidget() {
    var wrap = el('div', 'chatbot-widget');

    toggleBtn = el('button', 'chatbot-toggle');
    toggleBtn.type = 'button';
    toggleBtn.setAttribute('aria-label', 'Chat with Tropical Bay Assistant');
    toggleBtn.setAttribute('aria-expanded', 'false');
    toggleBtn.innerHTML =
      '<svg class="chatbot-icon-chat" width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="#ffffff" stroke-width="2"><path d="M21 11.5a8.38 8.38 0 0 1-.9 3.8 8.5 8.5 0 0 1-7.6 4.7 8.38 8.38 0 0 1-3.8-.9L3 21l1.9-5.7a8.38 8.38 0 0 1-.9-3.8 8.5 8.5 0 0 1 4.7-7.6 8.38 8.38 0 0 1 3.8-.9h.5a8.48 8.48 0 0 1 8 8v.5z"/></svg>' +
      '<svg class="chatbot-icon-close" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#ffffff" stroke-width="2.4"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg>';
    pingEl = el('span', 'chatbot-ping');
    toggleBtn.appendChild(pingEl);

    panel = el('div', 'chatbot-panel');
    panel.setAttribute('role', 'dialog');
    panel.setAttribute('aria-label', 'Tropical Bay Assistant chat');

    var header = el('div', 'chatbot-header');
    header.innerHTML =
      '<div class="chatbot-header-title"><span class="chatbot-status-dot"></span><span>Tropical Bay Assistant<span class="chatbot-header-sub">Typically replies instantly</span></span></div>';
    var closeBtn = el('button', 'chatbot-close');
    closeBtn.type = 'button';
    closeBtn.setAttribute('aria-label', 'Close chat');
    closeBtn.innerHTML = '<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.4"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg>';
    closeBtn.addEventListener('click', closePanel);
    header.appendChild(closeBtn);

    messagesEl = el('div', 'chatbot-messages');
    chipsEl = el('div', 'chatbot-quick-replies');

    var inputRow = el('div', 'chatbot-input-row');
    inputEl = document.createElement('input');
    inputEl.type = 'text';
    inputEl.placeholder = 'Type a question…';
    inputEl.setAttribute('aria-label', 'Type a question');
    var sendBtn = el('button', 'chatbot-send');
    sendBtn.type = 'button';
    sendBtn.setAttribute('aria-label', 'Send message');
    sendBtn.innerHTML = '<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.3"><line x1="22" y1="2" x2="11" y2="13"/><polygon points="22 2 15 22 11 13 2 9 22 2"/></svg>';
    sendBtn.addEventListener('click', function () { handleUserText(inputEl.value); });
    inputEl.addEventListener('keydown', function (e) {
      if (e.key === 'Enter') { e.preventDefault(); handleUserText(inputEl.value); }
    });
    inputRow.appendChild(inputEl);
    inputRow.appendChild(sendBtn);

    panel.appendChild(header);
    panel.appendChild(messagesEl);
    panel.appendChild(chipsEl);
    panel.appendChild(inputRow);

    wrap.appendChild(panel);
    wrap.appendChild(toggleBtn);
    document.body.appendChild(wrap);

    toggleBtn.addEventListener('click', togglePanel);
    document.addEventListener('keydown', function (e) {
      if (e.key === 'Escape' && panel.classList.contains('open')) closePanel();
    });
  }

  function getAutoTriggerY() {
    var sections = document.querySelectorAll('main > section');
    var sectionY = Infinity;
    if (sections.length >= 3) {
      var rect3 = sections[2].getBoundingClientRect();
      sectionY = rect3.bottom + window.scrollY;
    }
    var halfwayY = document.body.scrollHeight / 2;
    return Math.min(sectionY, halfwayY);
  }

  function setupAutoTrigger() {
    var alreadyInteracted, alreadyAutoShown;
    try {
      alreadyInteracted = sessionStorage.getItem(STORAGE_INTERACTED);
      alreadyAutoShown = sessionStorage.getItem(STORAGE_AUTO_SHOWN);
    } catch (e) { alreadyInteracted = null; alreadyAutoShown = null; }
    if (alreadyInteracted || alreadyAutoShown) return;

    var threshold = getAutoTriggerY();
    if (!isFinite(threshold)) return;

    var ticking = false;
    function onScroll() {
      if (ticking) return;
      ticking = true;
      requestAnimationFrame(function () {
        ticking = false;
        var interacted;
        try { interacted = sessionStorage.getItem(STORAGE_INTERACTED); } catch (e) { interacted = null; }
        if (interacted) {
          window.removeEventListener('scroll', onScroll);
          return;
        }
        if (window.scrollY >= threshold) {
          window.removeEventListener('scroll', onScroll);
          try { sessionStorage.setItem(STORAGE_AUTO_SHOWN, '1'); } catch (e) { /* ignore */ }
          openPanel();
        }
      });
    }
    window.addEventListener('scroll', onScroll, { passive: true });
  }

  document.addEventListener('DOMContentLoaded', function () {
    buildWidget();
    setupAutoTrigger();
  });
})();
