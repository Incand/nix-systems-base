{
  flake.modules.homeManager.neovim-qol = { pkgs, ... }: {
    programs.neovim.plugins = with pkgs.vimPlugins; [
      {
        plugin = nvim-autopairs;
        type = "lua";
        config = ''
          require('nvim-autopairs').setup({})
        '';
      }
      {
        plugin = comment-nvim;
        type = "lua";
        config = ''
          require('Comment').setup({})
        '';
      }
      {
        plugin = indent-blankline-nvim;
        type = "lua";
        config = ''
          require('ibl').setup({})
        '';
      }
      {
        plugin = nvim-surround;
        type = "lua";
        config = ''
          require('nvim-surround').setup({})
        '';
      }
      {
        plugin = persistence-nvim;
        type = "lua";
        config = ''
          if vim.fn.argc() == 0 then
            vim.g.restoring_session = true
          end

          require('persistence').setup({
            pre_save = function() vim.cmd('NERDTreeClose') end,
          })

          vim.api.nvim_create_autocmd('VimEnter', {
            callback = function()
              if vim.fn.argc() == 0 then
                require('persistence').load()
                vim.schedule(function()
                  vim.cmd('NERDTree | wincmd p')
                  vim.g.restoring_session = false
                end)
              end
            end,
            nested = true,
          })
        '';
      }
    ];
  };
}
