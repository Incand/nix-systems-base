{
  flake.modules.homeManager.vscodium = { pkgs, ... }:
  {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
      mutableExtensionsDir = false;
      profiles.default.extensions = with pkgs.vscode-extensions; [
        # Extensions to install go here.
        # Use separate file if additional config for specific ext. required
        #dracula-theme.theme-dracula
      ];
    };
  };
}
