{ ... }:
{
  flake.modules.homeManager.neovim-cucumber = { pkgs, lib, ... }:
  let
    treeSitterSrc = pkgs.fetchFromGitHub {
      owner = "berendkleinhaneveld";
      repo = "tree-sitter-gherkin";
      rev = "ee221e3c49a1e42ac056f2575618776001152b77";
      hash = "sha256-0CEx0lj0bNz8uIGRXVtf5Jwo6CQGYqLtirBeV401x1w=";
    };

    gherkinGrammar = pkgs.tree-sitter.buildGrammar {
      language = "gherkin";
      version = "0.1.0+rev=ee221e3";
      src = treeSitterSrc;
    };

    gherkinQueries = pkgs.vimUtils.buildVimPlugin {
      name = "tree-sitter-gherkin-queries";
      src = treeSitterSrc;
    };

    cucumberLanguageServer = pkgs.buildNpmPackage {
      pname = "cucumber-language-server";
      version = "1.7.0";
      src = pkgs.fetchFromGitHub {
        owner = "cucumber";
        repo = "language-server";
        rev = "c68c2033d91e72b0b15965e2f1f417e9f9b5917a";
        hash = "sha256-GGPajuy1pOidi7Ux+i7CfLjsRT7vsLQRj1IzTXBWPQY=";
      };
      npmDepsHash = "sha256-sjoj7OLZcvFf0g/6kjhWgt/bUNKbbvYqBszNDYHxf4A=";
      npmFlags = [ "--ignore-scripts" ];
    };
  in
  {
    programs.neovim = {
      extraPackages = [ cucumberLanguageServer pkgs.tree-sitter ];

      plugins = with pkgs.vimPlugins; [
        gherkinQueries
        (nvim-treesitter.withPlugins (_: [ gherkinGrammar ]))
      ];

      extraLuaConfig = ''
        vim.lsp.config('cucumber_language_server', {
          cmd = { 'cucumber-language-server', '--stdio' },
          filetypes = { 'cucumber', 'gherkin' },
          root_markers = { 'package.json', 'cucumber.json', 'cucumber.yaml', '.git' },
        })
        vim.lsp.enable('cucumber_language_server')
      '';
    };
  };
}
