{
  flake.modules.homeManager.vscodium = { pkgs, ... }:
  {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
      mutableExtensionsDir = false;
      profiles.default.extensions = with pkgs.vscode-extensions; [
        #dracula-theme.theme-dracula
        #vscodevim.vim
        #yzhang.markdown-all-in-one
      ];
    };
  };
}
