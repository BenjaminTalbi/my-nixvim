{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "vscode-js-debug";
  src = ./vscode-js-debug/out;
  installPhase = ''
    mkdir -p $out/out
    cp -R ./* $out/out
  '';
}

