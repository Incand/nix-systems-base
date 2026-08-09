{
  flake.modules.homeManager.neovim-terminal = { pkgs, ... }: {
    programs.neovim.plugins = with pkgs.vimPlugins; [
      {
        plugin = toggleterm-nvim;
        type = "lua";
        config = ''
          require('toggleterm').setup({
            size = 15,
            open_mapping = [[<c-\>]],
            direction = 'horizontal',
          })
          vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], {})
        '';
      }
    ];
  };
}
