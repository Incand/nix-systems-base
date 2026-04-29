{
  inputs,
  lib,
  ...
}:
{
  # Helper functions for creating system / home-manager configurations

  options.flake.lib = lib.mkOption {
    type = lib.types.attrsOf lib.types.unspecified;
    default = { };
  };

  config.flake.lib =
    let
      mkSystemFn =
        systemFn:
        lib.mapAttrs (
          systemName: module:
          systemFn {
            modules = [
              module
              { networking.hostName = systemName; }
            ];
          }
        );
    in
    {
      mkNixos = mkSystemFn inputs.nixpkgs.lib.nixosSystem;
      mkDarwin = mkSystemFn inputs.nix-darwin.lib.darwinSystem;
    };
}
