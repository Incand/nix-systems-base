{
  flake.modules.homeManager.neovim-git = { pkgs, ... }: {
    programs.neovim.plugins = with pkgs.vimPlugins; [
      {
        plugin = gitsigns-nvim;
        type = "lua";
        config = ''
          vim.g.mapleader = " "
          local gs = require('gitsigns')
          gs.setup({ current_line_blame = false })
          vim.keymap.set('n', '<leader>b', function() gs.blame_line() end, {})
        '';
      }
    ];
  };
}
