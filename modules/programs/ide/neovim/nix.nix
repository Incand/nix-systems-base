{
  flake.modules.homeManager.neovim-nix = { pkgs, ... }: {
    programs.neovim = {
      extraConfig = ''
        autocmd FileType nix setlocal tabstop=2 softtabstop=2 shiftwidth=2
      '';

      extraPackages = with pkgs; [
        nil
        nixfmt
      ];

      plugins = with pkgs.vimPlugins; [
        {
          plugin = blink-cmp;
          type = "lua";
          config = ''
            require('blink.cmp').setup({
              keymap = {
                preset = 'default',
                ['<Tab>'] = { 'accept', 'fallback' },
              },
              completion = {
                list = {
                  selection = { preselect = true },
                },
              },
            })
          '';
        }
        {
          plugin = nvim-lspconfig;
          type = "lua";
          config = ''
            require('lspconfig').nil_ls.setup({
              capabilities = require('blink.cmp').get_lsp_capabilities(),
            })
          '';
        }
        {
          plugin = conform-nvim;
          type = "lua";
          config = ''
            require('conform').setup({
              formatters_by_ft = {
                nix = { 'nixfmt' },
              },
              format_on_save = {
                timeout_ms = 500,
              },
            })
          '';
        }
        (nvim-treesitter.withPlugins (p: [ p.nix ]))
      ];
    };
  };
}
