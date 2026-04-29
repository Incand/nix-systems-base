{
  flake.modules.homeManager.git = {
    programs.git = {
      enable = true;
      ignores = ["shell.nix"];
      settings = { init.defaultBranch = "main"; };
    };
  };
}
