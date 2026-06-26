{ ... }:
{
  flake.modules.homeManager.vscodium-python =
    { pkgs, ... }:
    {
      programs.vscode = {
        profiles.default = {
          extensions = with pkgs.vscode-extensions; [
            ms-python.python
            ms-python.debugpy
            ms-pyright.pyright
            charliermarsh.ruff
          ];

          userSettings = {
            "files.exclude" = {
              "**/__pycache__" = true;
            };
            "[python]" = {
              "editor.formatOnSave" = true;
              "editor.defaultFormatter" = "charliermarsh.ruff";
              "editor.codeActionsOnSave" = {
                "source.organizeImports" = "explicit";
              };
            };
          };
        };
      };
    };
}