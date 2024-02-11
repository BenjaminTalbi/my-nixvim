#!/bin/sh
set -e

echo "Delete pre-existing vscode-js-debug folder..."
rm -rf "vscode-js-debug"


REPO="microsoft/vscode-js-debug"
VERSION=$(curl --silent "https://api.github.com/repos/${REPO}/releases/latest" | grep -Po "(?<=\"tag_name\": \").*(?=\")")

echo "Current version is: ${VERSION}"
git clone --branch v1.86.1 https://github.com/microsoft/vscode-js-debug

cd vscode-js-debug
npm install --legacy-peer-deps
npx gulp vsDebugServerBundle
mv dist out

find . -mindepth 1 ! -path "./out/*" -delete
