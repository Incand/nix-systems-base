{
  flake.modules.homeManager.neovim-theme = { pkgs, ... }: {
    programs.neovim.plugins = with pkgs.vimPlugins; [
      {
        plugin = onedark-nvim;
        type = "lua";
        config = ''
          require('onedark').setup({ style = 'dark' })
          require('onedark').load()
        '';
      }
    ];
  };
}
