{
  flake.modules.homeManager.vim = { ... }: {
    programs.vim = {
      enable = true;
      extraConfig = import ../_vim-config.nix;
    };
  };
}
