{ inputs, ... }:
{
  flake.packages.x86_64-linux.neovim =
    let
      homeConfig = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
        modules = [
          inputs.self.modules.homeManager.neovim
          {
            home.username = "armin";
            home.homeDirectory = "/home/armin";
            home.stateVersion = "25.11";
          }
        ];
      };
    in
    homeConfig.config.programs.neovim.finalPackage;
}
