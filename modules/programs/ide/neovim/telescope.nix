{
  flake.modules.homeManager.neovim-telescope = { pkgs, ... }: {
    programs.neovim = {
      extraPackages = [ pkgs.ripgrep ];

      plugins = with pkgs.vimPlugins; [
        {
          plugin = telescope-nvim;
          type = "lua";
          config = ''
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
            vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
            vim.keymap.set('n', '<C-f>', builtin.live_grep, {})
            vim.keymap.set('n', '<C-p>', builtin.find_files, {})
          '';
        }
      ];
    };
  };
}
