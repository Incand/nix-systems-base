{
  # Adds firefox with sensible default configurations and extensions

  flake.modules.homeManager.firefox =
  {
    programs.firefox = {
      enable = true;
      languagePacks = [ "de" "en-US" ];

      /* ---- POLICIES ---- */
      # Check about:policies#documentation for options.
      policies = {
        DisableTelemetry = true;
        DisableFirefoxStudies = true;
        EnableTrackingProtection = {
          Value= true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
        DisablePocket = true;
        DisableFirefoxAccounts = true;
        DisableAccounts = true;
        DisableFirefoxScreenshots = true;
        OverrideFirstRunPage = "";
        OverridePostUpdatePage = "";
        #DontCheckDefaultBrowser = true;
        UserMessaging = {
          ExtensionRecommendations = false;
          SkipOnboarding = true;
        };
        PasswordManagerEnabled = false;

        /* ---- EXTENSIONS ---- */
        # Check about:support for extension/add-on ID strings.
        # Valid strings for installation_mode are "allowed", "blocked",
        # "force_installed" and "normal_installed".
        ExtensionSettings = {
          "*".installation_mode = "allowed"; # blocks all addons except the ones specified below
          # uBlock Origin:
          "uBlock0@raymondhill.net" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            installation_mode = "force_installed";
            default_area = "menubar";
          };
          # Bitwarden
          "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
            installation_mode = "force_installed";
            default_area = "navbar";
          };
        };

        /* ---- PREFERENCES ---- */
        # Check about:config for options.
        Preferences = 
        let
          lock-false = {
            Value = false;
            Status = "locked";
          };
          lock-true = {
            Value = true;
            Status = "locked";
          };
        in
        { 
          "browser.contentblocking.category" = { Value = "strict"; Status = "locked"; };
          "extensions.pocket.enabled" = lock-false;
          "extensions.screenshots.disabled" = lock-true;
          "browser.topsites.contile.enabled" = lock-false;
          "browser.formfill.enable" = lock-false;
          "browser.urlbar.showSearchSuggestionsFirst" = lock-false;
          # fewer search suggestions
          "browser.urlbar.suggest.addons" = false;
          "browser.urlbar.suggest.calculator" = false;
          "browser.urlbar.suggest.clipboard" = false;
          "browser.urlbar.suggest.engines" = false;
          "browser.urlbar.suggest.fakespot" = false;
          "browser.urlbar.suggest.mdn" = false;
          "browser.urlbar.suggest.pocket" = false;
          "browser.urlbar.suggest.quickactions" = false;
          "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
          "browser.urlbar.suggest.quicksuggest.sponsored" = false;
          "browser.urlbar.suggest.searches" = false;
          "browser.urlbar.suggest.trending" = false;
          "browser.urlbar.suggest.weather" = false;
          "browser.urlbar.suggest.yelp" = false;

          "browser.newtabpage.activity-stream.feeds.section.topstories" = lock-false;
          "browser.newtabpage.activity-stream.feeds.snippets" = lock-false;
          "browser.newtabpage.activity-stream.section.highlights.includePocket" = lock-false;
          "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = lock-false;
          "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = lock-false;
          "browser.newtabpage.activity-stream.section.highlights.includeVisited" = lock-false;
          "browser.newtabpage.activity-stream.showSponsored" = lock-false;
          "browser.newtabpage.activity-stream.system.showSponsored" = lock-false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = lock-false;

          "browser.fullscreen.autohide" = false; # still show bar when going fullscreen
          "intl.accept_languages" = "en-US, en, de";
          "browser.aboutConfig.showWarning" = false;
          "extensions.activeThemeID" = "default-theme@mozilla.org"; # use gtk theme
          "browser.urlbar.resultMenu.keyboardAccessible" = false; # not 3 dots when tabbing through suggestions
          "xpinstall.whitelist.required" = false;
          "xpinstall.signatures.required" = false;
          #"browser.download.dir" = config.xdg.userDirs.download; # else it'd be $BROWSERHOME/Downloads
          "browser.translation.automaticallyPopup" = false;
          "browser.toolbars.bookmarks.visibility" = "never";
          "browser.tabs.delayHidingAudioPlayingIconMS" = 0; # no delay for "playing" in tabbar (eg. youtube)
          "full-screen-api.warning.timeout" = 0; # no fullscreen warning
          "full-screen-api.transition.timeout" = 0; # go into fullscreen faster (maybe?)
          "extensions.pictureinpicture.enable_picture_in_picture_overrides" = true;
          "media.videocontrols.picture-in-picture.respect-disablePictureInPicture" = true;

          "signon.rememberSignons" = false;
          "widget.use-xdg-desktop-portal.file-picker" = 0;
          "browser.compactmode.show" = true;
        };
      };
    };

  };
}
