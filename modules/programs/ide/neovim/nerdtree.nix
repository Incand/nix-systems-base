{
  flake.modules.homeManager.neovim-nerdtree = { pkgs, ... }: {
    programs.neovim = {
      plugins = with pkgs.vimPlugins; [
        nerdtree
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
