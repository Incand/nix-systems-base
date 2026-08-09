{ inputs, ... }:
{
  flake.homeConfigurations.neovim-test = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = inputs.nixpkgs-darwin.legacyPackages.aarch64-darwin;
    modules = with inputs.self.modules.homeManager; [
      neovim
      {
        home.username = "neovim-tester";
        home.homeDirectory = "/Users/neovim-tester";
        home.stateVersion = "25.11";
      }
    ];
  };
}
