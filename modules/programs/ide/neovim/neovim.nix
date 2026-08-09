{ inputs, ... }: {
  flake.modules.homeManager.neovim = { pkgs, ... }:
  {
    imports = with inputs.self.modules.homeManager; [
      neovim-panels
      neovim-git
      neovim-statusline
      neovim-telescope
      neovim-qol
      neovim-lsp

      neovim-nix
      neovim-java
    ];

    programs.neovim = {
      enable = true;
      extraConfig = import ../../_vim-config.nix;
    };
  };
}
