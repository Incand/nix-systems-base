{
  inputs,
  ...
}:
{
  # default settings needed for all darwinConfigurations

  flake.modules.darwin.system-desktop =
    {
      pkgs,
      ...
    }:
    {
      imports = with inputs.self.modules.darwin; [
        system-cli
      ];

      nix.enable = false;
      nixpkgs.config.allowUnfree = true;

      system.stateVersion = 6;

      # Custom settings written to /etc/nix/nix.custom.conf

      environment.systemPackages = with inputs.nix-darwin.packages.${pkgs.stdenv.hostPlatform.system}; [
        darwin-option
        darwin-rebuild
        darwin-version
        darwin-uninstaller
      ];
    };

  flake.modules.nixos.system-desktop =
    {
      pkgs,
      ...
    }:
    {
      imports = with inputs.self.modules.nixos; [
        system-cli
      ];
    };
}
