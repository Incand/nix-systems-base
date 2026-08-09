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
    ];
  };
}
