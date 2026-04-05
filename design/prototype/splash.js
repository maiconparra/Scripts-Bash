/**
 * WifiPirata OS — Splash overlay
 * Include this script in any page to show the splash until all resources are loaded.
 * Usage: <script src="splash.js"></script> (in <head>)
 */
(function () {
  'use strict';

  var MIN_DURATION = 1500; // minimum ms to show splash

  // 1) IMMEDIATELY hide page content via CSS (runs in <head>, before body renders)
  var blockStyle = document.createElement('style');
  blockStyle.id = 'wp-splash-block';
  blockStyle.textContent =
    'body{background:#05050a!important;}' +
    'body>*:not(#wp-splash){opacity:0!important;pointer-events:none!important;}';
  document.head.appendChild(blockStyle);

  // 2) Splash overlay styles
  var style = document.createElement('style');
  style.textContent =
    '#wp-splash{position:fixed;inset:0;display:flex;align-items:center;justify-content:center;background:#05050a;z-index:99999;transition:opacity 300ms ease;}' +
    '#wp-splash.hide{opacity:0;pointer-events:none;}' +
    '#wp-splash .sp-box{position:relative;width:220px;height:220px;display:flex;align-items:center;justify-content:center;}' +
    '@keyframes sp-pulse{0%{transform:scale(.96);filter:drop-shadow(0 8px 24px rgba(0,0,0,.6))}50%{transform:scale(1.02);filter:drop-shadow(0 18px 48px rgba(0,240,255,.18))}100%{transform:scale(.96);filter:drop-shadow(0 8px 24px rgba(0,0,0,.6))}}' +
    '@keyframes sp-wave{0%{transform:scale(.6);opacity:.6}50%{transform:scale(1.6);opacity:.12}100%{transform:scale(2.6);opacity:0}}' +
    '#wp-splash .sp-logo{width:220px;height:auto;position:relative;z-index:2;animation:sp-pulse 1400ms ease-in-out infinite;}' +
    '#wp-splash .sp-w{position:absolute;border:2px solid rgba(0,240,255,.18);border-radius:999px;width:220px;height:220px;animation:sp-wave 2000ms ease-out infinite;pointer-events:none;}' +
    '#wp-splash .sp-w.w2{animation-delay:300ms;border-color:rgba(139,92,246,.12);}' +
    '#wp-splash .sp-w.w3{animation-delay:700ms;border-color:rgba(0,240,255,.08);}';
  document.head.appendChild(style);

  // 3) Build overlay element
  var overlay = document.createElement('div');
  overlay.id = 'wp-splash';
  overlay.setAttribute('aria-hidden', 'true');
  overlay.innerHTML =
    '<div class="sp-box">' +
      '<div class="sp-w w1"></div>' +
      '<div class="sp-w w2"></div>' +
      '<div class="sp-w w3"></div>' +
      '<img src="assets/logo_branca.png" alt="WiFi Pirata" class="sp-logo">' +
    '</div>';

  // 4) Inject overlay as soon as body exists
  function inject() {
    document.body.insertBefore(overlay, document.body.firstChild);
  }

  // Try immediately (in case script is in body), otherwise wait
  if (document.body) {
    inject();
  } else {
    // Use MutationObserver to catch body creation ASAP (faster than DOMContentLoaded)
    var observer = new MutationObserver(function () {
      if (document.body) {
        observer.disconnect();
        inject();
      }
    });
    observer.observe(document.documentElement, { childList: true });
  }

  // 5) Dismiss: wait for window.load (all resources) AND min duration
  var startTime = Date.now();
  var loaded = false;
  var timerDone = false;
  var dismissed = false;

  function dismiss() {
    if (dismissed || !loaded || !timerDone) return;
    dismissed = true;
    // Remove the blocking style — reveal page content
    var bs = document.getElementById('wp-splash-block');
    if (bs) bs.parentNode.removeChild(bs);
    // Fade out splash
    overlay.classList.add('hide');
    setTimeout(function () {
      if (overlay.parentNode) overlay.parentNode.removeChild(overlay);
    }, 350);
  }

  window.addEventListener('load', function () {
    loaded = true;
    // If min duration already passed, dismiss immediately
    var elapsed = Date.now() - startTime;
    if (elapsed >= MIN_DURATION) {
      timerDone = true;
    }
    dismiss();
  });

  setTimeout(function () {
    timerDone = true;
    dismiss();
  }, MIN_DURATION);

  // Safety fallback: 8s max
  setTimeout(function () {
    loaded = true;
    timerDone = true;
    dismiss();
  }, 8000);
})();
