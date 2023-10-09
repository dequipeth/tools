// ------------------- User preferences ------------------- //


// ------ General ------ //

// Disable addon suggestions
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons", false);
// Disable feature suggestions
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features", false);
// Enable DRM-controlled content
user_pref("media.eme.enabled", true);


// ------ Theme ------ //

user_pref("layout.css.prefers-color-scheme.content-override", 0);
user_pref("browser.in-content.dark-mode", true);
user_pref("ui.systemUsesDarkTheme ", 1);


// ------ Home page ------ //

// Home page
user_pref("browser.startup.homepage", "about:home");

// Top sites
user_pref("browser.newtabpage.activity-stream.feeds.topsites", false);
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);
user_pref("browser.newtabpage.pinned", "[]");
user_pref("browser.topsites.blockedSponsors", "[\"amazon\",\"fr.hotels\"]");

// Recent activity
user_pref("browser.newtabpage.activity-stream.feeds.section.highlights", false);
user_pref("browser.newtabpage.activity-stream.section.highlights.includeBookmarks", false);
user_pref("browser.newtabpage.activity-stream.section.highlights.includeDownloads", false);
user_pref("browser.newtabpage.activity-stream.section.highlights.includePocket", false);
user_pref("browser.newtabpage.activity-stream.section.highlights.includeVisited", false);

// Snippets
user_pref("browser.newtabpage.activity-stream.feeds.snippets", false);


// ------ Tabs ------ //

user_pref("browser.tabs.warnOnClose", false);
user_pref("browser.tabs.closeWindowWithLastTab", false);


// ------ Tool bar ------ //

user_pref("browser.uiCustomization.state", "{\"placements\":{\"widget-overflow-fixed-list\":[],\"unified-extensions-area\":[],\"nav-bar\":[\"back-button\",\"forward-button\",\"stop-reload-button\",\"home-button\",\"customizableui-special-spring1\",\"urlbar-container\",\"customizableui-special-spring2\",\"bookmarks-menu-button\",\"downloads-button\",\"unified-extensions-button\"],\"toolbar-menubar\":[\"menubar-items\"],\"TabsToolbar\":[\"firefox-view-button\",\"tabbrowser-tabs\",\"new-tab-button\",\"alltabs-button\"],\"PersonalToolbar\":[\"personal-bookmarks\"]},\"seen\":[\"save-to-pocket-button\",\"developer-button\"],\"dirtyAreaCache\":[\"nav-bar\",\"toolbar-menubar\",\"TabsToolbar\",\"PersonalToolbar\"],\"currentVersion\":19,\"newElementCount\":3}");


// ------ Bookmarks ------ //

user_pref("browser.toolbars.bookmarks.visibility", "always");


// ------ Search ------ //

user_pref("browser.urlbar.placeholderName", "DuckDuckGo");
user_pref("browser.urlbar.placeholderName.private", "DuckDuckGo");
user_pref("browser.urlbar.suggest.history", true);
user_pref("browser.urlbar.suggest.topsites", false);
user_pref("browser.urlbar.showSearchSuggestionsFirst", false);


// ------ Privacy and Security ------ //

// Tracking protection
user_pref("browser.contentblocking.category", "custom");
user_pref("privacy.trackingprotection.enabled", true);
user_pref("privacy.trackingprotection.socialtracking.enabled", true);
user_pref("privacy.trackingprotection.emailtracking.enabled", true);
user_pref("privacy.donottrackheader.enabled", true);

// History
user_pref("privacy.history.custom", true);
user_pref("privacy.clearOnShutdown.history", true);
user_pref("privacy.clearOnShutdown.downloads", true);
user_pref("privacy.clearOnShutdown.formdata", true);
user_pref("privacy.clearOnShutdown.offlineApps", true);
user_pref("privacy.clearOnShutdown.sessions", false);

// Cookies
user_pref("privacy.sanitize.sanitizeOnShutdown", true);
user_pref("privacy.sanitize.pending", "[{\"id\":\"shutdown\",\"itemsToClear\":[\"cache\",\"cookies\",\"offlineApps\"],\"options\":{}}]");

// Logins and passwords
user_pref("signon.rememberSignons", false);
user_pref("signon.autofillForms", false);
user_pref("signon.firefoxRelay.feature", "disabled");
user_pref("signon.generation.enabled", false);

// Credit cards
user_pref("extensions.formautofill.creditCards.enabled", false);

// Telemetry
user_pref("browser.discovery.enabled", false);
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("app.shield.optoutstudies.enabled", false);


// ------ Scroll ------ //

user_pref("mousewheel.system_scroll_override.enabled", false);
user_pref("apz.gtk.kinetic_scroll.enabled", false);
user_pref("browser.backspace_action", 0); // original value is 2
user_pref("mousewheel.default.delta_multiplier_x", 30); // original value is 100
user_pref("mousewheel.default.delta_multiplier_y", 30); // original value is 100
user_pref("mousewheel.min_line_scroll_amount", 180); // original value is 5
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);


// ------ Custom CSS ------ //

user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

