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
            vim.lsp.config('nil_ls', {
              cmd = { 'nil' },
              filetypes = { 'nix' },
              root_markers = { 'flake.nix', '.git' },
              capabilities = require('blink.cmp').get_lsp_capabilities(),
            })
            vim.lsp.enable('nil_ls')
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
