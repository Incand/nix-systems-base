{ lib, config, ... }:
let
  nerdFont = config.neovim.nerdFont;
in
{
  options.neovim.nerdFont = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Whether a Nerd Font is available in the terminal.";
  };

  config.flake.modules.homeManager.neovim-nix = { pkgs, ... }: {
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
              ${lib.optionalString (!nerdFont) ''
              appearance = {
                kind_icons = {
                  Text          = 'Txt', Method       = 'Mth', Function     = 'Fn',
                  Constructor   = 'New', Field        = 'Fld', Variable     = 'Var',
                  Class         = 'Cls', Interface    = 'Int', Module       = 'Mod',
                  Property      = 'Prp', Unit         = 'Unt', Value        = 'Val',
                  Enum          = 'Enm', Keyword      = 'Kwd', Snippet      = 'Snp',
                  Color         = 'Clr', File         = 'Fil', Reference    = 'Ref',
                  Folder        = 'Dir', EnumMember   = 'EnM', Constant     = 'Con',
                  Struct        = 'Str', Event        = 'Evt', Operator     = 'Op',
                  TypeParameter = 'T',
                },
              },
              ''}
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
