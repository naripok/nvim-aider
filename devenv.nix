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

  env.LUA_PATH = "$LUA_PATH;?.lua";
  packages = with unstable; [
    git
    lua-language-server
    stylua
    aider-chat
  ];
  languages.lua.enable = true;
  languages.lua.package = unstable.lua;

}
