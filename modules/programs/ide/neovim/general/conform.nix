{ lib, config, ... }:
let
  cfg = config.neovim.conform;
  formattersLua = lib.concatStringsSep "\n" (
    lib.mapAttrsToList (ft: fmts:
      "        ${ft} = { ${lib.concatMapStringsSep ", " (f: "'${f}'") fmts} },"
    ) cfg.formatters
  );
  timeoutsLua = lib.concatStringsSep ", " (
    lib.mapAttrsToList (ft: ms: "${ft} = ${toString ms}")
    cfg.timeouts
  );
in
{
  options.neovim.conform = {
    formatters = lib.mkOption {
      type = lib.types.attrsOf (lib.types.listOf lib.types.str);
      default = {};
    };
    timeouts = lib.mkOption {
      type = lib.types.attrsOf lib.types.int;
      default = {};
    };
    defaultTimeout = lib.mkOption {
      type = lib.types.int;
      default = 500;
    };
  };

  config.flake.modules.homeManager.neovim-conform = { pkgs, ... }: {
    programs.neovim.plugins = with pkgs.vimPlugins; [
      {
        plugin = conform-nvim;
        type = "lua";
        config = ''
          require('conform').setup({
            formatters_by_ft = {
        ${formattersLua}
            },
            format_after_save = function(bufnr)
              local timeouts = { ${timeoutsLua} }
              local ft = vim.bo[bufnr].filetype
              return { timeout_ms = timeouts[ft] or ${toString cfg.defaultTimeout} }
            end,
          })
        '';
      }
    ];
  };
}
