{ pkgs }:

pkgs.stdenv.mkDerivation {
  pname = "vscode-js-debug";
  version = "v1.86.1";

  src = pkgs.fetchFromGitHub {
    owner = "microsoft";
    repo = "vscode-js-debug"; 
    rev = "61adc31bbc0fabdc620ba5202d71d92189c55b81";
    hash = "sha256-EkGsKmHm7OlGFksnwwjh0jXAl0mWXTRu4cpjTeO2GWk=";
  };

  nativeBuildInputs = with pkgs; [
    nodejs_21
  ];
    
  buildPhase = '' 
    npm install --legacy-peer-deps
    npx gulp vsDebugServerBundle
  '';

  installPhase = ''
    mkdir -p $out
    cp -R dist/* $out/
  '';
}
