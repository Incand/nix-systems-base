{ inputs, ... }:
{
  flake.modules.homeManager.neovim-kotlin = { pkgs, ... }: {
    imports = [ inputs.self.modules.homeManager.neovim-java ];

    programs.neovim = {
      extraPackages = with pkgs; [
        kotlin-language-server
        ktlint
      ];

      extraConfig = ''
        autocmd FileType kotlin setlocal tabstop=4 softtabstop=4 shiftwidth=4
      '';

      plugins = with pkgs.vimPlugins; [
        (nvim-treesitter.withPlugins (p: [ p.kotlin ]))
      ];

      extraLuaConfig = ''
        vim.lsp.config('kotlin_language_server', {
          cmd = { 'kotlin-language-server' },
          filetypes = { 'kotlin' },
          root_markers = { 'build.gradle', 'build.gradle.kts', 'settings.gradle.kts', '.git' },
        })
        vim.lsp.enable('kotlin_language_server')
        require('conform').setup({
          formatters_by_ft = {
            kotlin = { 'ktlint' },
          },
        })
      '';
    };
  };
}
