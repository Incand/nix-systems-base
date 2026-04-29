{ inputs, ... }:
let
  genericPkgs =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        htop
        vim
        git
      ];
    };
in
{
  flake.modules.darwin.system-cli = {
    imports = with inputs.self.modules.darwin; [
      genericPkgs

      home-manager
      homebrew
    ];
  };

  flake.modules.nixos.system-cli = {
    imports = with inputs.self.modules.nixos; [
      genericPkgs

      home-manager
    ];
  };
}
