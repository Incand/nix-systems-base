{
  flake.modules.homeManager.neovim-panels = { pkgs, ... }: {
    programs.neovim = {
      plugins = with pkgs.vimPlugins; [
        nerdtree
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
        {
          plugin = trouble-nvim;
          type = "lua";
          config = ''
            require('trouble').setup({})
            vim.keymap.set('n', '<leader>d', '<cmd>Trouble diagnostics toggle<cr>', {})
          '';
        }
        {
          plugin = aerial-nvim;
          type = "lua";
          config = ''
            require('aerial').setup({})
            vim.keymap.set('n', '<leader>o', '<cmd>AerialToggle<cr>', {})
          '';
        }
      ];

      extraConfig = ''
        " Open NERDTree on startup, then move focus back to the main buffer
        autocmd VimEnter * NERDTree | wincmd p
        " Quit nvim when NERDTree is the last remaining window
        autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
      '';
    };
  };
}
