{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
let
  unstable = import inputs.nixpkgs-unstable { system = pkgs.stdenv.system; };
in
{
  packages = with unstable; [
    git
    lua-language-server
    stylua
    aider-chat
  ];
  languages.lua.enable = true;

}
