{ inputs, lib, ... }: {
  flake.modules.homeManager.neovim = { pkgs, ... }:
  {
    imports = with inputs.self.modules.homeManager; [
      { key = "neovim-jvm-defaults"; config._module.args.bundleJvmToolchain = lib.mkDefault true; }
      neovim-theme
      neovim-panels
      neovim-git
      neovim-statusline
      neovim-telescope
      neovim-qol
      neovim-lsp
      neovim-conform

      neovim-nix
      neovim-java
      neovim-kotlin
      neovim-cucumber
    ];

    programs.neovim = {
      enable = true;
      extraConfig = import ../../_vim-config.nix;
    };
  };
}
