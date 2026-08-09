{ inputs, ... }: {
  flake.modules.homeManager.neovim = { pkgs, ... }:
  {
    imports = with inputs.self.modules.homeManager; [
      neovim-nerdtree
      neovim-git
      neovim-terminal
      neovim-statusline
      neovim-telescope

      neovim-nix
    ];

    programs.neovim = {
      enable = true;
      extraConfig = import ../../_vim-config.nix;
    };
  };
}
