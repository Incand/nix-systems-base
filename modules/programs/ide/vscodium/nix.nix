{
  flake.modules.homeManager.vscodium-nix =
    { pkgs, ... }:
    {
      programs.vscode = {
        profiles.default = {
          extensions = with pkgs.vscode-extensions; [
            jnoortheen.nix-ide
          ];

          userSettings = {
            "nix.enableLanguageServer" = true;
            "nix.serverPath" = "nil";
            "nix.serverSettings.nil.formatting.command" = [ "nixfmt" ];
          };
        };
      };

      home.packages = with pkgs; [
        nil
        nixfmt
      ];
    };
}