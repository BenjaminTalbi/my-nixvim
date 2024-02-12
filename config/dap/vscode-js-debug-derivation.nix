{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "vscode-js-debug";
  src = ./out;
  installPhase = ''
    mkdir -p $out/out
    cp -R ./* $out/out
  '';
}

