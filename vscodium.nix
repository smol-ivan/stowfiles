{ pkgs, ... }:

{
  programs.vscodium = {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      quarto.quarto
      vscodevim.vim
      jdinhlife.gruvbox
      mkhl.direnv
    ];
  };
}
