{ ... }:
{
  flake.modules.homeManager.neovim-java =
    { pkgs, lib, bundleJvmToolchain ? true, ... }:
    let
      jdtlsJars = pkgs.jdt-language-server.overrideAttrs (_: {
        buildInputs = [];
        postPatch = "";
        postInstall = "";
        postFixup = "";
      });

      jdtlsSystemJdk = pkgs.writeShellScriptBin "jdtls" ''
        JAVA=''${JAVA_HOME:+''${JAVA_HOME}/bin/java}
        JAVA=''${JAVA:-java}
        launcher=$(ls ${jdtlsJars}/share/java/jdtls/plugins/org.eclipse.equinox.launcher_*.jar | head -1)
        exec "$JAVA" \
          -Declipse.application=org.eclipse.jdt.ls.core.id1 \
          -Dosgi.bundles.defaultStartLevel=4 \
          -Declipse.product=org.eclipse.jdt.ls.core.product \
          -Dlog.level=ALL \
          -noverify \
          -Xmx1G \
          --add-modules=ALL-SYSTEM \
          --add-opens java.base/java.util=ALL-UNNAMED \
          --add-opens java.base/java.lang=ALL-UNNAMED \
          -jar "$launcher" \
          -configuration ${jdtlsJars}/share/java/jdtls/config_linux \
          "$@"
      '';
    in
    {
      config.programs.neovim = {
        extraPackages =
          with pkgs;
          if bundleJvmToolchain then [
            jdt-language-server
            google-java-format
            gradle
            maven
            jdk
          ] else [
            jdtlsSystemJdk
          ];

        extraConfig = ''
          autocmd FileType java setlocal tabstop=4 softtabstop=4 shiftwidth=4
        '';

        plugins = with pkgs.vimPlugins; [
          (nvim-treesitter.withPlugins (p: [ p.java ]))
          {
            plugin = nvim-jdtls;
            type = "lua";
            config = ''
              vim.api.nvim_create_autocmd('FileType', {
                pattern = 'java',
                callback = function()
                  require('jdtls').start_or_attach({
                    cmd = { 'jdtls' },
                    root_dir = vim.fs.dirname(
                      vim.fs.find({ 'gradlew', 'pom.xml', '.git' }, { upward = true })[1]
                    ),
                  })
                end,
              })
              require('conform').setup({
                formatters_by_ft = {
                  java = { 'google-java-format' },
                },
              })
            '';
          }
        ];
      };
    };
}
