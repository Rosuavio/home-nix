{pkgs, ...}:
{
  programs.vscode = {
    enable = true;

    userSettings = {
      "update.channel" = "none";

      "editor.renderWhitespace" = "all";
      "[nix]"."editor.tabSize" = 2;
      "nix.enableLanguageServer" = true;

      "diffEditor.ignoreTrimWhitespace" = false;

      "cSpell.enabledLanguageIds" = [
        "asciidoc"
        "c"
        "cpp"
        "csharp"
        "css"
        "git-commit"
        "go"
        "graphql"
        "handlebars"
        "haskell"
        "html"
        "jade"
        "java"
        "javascript"
        "javascriptreact"
        "json"
        "jsonc"
        "latex"
        "less"
        "markdown"
        "php"
        "plaintext"
        "python"
        "pug"
        "restructuredtext"
        "rust"
        "scala"
        "scss"
        "text"
        "typescript"
        "typescriptreact"
        "yaml"
        "yml"
        "sql"
        "nix"
      ];
    };
    package = pkgs.vscodium;

    haskell = {
      enable = true;
      hie.enable = false;
      # TODO: Enable hie integration
    };

    extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
      streetsidesoftware.code-spell-checker
      jock.svg
    ];
  };
}
