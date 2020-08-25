#!/bin/bash
set -eu

readonly VERSION=1.48.1

readonly DIR_ROOT=$(pwd)/src/${VERSION}
readonly DIR_VSCODE=${DIR_ROOT}/vscode
readonly FILE_PRODUCT_JSON=${DIR_VSCODE}/product.json

function init_dir()
{
    mkdir -p ${DIR_ROOT}
}

function git_clone_vscode()
{
    [ -d ${DIR_VSCODE} ] && rm -rf ${DIR_VSCODE}
    git clone https://github.com/microsoft/vscode.git -b ${VERSION} ${DIR_VSCODE}
}

function edit_pruduct_json()
{
    sed -i -e 's/Code - OSS/Code-OSS-ARM64/g' ${FILE_PRODUCT_JSON}

    local pos=$(grep -n 'builtInExtensions' ${FILE_PRODUCT_JSON} | sed -e 's/:.*//g' )
    local pos2=$(( $pos-1 ))

    cat << EOF | sed -i "${pos2}r /dev/stdin" ${FILE_PRODUCT_JSON}
        "extensionsGallery": {
            "serviceUrl": "https://marketplace.visualstudio.com/_apis/public/gallery",
            "cacheUrl": "https://vscode.blob.core.windows.net/gallery/index",
            "itemUrl": "https://marketplace.visualstudio.com/items"
        },
EOF
}

function build()
{
    cd ${DIR_VSCODE}
    yarn
    yarn run gulp vscode-linux-arm64
    yarn run gulp vscode-linux-arm64-build-deb
}

function copy_deb()
{
    cp -a $(find ${DIR_VSCODE} -name "*.deb") ${DIR_ROOT}/
}

init_dir

git_clone_vscode

edit_pruduct_json

build

copy_deb
