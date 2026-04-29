{
  flake.modules.homeManager.zsh = { config, ... }:
  {
    programs.zsh = {
      enable = true;
      dotDir = "${config.xdg.configHome}/zsh";
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "docker" "docker-compose" ];
        theme = "simple";
      };

      initContent = ''
        bindkey '^f' autosuggest-accept
      '';
    };
  };
}