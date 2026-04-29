{
  flake.modules.homeManager.vim = { ... }: {
    programs.vim = {
      enable = true;
      extraConfig = ''
        set nocompatible
        filetype off
        syntax on
        set nu
        set nowrap
        set encoding=utf-8
        set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
      '';
    };
  };
}
