// Enables the userChrome.css and userContent.css files.
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
user_pref("svg.context-properties.content.enabled", true);
user_pref("layout.css.color-mix.enabled", true);
user_pref("layout.css.light-dark.enabled", true);
user_pref("widget.transparent-windows", true);

// Disables preferences that interfere with the theme
user_pref("browser.urlbar.groupLabels.enabled", false);
user_pref("browser.newtabpage.activity-stream.newtabLayouts.variant-a", false);
user_pref("browser.newtabpage.activity-stream.newtabLayouts.variant-b", false);
user_pref("browser.startup.blankWindow", false);

// @egirlcatnip
user_pref("browser.aboutConfig.showWarning", false);
user_pref("widget.windows.mica", true);
user_pref("browser.tabs.allow_transparent_browser", true);
user_pref("uc.winui.tab-close-button", 2);

user_pref("full-screen-api.transition-duration.enter", "0 0");
user_pref("full-screen-api.transition-duration.leave", "0 0");
user_pref("full-screen-api.warning.timeout", 0);

user_pref("ui.key.menuAccessKeyFocuses", false);

