{ inputs, ... }:
{
  neovim.conform.formatters.kotlin = [ "ktlint" ];
  neovim.conform.timeouts.kotlin = 10000;

  flake.modules.homeManager.neovim-kotlin =
    { pkgs, lib, bundleJvmToolchain ? true, ... }:
    let
      klsJars = pkgs.kotlin-language-server.overrideAttrs (_: {
        buildInputs = [];
        postInstall = "";
        postFixup = "";
      });

      klsSystemJdk = pkgs.writeShellScriptBin "kotlin-language-server" ''
        JAVA=''${JAVA_HOME:+''${JAVA_HOME}/bin/java}
        JAVA=''${JAVA:-java}
        export PATH="$(dirname "$JAVA"):$PATH"
        exec ${klsJars}/bin/kotlin-language-server "$@"
      '';

      ktlintJars = pkgs.ktlint.overrideAttrs (_: {
        buildInputs = [];
        postInstall = "";
        postFixup = "";
      });

      ktlintSystemJdk = pkgs.writeShellScriptBin "ktlint" ''
        JAVA=''${JAVA_HOME:+''${JAVA_HOME}/bin/java}
        JAVA=''${JAVA:-java}
        export PATH="$(dirname "$JAVA"):$PATH"
        exec ${ktlintJars}/bin/ktlint "$@"
      '';
    in
    {
      imports = [ inputs.self.modules.homeManager.neovim-java ];

      programs.neovim = {
        extraPackages = with pkgs;
          if bundleJvmToolchain then [
            kotlin-language-server
            ktlint
          ] else [
            klsSystemJdk
            ktlintSystemJdk
          ];

        extraConfig = ''
          autocmd FileType kotlin setlocal tabstop=4 softtabstop=4 shiftwidth=4
        '';

        plugins = with pkgs.vimPlugins; [
          (nvim-treesitter.withPlugins (p: [ p.kotlin ]))
        ];

        extraLuaConfig = ''
          vim.lsp.config('kotlin_language_server', {
            cmd = { 'kotlin-language-server' },
            filetypes = { 'kotlin' },
            root_markers = { 'build.gradle', 'build.gradle.kts', 'settings.gradle.kts', '.git' },
          })
          vim.lsp.enable('kotlin_language_server')
        '';
      };
    };
}
