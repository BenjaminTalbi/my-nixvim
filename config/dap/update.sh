#!/bin/sh
set -e

GIT_FOLDER="vscode-js-debug"
echo "Delete pre-existing vscode-js-debug folder..."
rm -rf $GIT_FOLDER


REPO="microsoft/vscode-js-debug"
VERSION=$(curl --silent "https://api.github.com/repos/${REPO}/releases/latest" | grep -Po "(?<=\"tag_name\": \").*(?=\")")

echo "Current version is: ${VERSION}"
git clone --branch v1.86.1 https://github.com/microsoft/vscode-js-debug

cd $GIT_FOLDER 
npm install --legacy-peer-deps
npx gulp vsDebugServerBundle
mv dist ../out

cd ..
rm -rf $GIT_FOLDER
