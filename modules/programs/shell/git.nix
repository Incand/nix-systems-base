{
  flake.modules.homeManager.git = {
    programs.git = {
      enable = true;
      ignores = [ "shell.nix" ".DS_Store" ];
      settings = { init.defaultBranch = "main"; };
    };
  };
}
