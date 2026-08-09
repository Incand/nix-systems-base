{
  flake.modules.homeManager.neovim-statusline = { pkgs, ... }: {
    programs.neovim.plugins = with pkgs.vimPlugins; [
      {
        plugin = lualine-nvim;
        type = "lua";
        config = ''
          require('lualine').setup({
            options = {
              theme = 'auto',
              icons_enabled = false,
              section_separators = ${"''"},
              component_separators = '|',
            },
          })
        '';
      }
    ];
  };
}
