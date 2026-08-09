{ inputs, ... }:
{
  flake.packages.x86_64-linux.neovim =
    let
      pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
      homeConfig = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          inputs.self.modules.homeManager.neovim
          {
            home.username = "armin";
            home.homeDirectory = "/home/armin";
            home.stateVersion = "25.11";
            _module.args.bundleJvmToolchain = false;
          }
        ];
      };
      neovimPkg = homeConfig.config.programs.neovim.finalPackage;
      configFiles = homeConfig.config.xdg.configFile;
      initFile =
        if configFiles ? "nvim/init.lua" then configFiles."nvim/init.lua".source
        else configFiles."nvim/init.vim".source;
    in
    pkgs.writeShellScriptBin "nvim" ''
      exec ${neovimPkg}/bin/nvim -u ${initFile} "$@"
    '';
}
