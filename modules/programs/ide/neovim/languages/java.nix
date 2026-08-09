{
  flake.modules.homeManager.neovim-java = { pkgs, ... }: {
    programs.neovim = {
      extraPackages = with pkgs; [
        jdt-language-server
        google-java-format
        gradle
        maven
        jdk
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
