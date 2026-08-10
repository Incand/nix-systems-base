{
  flake.modules.homeManager.neovim-lsp = { pkgs, ... }: {
    programs.neovim.extraLuaConfig = ''
      vim.api.nvim_create_autocmd('VimEnter', {
        callback = function()
          local nvim_lua = vim.fn.getcwd() .. '/.nvim.lua'
          if vim.fn.filereadable(nvim_lua) == 1 then
            vim.cmd('luafile ' .. vim.fn.fnameescape(nvim_lua))
          end
        end,
      })

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(ev)
          local opts = { buffer = ev.buf }
          vim.keymap.set('n', 'gd',         vim.lsp.buf.definition,     opts)
          vim.keymap.set('n', 'gr',         vim.lsp.buf.references,     opts)
          vim.keymap.set('n', 'gi',         vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', 'K',          vim.lsp.buf.hover,          opts)
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename,         opts)
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action,    opts)
          vim.keymap.set('n', '[d',         vim.diagnostic.goto_prev,   opts)
          vim.keymap.set('n', ']d',         vim.diagnostic.goto_next,   opts)
        end,
      })
    '';
  };
}
